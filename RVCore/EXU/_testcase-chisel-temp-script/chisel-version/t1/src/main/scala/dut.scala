import chisel3._
import chisel3.util._

class dut extends NPCModule with HasNPCParameter with TYPE_INST {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))
    val to_wbu   = Decoupled(new ExuToWbuIO)
    val to_mem   = new ToMem
    val from_mem = new FromMem
    val redirect = Output(new Redirect)
  })

  val in  = io.from_isu
  val out = io.to_wbu

  // --------------------------------------------------------------------------
  // Default pass-through: cf / ctrl / data (base fields)
  // --------------------------------------------------------------------------
  out.bits.cf   := in.bits.cf
  out.bits.ctrl := in.bits.ctrl

  out.bits.data.fuSrc1 := in.bits.data.fuSrc1
  out.bits.data.fuSrc2 := in.bits.data.fuSrc2
  out.bits.data.imm    := in.bits.data.imm
  out.bits.data.rfSrc1 := in.bits.data.rfSrc1
  out.bits.data.rfSrc2 := in.bits.data.rfSrc2

  // Default result fields
  out.bits.data.Alu0Res.bits  := 0.U
  out.bits.data.Alu0Res.valid := false.B
  out.bits.data.data_from_mem := 0.U
  out.bits.data.csrRdata      := 0.U

  // --------------------------------------------------------------------------
  // Functional units
  // --------------------------------------------------------------------------
  val alu0 = Module(new ALU)
  val lsu0 = Module(new LSU)
  val csr0 = Module(new CSR)

  // ALU
  alu0.io.in.bits.srca     := in.bits.data.fuSrc1
  alu0.io.in.bits.srcb     := in.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := in.bits.ctrl.fuOpType
  alu0.io.in.valid         := in.valid && (in.bits.ctrl.fuType === FuType.alu)
  alu0.io.out.ready        := out.ready

  out.bits.data.Alu0Res.bits  := alu0.io.out.bits
  out.bits.data.Alu0Res.valid := alu0.io.out.valid

  // LSU
  lsu0.io.in.bits.srca     := in.bits.data.fuSrc1
  lsu0.io.in.bits.srcb     := in.bits.data.fuSrc2
  lsu0.io.in.bits.fuOpType := in.bits.ctrl.fuOpType
  lsu0.io.in.valid         := in.valid && (in.bits.ctrl.fuType === FuType.lsu)
  lsu0.io.out.ready        := out.ready

  lsu0.io.from_mem := io.from_mem
  lsu0.io.ctrl     := in.bits.ctrl
  lsu0.io.data     := in.bits.data

  io.to_mem                 := lsu0.io.to_mem
  out.bits.data.data_from_mem := lsu0.io.out.bits

  // CSR
  csr0.io.in.bits.srca     := in.bits.data.fuSrc1
  csr0.io.in.bits.srcb     := in.bits.data.fuSrc2
  csr0.io.in.bits.fuOpType := in.bits.ctrl.fuOpType
  csr0.io.in.valid         := in.valid && (in.bits.ctrl.fuType === FuType.csr)
  csr0.io.out.ready        := out.ready

  out.bits.data.csrRdata := csr0.io.out.bits

  // --------------------------------------------------------------------------
  // BRU result + redirect generation
  // --------------------------------------------------------------------------
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(in.bits, alu0, csr0)

  val predErr = in.bits.cf.next_pc =/= bruRes.targetPc
  io.redirect.valid  := in.valid && bruRes.valid && predErr
  io.redirect.target := bruRes.targetPc

  when(io.redirect.valid) {
    out.bits.cf.next_pc := bruRes.targetPc
  }

  // --------------------------------------------------------------------------
  // Handshake handling
  // --------------------------------------------------------------------------
  HandShakeDeal(
    io.from_isu,
    io.to_wbu,
    AnyInvalidCondition = false.B,
    AnyStopCodition = io.redirect.valid && in.valid
  )
}
