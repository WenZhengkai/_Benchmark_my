// package npc.exu

import chisel3._
import chisel3.util._

// ================================================================
// Minimal infrastructure (parameters / base classes / enums)
// ================================================================
trait HasNPCParameter {
  val XLen: Int = 64
}
abstract class NPCBundle extends Bundle with HasNPCParameter
abstract class NPCModule extends Module with HasNPCParameter

// ---------------- Enums / Types ----------------
object FuType extends ChiselEnum {
  val alu, lsu, csr, none = Value
}
object FuSrcType extends ChiselEnum {
  val reg, imm, pc, none = Value
}
object FuOpType extends ChiselEnum {
  val add, sub, and, or, xor, sll, srl, sra, slt, sltu,
      load, store,
      csrrw, csrrs, csrrc,
      branch, jal, jalr, none = Value
}

// ================================================================
// Bundles from spec (plus necessary completion)
// ================================================================
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
  val MemWrite   = Bool()
  val ResSrc     = UInt(2.W)

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
  val fuSrc1        = UInt(XLen.W)
  val fuSrc2        = UInt(XLen.W)
  val imm           = UInt(XLen.W)

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

// Branch result bundle
class BruRes extends NPCBundle {
  val valid    = Bool()
  val targetPc = UInt(XLen.W)
}

// ================================================================
// Memory interface (simple placeholder)
// ================================================================
class ToMem extends NPCBundle {
  val valid = Bool()
  val addr  = UInt(XLen.W)
  val wdata = UInt(XLen.W)
  val wen   = Bool()
  val wmask = UInt((XLen / 8).W)
}
class FromMem extends NPCBundle {
  val rdata = UInt(XLen.W)
  val ready = Bool()
}

// ================================================================
// Functional units (simple, self-contained)
// ================================================================
class AluIn extends NPCBundle {
  val srca     = UInt(XLen.W)
  val srcb     = UInt(XLen.W)
  val fuOpType = FuOpType()
}
class Alu extends NPCModule {
  val io = IO(new Bundle {
    val in  = Flipped(Decoupled(new AluIn))
    val out = Decoupled(UInt(XLen.W))
  })

  // Pure combinational ALU, decoupled passthrough
  val res = WireDefault(0.U(XLen.W))
  switch(io.in.bits.fuOpType) {
    is(FuOpType.add)  { res := io.in.bits.srca + io.in.bits.srcb }
    is(FuOpType.sub)  { res := io.in.bits.srca - io.in.bits.srcb }
    is(FuOpType.and)  { res := io.in.bits.srca & io.in.bits.srcb }
    is(FuOpType.or)   { res := io.in.bits.srca | io.in.bits.srcb }
    is(FuOpType.xor)  { res := io.in.bits.srca ^ io.in.bits.srcb }
    is(FuOpType.sll)  { res := io.in.bits.srca << io.in.bits.srcb(5,0) }
    is(FuOpType.srl)  { res := io.in.bits.srca >> io.in.bits.srcb(5,0) }
    is(FuOpType.sra)  { res := (io.in.bits.srca.asSInt >> io.in.bits.srcb(5,0)).asUInt }
    is(FuOpType.slt)  { res := (io.in.bits.srca.asSInt < io.in.bits.srcb.asSInt).asUInt }
    is(FuOpType.sltu) { res := (io.in.bits.srca < io.in.bits.srcb).asUInt }
    // For branch/jump op types, ALU may still compute target/address elsewhere; default 0 here.
  }

  io.out.bits  := res
  io.out.valid := io.in.valid
  io.in.ready  := io.out.ready
}

class LsuOut extends NPCBundle {
  val rdata = UInt(XLen.W)
}
class Lsu extends NPCModule {
  val io = IO(new Bundle {
    val in       = Flipped(Decoupled(new AluIn)) // reuse srca/srcb/fuOpType: srca=addr base, srcb=store data or offset
    val ctrl     = Input(new CtrlSignal)
    val data     = Input(new DataSrc)

    val to_mem   = Output(new ToMem)
    val from_mem = Input(new FromMem)

    val out      = Decoupled(new LsuOut)
  })

  val isLoad  = io.in.bits.fuOpType === FuOpType.load
  val isStore = io.in.bits.fuOpType === FuOpType.store

  // Simple address: srca + srcb (treat srcb as offset)
  val addr = io.in.bits.srca + io.in.bits.srcb

  io.to_mem.valid := io.in.valid && (isLoad || isStore)
  io.to_mem.addr  := addr
  io.to_mem.wdata := io.data.fuSrc2
  io.to_mem.wen   := io.ctrl.MemWrite && isStore
  io.to_mem.wmask := Fill(XLen / 8, 1.U(1.W))

  // Assume memory returns combinationally via from_mem (placeholder)
  io.out.bits.rdata := io.from_mem.rdata
  io.out.valid      := io.in.valid && isLoad
  io.in.ready       := io.out.ready // simplified
}

class CsrIn extends NPCBundle {
  val srca     = UInt(XLen.W)
  val srcb     = UInt(XLen.W)
  val fuOpType = FuOpType()
  val csrAddr  = UInt(12.W)
}
class Csr extends NPCModule {
  val io = IO(new Bundle {
    val in  = Flipped(Decoupled(new CsrIn))
    val out = Decoupled(UInt(XLen.W))
  })

  // Placeholder CSR file: single register array
  val csrFile = RegInit(VecInit(Seq.fill(4096)(0.U(XLen.W))))
  val rdata   = csrFile(io.in.bits.csrAddr)

  val wdata = WireDefault(rdata)
  switch(io.in.bits.fuOpType) {
    is(FuOpType.csrrw) { wdata := io.in.bits.srca }
    is(FuOpType.csrrs) { wdata := rdata | io.in.bits.srca }
    is(FuOpType.csrrc) { wdata := rdata & (~io.in.bits.srca).asUInt }
  }

  when(io.in.fire) {
    when(io.in.bits.fuOpType === FuOpType.csrrw ||
         io.in.bits.fuOpType === FuOpType.csrrs ||
         io.in.bits.fuOpType === FuOpType.csrrc) {
      csrFile(io.in.bits.csrAddr) := wdata
    }
  }

  io.out.bits  := rdata
  io.out.valid := io.in.valid
  io.in.ready  := io.out.ready
}

// ================================================================
// Handshake helper (as requested)
// ================================================================
object HandShakeDeal {
  def apply(in: DecoupledIO[DecodeIO],
            out: DecoupledIO[ExuToWbuIO],
            AnyInvalidCondition: Bool,
            AnyStopCodition: Bool): Unit = {

    // Default: single-stage pass-through; stop condition stalls output and back-pressures input
    out.valid := in.valid && !AnyInvalidCondition && !AnyStopCodition
    in.ready  := out.ready && !AnyInvalidCondition && !AnyStopCodition
  }
}

// ================================================================
// BRU result calculation helper
// ================================================================
object BruCalc {
  def CalBruRes(inBits: DecodeIO, alu0: Alu, csr0: Csr): BruRes = {
    val bru = Wire(new BruRes)
    bru.valid    := false.B
    bru.targetPc := 0.U

    val op = inBits.ctrl.fuOpType
    val pc = inBits.cf.pc
    val rs1 = inBits.data.fuSrc1
    val imm = inBits.data.imm

    when(op === FuOpType.jal) {
      bru.valid    := true.B
      bru.targetPc := pc + imm
    }.elsewhen(op === FuOpType.jalr) {
      bru.valid    := true.B
      bru.targetPc := (rs1 + imm) & (~1.U(XLen.W))
    }.elsewhen(op === FuOpType.branch) {
      // Placeholder: treat srca==srcb as taken
      val taken = (inBits.data.fuSrc1 === inBits.data.fuSrc2)
      bru.valid    := true.B
      bru.targetPc := Mux(taken, pc + imm, pc + 4.U)
    }

    bru
  }
}

// ================================================================
// dut implementation
// ================================================================
class dut extends NPCModule {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))
    val to_wbu   = Decoupled(new ExuToWbuIO)
    val to_mem   = new ToMem
    val from_mem = new FromMem
    val redirect = Output(new Redirect)
  })

  // 1) Output Connection: connect cf/ctrl/data first
  io.to_wbu.bits.cf   := io.from_isu.bits.cf
  io.to_wbu.bits.ctrl := io.from_isu.bits.ctrl
  io.to_wbu.bits.data := io.from_isu.bits.data

  // Instantiate FUs
  val alu0 = Module(new Alu)
  val lsu0 = Module(new Lsu)
  val csr0 = Module(new Csr)

  // ---------------- ALU wiring ----------------
  alu0.io.in.bits.srca     := io.from_isu.bits.data.fuSrc1
  alu0.io.in.bits.srcb     := io.from_isu.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  alu0.io.in.valid         := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.alu)
  alu0.io.out.ready        := io.to_wbu.ready

  // Drive ALU result into WBU payload
  io.to_wbu.bits.data.Alu0Res.bits  := alu0.io.out.bits
  io.to_wbu.bits.data.Alu0Res.valid := alu0.io.out.valid
  // This is a payload field; do not backpressure via it
  alu0.io.out.ready := io.to_wbu.ready

  // ---------------- LSU wiring ----------------
  lsu0.io.in.bits.srca     := io.from_isu.bits.data.fuSrc1
  lsu0.io.in.bits.srcb     := io.from_isu.bits.data.imm // common: base + imm
  lsu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  lsu0.io.in.valid         := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.lsu)
  lsu0.io.out.ready        := io.to_wbu.ready

  lsu0.io.from_mem := io.from_mem
  lsu0.io.ctrl     := io.from_isu.bits.ctrl
  lsu0.io.data     := io.from_isu.bits.data

  io.to_mem := lsu0.io.to_mem
  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits.rdata

  // ---------------- CSR wiring ----------------
  csr0.io.in.bits.srca     := io.from_isu.bits.data.fuSrc1
  csr0.io.in.bits.srcb     := io.from_isu.bits.data.fuSrc2
  csr0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  csr0.io.in.bits.csrAddr  := io.from_isu.bits.cf.inst(31, 20) // standard CSR encoding
  csr0.io.in.valid         := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.csr)
  csr0.io.out.ready        := io.to_wbu.ready

  io.to_wbu.bits.data.csrRdata := csr0.io.out.bits

  // 3) Branch jump processing
  val bruRes = Wire(new BruRes)
  bruRes := BruCalc.CalBruRes(io.from_isu.bits, alu0, csr0)

  val predictedNext = io.from_isu.bits.cf.next_pc
  val actualNext    = bruRes.targetPc
  val mispredict    = bruRes.valid && (predictedNext =/= actualNext)

  io.redirect.valid  := io.from_isu.valid && mispredict
  io.redirect.target := actualNext

  // Update outgoing next_pc if mispredict detected (so WBU sees corrected path)
  when(mispredict) {
    io.to_wbu.bits.cf.next_pc := actualNext
  }

  // 4) Handshake signal processing
  // Stop when redirect is generated and input valid (as spec)
  HandShakeDeal(
    io.from_isu,
    io.to_wbu,
    AnyInvalidCondition = false.B,
    AnyStopCodition     = io.redirect.valid && io.from_isu.valid
  )
}
