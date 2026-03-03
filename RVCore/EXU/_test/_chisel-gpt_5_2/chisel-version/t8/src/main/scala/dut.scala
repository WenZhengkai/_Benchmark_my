// package npc.core

import chisel3._
import chisel3.util._

// ------------------------------------------------------------
// Minimal infrastructure (base classes / parameters / enums)
// ------------------------------------------------------------
trait HasNPCParameter {
  val XLen: Int = 64
}

abstract class NPCBundle extends Bundle with HasNPCParameter
abstract class NPCModule extends Module with HasNPCParameter

trait TYPE_INST

// Functional unit type
object FuType extends ChiselEnum {
  val alu, lsu, csr = Value
}

// Operand select type (kept for compatibility; not used by dut directly)
object FuSrcType extends ChiselEnum {
  val reg, imm, pc, zero = Value
}

// Operation type encoding (implementation-specific; keep as UInt)
object FuOpType {
  def apply(): UInt = UInt(8.W)
}

// ------------------------------------------------------------
// Bundles from spec
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
  val MemWrite   = Bool()
  val ResSrc     = UInt(2.W)

  val fuSrc1Type = FuSrcType()
  val fuSrc2Type = FuSrcType()
  val fuType     = FuType()
  val fuOpType   = FuOpType()

  val rs1  = UInt(5.W)
  val rs2  = UInt(5.W)
  val rfWen = Bool()
  val rd   = UInt(5.W)
}

class DataSrc extends NPCBundle {
  val fuSrc1 = UInt(XLen.W)
  val fuSrc2 = UInt(XLen.W)
  val imm    = UInt(XLen.W)

  // NOTE: This is described in the prompt; typically you wouldn't put Decoupled inside data.
  // We keep it to satisfy the interface but dut only drives its fields.
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

// Branch resolution bundle
class BruRes extends NPCBundle {
  val valid    = Bool()
  val targetPc = UInt(XLen.W)
}

// ------------------------------------------------------------
// Simple memory interface (placeholders)
// ------------------------------------------------------------
class ToMem extends NPCBundle {
  val valid = Bool()
  val addr  = UInt(XLen.W)
  val wdata = UInt(XLen.W)
  val wstrb = UInt((XLen / 8).W)
  val wen   = Bool()
}

class FromMem extends NPCBundle {
  val rvalid = Bool()
  val rdata  = UInt(XLen.W)
}

// ------------------------------------------------------------
// Handshake helper
// ------------------------------------------------------------
object HandShakeDeal {
  /**
    * One-stage, no internal buffering:
    * - out.valid mirrors in.valid unless AnyInvalidCondition
    * - in.ready mirrors out.ready unless AnyStopCondition
    */
  def apply[T <: Data](
    in: DecoupledIO[T],
    out: DecoupledIO[_],
    AnyInvalidCondition: Bool,
    AnyStopCodition: Bool
  ): Unit = {
    in.ready := out.ready && !AnyStopCodition
    out.valid := in.valid && !AnyInvalidCondition && !AnyStopCodition
  }
}

// ------------------------------------------------------------
// Functional units (minimal implementations to make dut complete)
// ------------------------------------------------------------
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

  // Pure combinational ALU (placeholder):
  // fuOpType[2:0]: 000 add, 001 sub, 010 and, 011 or, 100 xor, 101 slt, 110 sll, 111 srl
  val op = io.in.bits.fuOpType(2, 0)
  val a  = io.in.bits.srca
  val b  = io.in.bits.srcb

  val res = WireDefault(0.U(XLen.W))
  switch(op) {
    is("b000".U) { res := a + b }
    is("b001".U) { res := a - b }
    is("b010".U) { res := a & b }
    is("b011".U) { res := a | b }
    is("b100".U) { res := a ^ b }
    is("b101".U) { res := (a.asSInt < b.asSInt).asUInt }
    is("b110".U) { res := a << b(5, 0) }
    is("b111".U) { res := a >> b(5, 0) }
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
    val from_mem = Input(new FromMem)
    val to_mem   = Output(new ToMem)

    val ctrl = Input(new CtrlSignal)
    val data = Input(new DataSrc)

    val out = Decoupled(new LsuOut)
  })

  // Minimal LSU:
  // - For loads: return from_mem.rdata when from_mem.rvalid
  // - For stores: drive to_mem using ctrl.MemWrite and data.fuSrc*
  val isStore = io.ctrl.MemWrite
  val addr    = io.data.fuSrc1
  val wdata   = io.data.fuSrc2

  io.to_mem.valid := true.B
  io.to_mem.addr  := addr
  io.to_mem.wdata := wdata
  io.to_mem.wstrb := Fill(XLen / 8, 1.U(1.W))
  io.to_mem.wen   := isStore

  val loadValid = io.from_mem.rvalid && !isStore

  io.out.bits.rdata := io.from_mem.rdata
  io.out.valid      := loadValid
  // ready is ignored by this simple LSU; accept backpressure
  // by deasserting "out.valid" only when loadValid.
}

class CsrIn extends NPCBundle {
  val srca     = UInt(XLen.W)
  val srcb     = UInt(XLen.W)
  val fuOpType = FuOpType()
  val inst     = UInt(32.W)
  val pc       = UInt(XLen.W)
}
class Csr extends NPCModule {
  val io = IO(new Bundle {
    val in  = Flipped(Decoupled(new CsrIn))
    val out = Decoupled(UInt(XLen.W))
  })

  // Placeholder CSR: just pass-through srca for read result.
  io.out.bits  := io.in.bits.srca
  io.out.valid := io.in.valid
  io.in.ready  := io.out.ready
}

// ------------------------------------------------------------
// BRU resolver (placeholder policy)
// ------------------------------------------------------------
object CalBruRes {
  /**
    * Minimal branch/jump resolution:
    * If in.cf.isBranch, declare valid and use ALU result as target PC.
    * Otherwise invalid.
    */
  def apply(inBits: DecodeIO, alu0: Alu, csr0: Csr)(implicit p: HasNPCParameter): BruRes = {
    val bru = Wire(new BruRes)
    val isBru = inBits.cf.isBranch
    // When branch, use ALU output as computed target (common design: ALU computes pc+imm or rs1+imm)
    bru.valid := isBru
    bru.targetPc := alu0.io.out.bits
    bru
  }
}

// ------------------------------------------------------------
// dut
// ------------------------------------------------------------
class dut extends NPCModule with HasNPCParameter with TYPE_INST {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))
    val to_wbu   = Decoupled(new ExuToWbuIO)

    val to_mem   = new ToMem
    val from_mem = new FromMem

    val redirect = Output(new Redirect)
  })

  // 1) Output connection: default pass-through of cf/ctrl/data
  io.to_wbu.bits.cf   := io.from_isu.bits.cf
  io.to_wbu.bits.ctrl := io.from_isu.bits.ctrl
  io.to_wbu.bits.data := io.from_isu.bits.data

  // Default: sub-fields that are driven here
  io.to_wbu.bits.data.Alu0Res.valid := false.B
  io.to_wbu.bits.data.Alu0Res.bits  := 0.U
  io.to_wbu.bits.data.data_from_mem := 0.U
  io.to_wbu.bits.data.csrRdata      := 0.U

  // 2) Instantiate FUs
  val alu0 = Module(new Alu)
  val lsu0 = Module(new Lsu)
  val csr0 = Module(new Csr)

  val in  = io.from_isu
  val out = io.to_wbu

  val isAlu = in.bits.ctrl.fuType === FuType.alu
  val isLsu = in.bits.ctrl.fuType === FuType.lsu
  val isCsr = in.bits.ctrl.fuType === FuType.csr

  // ---- ALU wiring
  alu0.io.in.bits.srca     := in.bits.data.fuSrc1
  alu0.io.in.bits.srcb     := in.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := in.bits.ctrl.fuOpType
  alu0.io.in.valid         := in.valid && isAlu
  alu0.io.out.ready        := out.ready

  io.to_wbu.bits.data.Alu0Res.bits  := alu0.io.out.bits
  io.to_wbu.bits.data.Alu0Res.valid := alu0.io.out.valid

  // ---- LSU wiring
  lsu0.io.from_mem := io.from_mem
  lsu0.io.ctrl     := in.bits.ctrl
  lsu0.io.data     := in.bits.data

  // Memory request outward
  io.to_mem := lsu0.io.to_mem

  // LSU result to WBU
  lsu0.io.out.ready := out.ready
  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits.rdata

  // ---- CSR wiring
  csr0.io.in.bits.srca     := in.bits.data.fuSrc1
  csr0.io.in.bits.srcb     := in.bits.data.fuSrc2
  csr0.io.in.bits.fuOpType := in.bits.ctrl.fuOpType
  csr0.io.in.bits.inst     := in.bits.cf.inst
  csr0.io.in.bits.pc       := in.bits.cf.pc
  csr0.io.in.valid         := in.valid && isCsr
  csr0.io.out.ready        := out.ready

  io.to_wbu.bits.data.csrRdata := csr0.io.out.bits

  // 3) Branch/jump processing
  implicit val p: HasNPCParameter = this
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(in.bits, alu0, csr0)

  val predNextPc = in.bits.cf.next_pc
  val mispredict = bruRes.valid && (predNextPc =/= bruRes.targetPc)

  io.redirect.valid  := in.valid && bruRes.valid && mispredict
  io.redirect.target := bruRes.targetPc

  // Fix next_pc in output on mispredict
  when(mispredict) {
    io.to_wbu.bits.cf.next_pc := bruRes.targetPc
  }

  // 4) Handshake deal
  HandShakeDeal(
    io.from_isu,
    io.to_wbu,
    AnyInvalidCondition = false.B,
    AnyStopCodition     = io.redirect.valid && in.valid
  )
}
