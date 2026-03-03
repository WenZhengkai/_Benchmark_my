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
  // Functional units
  // --------------------------------------------------------------------------
  val alu0 = Module(new ALU)
  val lsu0 = Module(new LSU)
  val csr0 = Module(new CSR)

  val inBits = in.bits
  val isAlu  = inBits.ctrl.fuType === FuType.alu
  val isLsu  = inBits.ctrl.fuType === FuType.lsu
  val isCsr  = inBits.ctrl.fuType === FuType.csr

  // ALU wiring
  alu0.io.in.bits.srca     := inBits.data.fuSrc1
  alu0.io.in.bits.srcb     := inBits.data.fuSrc2
  alu0.io.in.bits.fuOpType := inBits.ctrl.fuOpType
  alu0.io.in.valid         := in.valid && isAlu
  alu0.io.out.ready        := out.ready

  // LSU wiring
  lsu0.io.in.bits.srca     := inBits.data.fuSrc1
  lsu0.io.in.bits.srcb     := inBits.data.fuSrc2
  lsu0.io.in.bits.fuOpType := inBits.ctrl.fuOpType
  lsu0.io.in.valid         := in.valid && isLsu
  lsu0.io.out.ready        := out.ready

  lsu0.io.from_mem         := io.from_mem
  lsu0.io.ctrl             := inBits.ctrl
  lsu0.io.data             := inBits.data
  io.to_mem                := lsu0.io.to_mem

  // CSR wiring
  csr0.io.in.bits.srca     := inBits.data.fuSrc1
  csr0.io.in.bits.srcb     := inBits.data.fuSrc2
  csr0.io.in.bits.fuOpType := inBits.ctrl.fuOpType
  csr0.io.in.valid         := in.valid && isCsr
  csr0.io.out.ready        := out.ready

  // --------------------------------------------------------------------------
  // Default output connection (cf/ctrl/data pass-through first)
  // --------------------------------------------------------------------------
  out.bits := DontCare
  out.bits.cf   := inBits.cf
  out.bits.ctrl := inBits.ctrl
  out.bits.data := inBits.data

  // FU result write-back fields
  out.bits.data.Alu0Res.bits  := alu0.io.out.bits
  out.bits.data.Alu0Res.valid := alu0.io.out.valid
  out.bits.data.data_from_mem := lsu0.io.out.bits
  out.bits.data.csrRdata      := csr0.io.out.bits

  // --------------------------------------------------------------------------
  // Branch/redirect
  // --------------------------------------------------------------------------
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(inBits, alu0, csr0)

  val predMiss = inBits.cf.next_pc =/= bruRes.targetPc

  io.redirect.valid  := in.valid && bruRes.valid && predMiss
  io.redirect.target := Mux(io.redirect.valid, bruRes.targetPc, 0.U)

  // Correct next_pc on mispredict
  out.bits.cf.next_pc := Mux(io.redirect.valid, bruRes.targetPc, inBits.cf.next_pc)

  // --------------------------------------------------------------------------
  // Handshake
  // --------------------------------------------------------------------------
  HandShakeDeal(
    in,
    out,
    AnyInvalidCondition = false.B,
    AnyStopCodition     = io.redirect.valid && in.valid
  )
}
