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
  // 1) Default pass-through from ISU to WBU
  // --------------------------------------------------------------------------
  out.bits.cf   := in.bits.cf
  out.bits.ctrl := in.bits.ctrl
  out.bits.data := in.bits.data

  // --------------------------------------------------------------------------
  // 2) Functional units: ALU / LSU / CSR
  // --------------------------------------------------------------------------
  val alu0 = Module(new ALU)
  val lsu0 = Module(new LSU)
  val csr0 = Module(new CSR)

  val isAlu = in.bits.ctrl.fuType === FuType.alu
  val isLsu = in.bits.ctrl.fuType === FuType.lsu
  val isCsr = in.bits.ctrl.fuType === FuType.csr

  // ALU wiring
  alu0.io.in.bits.srca     := in.bits.data.fuSrc1
  alu0.io.in.bits.srcb     := in.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := in.bits.ctrl.fuOpType
  alu0.io.in.valid         := in.valid && isAlu
  alu0.io.out.ready        := out.ready && isAlu

  // LSU wiring
  lsu0.io.in.bits.srca     := in.bits.data.fuSrc1
  lsu0.io.in.bits.srcb     := in.bits.data.fuSrc2
  lsu0.io.in.bits.fuOpType := in.bits.ctrl.fuOpType
  lsu0.io.in.valid         := in.valid && isLsu
  lsu0.io.out.ready        := out.ready && isLsu

  lsu0.io.from_mem <> io.from_mem
  io.to_mem        <> lsu0.io.to_mem
  lsu0.io.ctrl     := in.bits.ctrl
  lsu0.io.data     := in.bits.data

  // CSR wiring
  csr0.io.in.bits.srca     := in.bits.data.fuSrc1
  csr0.io.in.bits.srcb     := in.bits.data.fuSrc2
  csr0.io.in.bits.fuOpType := in.bits.ctrl.fuOpType
  csr0.io.in.valid         := in.valid && isCsr
  csr0.io.out.ready        := out.ready && isCsr

  // FU results to WBU data fields
  out.bits.data.Alu0Res.bits  := Mux(isAlu, alu0.io.out.bits, 0.U)
  out.bits.data.Alu0Res.valid := alu0.io.out.valid && isAlu
  out.bits.data.data_from_mem := Mux(isLsu, lsu0.io.out.bits, 0.U)
  out.bits.data.csrRdata      := Mux(isCsr, csr0.io.out.bits, 0.U)

  // --------------------------------------------------------------------------
  // 3) Branch/jump redirect
  // --------------------------------------------------------------------------
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(in.bits, alu0, csr0)

  val predMiss = in.bits.cf.next_pc =/= bruRes.targetPc
  io.redirect.valid  := in.valid && bruRes.valid && predMiss
  io.redirect.target := bruRes.targetPc

  when(io.redirect.valid) {
    out.bits.cf.next_pc := bruRes.targetPc
  }

  // --------------------------------------------------------------------------
  // 4) Handshake control
  // --------------------------------------------------------------------------
  HandShakeDeal(
    in,
    out,
    AnyInvalidCondition = false.B,
    AnyStopCodition = io.redirect.valid && in.valid
  )
}
