// package npc.core.exu

import chisel3._
import chisel3.util._

// ================================================================
// Minimal framework (parameters / base classes)
// ================================================================
trait HasNPCParameter {
  val XLen: Int = 64
}

abstract class NPCBundle extends Bundle with HasNPCParameter
abstract class NPCModule extends Module with HasNPCParameter

// ================================================================
// Enums (FuType / FuOpType / FuSrcType) - provide what dut needs
// ================================================================
object FuType extends ChiselEnum {
  val alu, lsu, csr, none = Value
}
object FuOpType extends ChiselEnum {
  val nop = Value
  // extend as needed
}
object FuSrcType extends ChiselEnum {
  val reg, imm, pc = Value
}

// ================================================================
// Bundles from spec (and required missing ones)
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
  val MemWrite  = Bool()
  val ResSrc    = UInt(2.W)

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

  val Alu0Res       = Decoupled(UInt(XLen.W)) // driven by dut
  val data_from_mem = UInt(XLen.W)            // driven by dut/lsu
  val csrRdata      = UInt(XLen.W)            // driven by dut/csr
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

// ================================================================
// Memory interface (placeholders; adapt to your SoC)
// ================================================================
class ToMem extends NPCBundle {
  val valid = Output(Bool())
  val addr  = Output(UInt(XLen.W))
  val wdata = Output(UInt(XLen.W))
  val wmask = Output(UInt((XLen / 8).W))
  val isWr  = Output(Bool())
}

class FromMem extends NPCBundle {
  val valid = Input(Bool())
  val rdata = Input(UInt(XLen.W))
}

// ================================================================
// Branch result bundle (as described)
// ================================================================
class BruRes extends NPCBundle {
  val valid    = Bool()
  val targetPc = UInt(XLen.W)
}

// ================================================================
// Handshake helper
// ================================================================
object HandShakeDeal {
  /**
    * Basic decoupled pass-through handshake with optional stop/invalid.
    *
    * - If AnyInvalidCondition: force out.valid := false
    * - If AnyStopCondition:    block ready/valid transfer in this cycle
    */
  def apply[T <: Data](
      in:  DecoupledIO[T],
      out: DecoupledIO[T],
      AnyInvalidCondition: Bool,
      AnyStopCodition:     Bool
  ): Unit = {
    // ready backpressure
    in.ready := out.ready && !AnyStopCodition

    // valid forward
    out.valid := in.valid && !AnyInvalidCondition && !AnyStopCodition
  }
}

// ================================================================
// Functional units (simple placeholders; wire-compatible)
// Replace with your real implementations.
// ================================================================
class AluIn extends NPCBundle {
  val srca     = UInt(XLen.W)
  val srcb     = UInt(XLen.W)
  val fuOpType = FuOpType()
}
class ALU extends NPCModule {
  val io = IO(new Bundle {
    val in  = Flipped(Decoupled(new AluIn))
    val out = Decoupled(UInt(XLen.W))
  })
  io.in.ready := io.out.ready
  io.out.valid := io.in.valid
  io.out.bits := io.in.bits.srca + io.in.bits.srcb // placeholder
}

class LSU extends NPCModule {
  val io = IO(new Bundle {
    val ctrl     = Input(new CtrlSignal)
    val data     = Input(new DataSrc)
    val from_mem = new FromMem
    val to_mem   = new ToMem
    val out      = Decoupled(UInt(XLen.W)) // load data/result
  })

  // Placeholder: directly expose a simple single-beat mem request
  io.to_mem.valid := false.B
  io.to_mem.addr  := io.data.fuSrc1
  io.to_mem.wdata := io.data.fuSrc2
  io.to_mem.wmask := "hFF".U((XLen / 8).W)
  io.to_mem.isWr  := io.ctrl.MemWrite

  // Placeholder: treat from_mem.rdata as LSU result when valid
  io.out.bits  := io.from_mem.rdata
  io.out.valid := io.from_mem.valid
}

class CSR extends NPCModule {
  val io = IO(new Bundle {
    val in  = Flipped(Decoupled(new AluIn)) // reuse AluIn shape for operands/op
    val out = Decoupled(UInt(XLen.W))
  })
  io.in.ready := io.out.ready
  io.out.valid := io.in.valid
  io.out.bits := io.in.bits.srca // placeholder
}

// ================================================================
// BRU calculator (placeholder). Replace with real decode-based logic.
// Spec: bruRes := CalBruRes(inBits, alu0, csr0)
// ================================================================
object CalBruRes {
  def apply(inBits: DecodeIO, alu0: ALU, csr0: CSR): BruRes = {
    val bruRes = Wire(new BruRes)
    // Placeholder behavior: if isBranch, use ALU output as target
    // In a real design, this would use instruction type/op and operands.
    bruRes.valid := inBits.cf.isBranch
    bruRes.targetPc := alu0.io.out.bits
    bruRes
  }
}

// ================================================================
// dut
// ================================================================
class dut extends NPCModule {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))
    val to_wbu   = Decoupled(new ExuToWbuIO)
    val to_mem   = new ToMem
    val from_mem = new FromMem
    val redirect = Output(new Redirect)
  })

  // -----------------------------
  // 1) Output connection (pass-through first)
  // -----------------------------
  io.to_wbu.bits.cf   := io.from_isu.bits.cf
  io.to_wbu.bits.ctrl := io.from_isu.bits.ctrl
  io.to_wbu.bits.data := io.from_isu.bits.data

  // We will drive these "produced by EXU" fields
  io.to_wbu.bits.data.Alu0Res.valid := false.B
  io.to_wbu.bits.data.Alu0Res.bits  := 0.U
  io.to_wbu.bits.data.data_from_mem := 0.U
  io.to_wbu.bits.data.csrRdata      := 0.U

  // -----------------------------
  // 2) Instantiate and wire functional units
  // -----------------------------
  val alu0 = Module(new ALU)
  val lsu0 = Module(new LSU)
  val csr0 = Module(new CSR)

  // ALU wiring
  alu0.io.in.bits.srca     := io.from_isu.bits.data.fuSrc1
  alu0.io.in.bits.srcb     := io.from_isu.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  alu0.io.in.valid         := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.alu)
  alu0.io.out.ready        := io.to_wbu.ready

  io.to_wbu.bits.data.Alu0Res.bits  := alu0.io.out.bits
  io.to_wbu.bits.data.Alu0Res.valid := alu0.io.out.valid

  // LSU wiring
  lsu0.io.from_mem := io.from_mem
  lsu0.io.ctrl     := io.from_isu.bits.ctrl
  lsu0.io.data     := io.from_isu.bits.data
  lsu0.io.out.ready := io.to_wbu.ready

  // Gate LSU result validity by fuType (so lsu0 can still see mem but won't "commit" on non-LSU)
  val isLsu = io.from_isu.bits.ctrl.fuType === FuType.lsu
  io.to_wbu.bits.data.data_from_mem := Mux(lsu0.io.out.valid && isLsu, lsu0.io.out.bits, 0.U)

  // Connect to mem
  io.to_mem := lsu0.io.to_mem

  // CSR wiring
  csr0.io.in.bits.srca     := io.from_isu.bits.data.fuSrc1
  csr0.io.in.bits.srcb     := io.from_isu.bits.data.fuSrc2
  csr0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  csr0.io.in.valid         := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.csr)
  csr0.io.out.ready        := io.to_wbu.ready

  io.to_wbu.bits.data.csrRdata := Mux(csr0.io.out.valid, csr0.io.out.bits, 0.U)

  // -----------------------------
  // 3) Branch jump processing + redirect
  // -----------------------------
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  val predictedNext = io.from_isu.bits.cf.next_pc
  val actualTarget  = bruRes.targetPc
  val mispredict    = bruRes.valid && (predictedNext =/= actualTarget)

  io.redirect.valid  := io.from_isu.valid && mispredict
  io.redirect.target := actualTarget

  // Correct next_pc sent to WBU when mispredict happens
  io.to_wbu.bits.cf.next_pc := Mux(mispredict, actualTarget, io.from_isu.bits.cf.next_pc)

  // -----------------------------
  // 4) Handshake
  // -----------------------------
  HandShakeDeal(
    io.from_isu,
    io.to_wbu,
    AnyInvalidCondition = false.B,
    AnyStopCodition     = io.redirect.valid && io.from_isu.valid
  )
}
