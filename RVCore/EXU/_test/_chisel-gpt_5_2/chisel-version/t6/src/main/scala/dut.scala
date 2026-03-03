// package npc.exu

import chisel3._
import chisel3.util._

// ------------------------------------------------------------
// Minimal infrastructure (so this file is "complete").
// If your project already defines these, remove duplicates and
// import from your common package instead.
// ------------------------------------------------------------
trait HasNPCParameter {
  val XLen: Int = 64
}
abstract class NPCModule extends Module with HasNPCParameter
abstract class NPCBundle extends Bundle with HasNPCParameter

// ------------------------------------------------------------
// Enums / types
// ------------------------------------------------------------
object FuType extends ChiselEnum {
  val alu, lsu, csr, none = Value
}
object FuOpType extends ChiselEnum {
  val add, sub, and, or, xor, sll, srl, sra, slt, sltu,
      // branch / jump / misc
      beq, bne, blt, bge, bltu, bgeu, jal, jalr,
      // lsu
      lb, lh, lw, ld, lbu, lhu, lwu, sb, sh, sw, sd,
      // csr
      csrrw, csrrs, csrrc = Value
}
object FuSrcType extends ChiselEnum {
  val reg, imm, pc, zero = Value
}

// ------------------------------------------------------------
// Bundles from the prompt
// ------------------------------------------------------------
class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid  = Bool()
}

class CtrlFlow extends NPCBundle {
  val inst     = UInt(32.W)
  val pc       = UInt(XLen.W)
  val next_pc  = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite  = Bool()
  val ResSrc    = UInt(3.W) // width not specified, choose a small default

  val fuSrc1Type = FuSrcType()
  val fuSrc2Type = FuSrcType()
  val fuType     = FuType()
  val fuOpType   = FuOpType()
  val rs1        = UInt(5.W)
  val rs2        = UInt(5.W)
  val rfWen      = Bool()
  val rd         = UInt(5.W)
}

class DataSrc extends NPCBundle {
  val fuSrc1 = UInt(XLen.W)
  val fuSrc2 = UInt(XLen.W)
  val imm    = UInt(XLen.W)

  val Alu0Res       = Decoupled(UInt(XLen.W))
  val data_from_mem = UInt(XLen.W)
  val csrRdata      = UInt(XLen.W)
  val rfSrc1        = UInt(XLen.W)
  val rfSrc2        = UInt(XLen.W)
}

class DecodeIO extends NPCBundle {
  val cf   = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

class ExuToWbuIO extends NPCBundle {
  val cf   = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

class BruRes extends NPCBundle {
  val valid    = Bool()
  val targetPc = UInt(XLen.W)
}

// ------------------------------------------------------------
// LSU <-> Memory placeholder bundles
// (adapt to your real cache/mem interface if you already have one)
// ------------------------------------------------------------
class ToMem extends NPCBundle {
  val valid = Output(Bool())
  val addr  = Output(UInt(XLen.W))
  val wdata = Output(UInt(XLen.W))
  val wmask = Output(UInt((XLen / 8).W))
  val isWr  = Output(Bool())
}
class FromMem extends NPCBundle {
  val rdata = Input(UInt(XLen.W))
  val ready = Input(Bool())
}

// ------------------------------------------------------------
// Functional units (simple placeholders; replace with your real ones)
// ------------------------------------------------------------
class AluIn extends NPCBundle {
  val srca     = UInt(XLen.W)
  val srcb     = UInt(XLen.W)
  val fuOpType = FuOpType()
}
class AluOut extends NPCBundle {
  val result = UInt(XLen.W)
}
class ALU extends NPCModule {
  val io = IO(new Bundle {
    val in  = Flipped(Decoupled(new AluIn))
    val out = Decoupled(UInt(XLen.W))
  })

  // purely combinational, always ready/valid pass-through
  io.in.ready := io.out.ready
  io.out.valid := io.in.valid

  val a = io.in.bits.srca
  val b = io.in.bits.srcb
  val shamt = b(5, 0)

  val res = WireDefault(0.U(XLen.W))
  switch(io.in.bits.fuOpType) {
    is(FuOpType.add)  { res := a + b }
    is(FuOpType.sub)  { res := a - b }
    is(FuOpType.and)  { res := a & b }
    is(FuOpType.or)   { res := a | b }
    is(FuOpType.xor)  { res := a ^ b }
    is(FuOpType.sll)  { res := a << shamt }
    is(FuOpType.srl)  { res := a >> shamt }
    is(FuOpType.sra)  { res := (a.asSInt >> shamt).asUInt }
    is(FuOpType.slt)  { res := (a.asSInt < b.asSInt).asUInt }
    is(FuOpType.sltu) { res := (a < b).asUInt }
  }
  io.out.bits := res
}

class LSU extends NPCModule {
  val io = IO(new Bundle {
    val in       = Flipped(Decoupled(new DecodeIO)) // take whole decode for simplicity
    val out      = Decoupled(UInt(XLen.W))          // load data (or store "ok" code)
    val to_mem   = new ToMem
    val from_mem = new FromMem
  })

  // Simple "single-cycle" placeholder:
  // - load returns from_mem.rdata
  // - store returns 0
  // This is not a real LSU; it only wires signals.

  val isLsu = io.in.bits.ctrl.fuType === FuType.lsu
  val isStore = io.in.bits.ctrl.MemWrite

  io.to_mem.valid := io.in.valid && isLsu
  io.to_mem.addr  := io.in.bits.data.fuSrc1
  io.to_mem.wdata := io.in.bits.data.fuSrc2
  io.to_mem.wmask := Fill(XLen / 8, 1.U(1.W))
  io.to_mem.isWr  := isStore

  io.in.ready := io.out.ready // simplistic backpressure

  io.out.valid := io.in.valid && isLsu
  io.out.bits  := Mux(isStore, 0.U, io.from_mem.rdata)
}

class CSR extends NPCModule {
  val io = IO(new Bundle {
    val in  = Flipped(Decoupled(new DecodeIO))
    val out = Decoupled(UInt(XLen.W))
  })
  // Placeholder CSR: always returns 0, handshake passthrough.
  val isCsr = io.in.bits.ctrl.fuType === FuType.csr
  io.in.ready := io.out.ready
  io.out.valid := io.in.valid && isCsr
  io.out.bits := 0.U
}

// ------------------------------------------------------------
// Handshake utility as requested
// ------------------------------------------------------------
object HandShakeDeal {
  def apply(in: DecoupledIO[DecodeIO],
            out: DecoupledIO[ExuToWbuIO],
            AnyInvalidCondition: Bool,
            AnyStopCodition: Bool): Unit = {
    // Typical skidless single-stage handshake:
    // - out.valid follows in.valid unless invalid condition
    // - in.ready follows out.ready unless stop
    out.valid := in.valid && !AnyInvalidCondition && !AnyStopCodition
    in.ready  := out.ready && !AnyStopCodition
  }
}

// ------------------------------------------------------------
// BRU result calculation (as requested to be a method)
// ------------------------------------------------------------
object CalBruRes {
  def apply(inBits: DecodeIO, alu0: ALU, csr0: CSR): BruRes = {
    val r = Wire(new BruRes)
    r.valid := false.B
    r.targetPc := 0.U

    // Minimal branch/jump detection based on CtrlFlow.isBranch and fuOpType
    val op = inBits.ctrl.fuOpType
    val pc = inBits.cf.pc
    val next = inBits.cf.next_pc
    val src1 = inBits.data.fuSrc1
    val src2 = inBits.data.fuSrc2
    val imm  = inBits.data.imm

    val taken = WireDefault(false.B)
    switch(op) {
      is(FuOpType.beq)  { taken := src1 === src2 }
      is(FuOpType.bne)  { taken := src1 =/= src2 }
      is(FuOpType.blt)  { taken := src1.asSInt < src2.asSInt }
      is(FuOpType.bge)  { taken := src1.asSInt >= src2.asSInt }
      is(FuOpType.bltu) { taken := src1 < src2 }
      is(FuOpType.bgeu) { taken := src1 >= src2 }
      is(FuOpType.jal)  { taken := true.B }
      is(FuOpType.jalr) { taken := true.B }
    }

    val isJal  = op === FuOpType.jal
    val isJalr = op === FuOpType.jalr
    val isBr   = inBits.cf.isBranch

    val target = Wire(UInt(inBits.XLen.W))
    target := Mux(isJalr, (src1 + imm) & (~1.U(inBits.XLen.W)), pc + imm)

    r.valid := (isBr || isJal || isJalr) && taken
    r.targetPc := target

    // if not taken branch, "actual target" is fall-through (pc+4)
    when(isBr && !taken) {
      r.valid := true.B
      r.targetPc := pc + 4.U
    }

    r
  }
}

// ------------------------------------------------------------
// dut
// ------------------------------------------------------------
class dut extends NPCModule {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))
    val to_wbu   = Decoupled(new ExuToWbuIO)
    val to_mem   = new ToMem
    val from_mem = new FromMem
    val redirect = Output(new Redirect)
  })

  // 1) Output connection: connect cf/ctrl/data first (defaults)
  io.to_wbu.bits.cf   := io.from_isu.bits.cf
  io.to_wbu.bits.ctrl := io.from_isu.bits.ctrl
  io.to_wbu.bits.data := io.from_isu.bits.data

  // Instantiate FUs
  val alu0 = Module(new ALU)
  val lsu0 = Module(new LSU)
  val csr0 = Module(new CSR)

  // Common inputs for ALU
  alu0.io.in.bits.srca     := io.from_isu.bits.data.fuSrc1
  alu0.io.in.bits.srcb     := io.from_isu.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType

  // LSU wiring (as requested: from_mem, ctrl, data)
  lsu0.io.from_mem <> io.from_mem
  lsu0.io.in.bits   := io.from_isu.bits

  // CSR wiring
  csr0.io.in.bits := io.from_isu.bits

  // Determine which FU is selected
  val isAlu = io.from_isu.bits.ctrl.fuType === FuType.alu
  val isLsu = io.from_isu.bits.ctrl.fuType === FuType.lsu
  val isCsr = io.from_isu.bits.ctrl.fuType === FuType.csr

  // Drive valid to each FU
  alu0.io.in.valid := io.from_isu.valid && isAlu
  lsu0.io.in.valid := io.from_isu.valid && isLsu
  csr0.io.in.valid := io.from_isu.valid && isCsr

  // All FU outputs are consumed by WBU, so ready comes from io.to_wbu.ready
  alu0.io.out.ready := io.to_wbu.ready
  lsu0.io.out.ready := io.to_wbu.ready
  csr0.io.out.ready := io.to_wbu.ready

  // 2) FU results to WBU data fields
  // (Decoupled field inside DataSrc for ALU result: provide bits/handshake)
  io.to_wbu.bits.data.Alu0Res.bits  := alu0.io.out.bits
  io.to_wbu.bits.data.Alu0Res.valid := alu0.io.out.valid
  alu0.io.out.ready                := io.to_wbu.ready && io.to_wbu.valid
  io.to_wbu.bits.data.Alu0Res.ready := io.to_wbu.ready && io.to_wbu.valid // informational

  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits
  io.to_wbu.bits.data.csrRdata      := csr0.io.out.bits

  // Memory port from LSU
  io.to_mem := lsu0.io.to_mem

  // 3) Branch/jump processing and redirect generation
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  val predPc   = io.from_isu.bits.cf.next_pc
  val actualPc = bruRes.targetPc
  val misPred  = bruRes.valid && (predPc =/= actualPc)

  io.redirect.valid  := io.from_isu.valid && bruRes.valid && misPred
  io.redirect.target := actualPc

  // Update outgoing next_pc to correct value on mispredict
  when(misPred) {
    io.to_wbu.bits.cf.next_pc := actualPc
  }

  // 4) Handshake
  // Stop when redirect fires while in.valid (as requested)
  HandShakeDeal(
    io.from_isu,
    io.to_wbu,
    AnyInvalidCondition = false.B,
    AnyStopCodition     = io.redirect.valid && io.from_isu.valid
  )

  // Make WBU valid depend on selected FU completion (typical for multi-FU)
  // (Keeps the prompt's HandShakeDeal but ensures result validity aligns.)
  val fuOutValid = Mux1H(Seq(
    isAlu -> alu0.io.out.valid,
    isLsu -> lsu0.io.out.valid,
    isCsr -> csr0.io.out.valid
  ).map { case (k, v) => (k, v) })

  // Override to_wbu.valid to require FU output valid as well
  io.to_wbu.valid := io.from_isu.valid && fuOutValid && !(io.redirect.valid && io.from_isu.valid)

  // Ready back to ISU: must be able to accept and FU must be ready
  val fuInReady = Mux1H(Seq(
    isAlu -> alu0.io.in.ready,
    isLsu -> lsu0.io.in.ready,
    isCsr -> csr0.io.in.ready
  ).map { case (k, v) => (k, v) })

  io.from_isu.ready := io.to_wbu.ready && fuInReady && !(io.redirect.valid && io.from_isu.valid)
}
