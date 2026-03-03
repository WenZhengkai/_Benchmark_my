// package npc

import chisel3._
import chisel3.util._

// -----------------------------
// Basic parameters / base bundle
// -----------------------------
trait HasNPCParameter {
  val XLen: Int = 64
  val NR_GPR: Int = 32
}

abstract class NPCBundle extends Bundle with HasNPCParameter

// -----------------------------
// Minimal type definitions used in DecodeIO
// (Your project may already define these. If so, remove duplicates.)
// -----------------------------
object FuSrcType extends ChiselEnum {
  val rfSrc1, rfSrc2, pc, imm, zero, four = Value
}
object FuType extends ChiselEnum {
  val alu, br, lsu, csr, mul, div, none = Value
}
object FuOpType extends ChiselEnum {
  val add, sub, and, or, xor, sll, srl, sra, slt, sltu, none = Value
}

// -----------------------------
// Bundles (as described)
// -----------------------------
class CtrlFlow extends NPCBundle {
  val inst     = UInt(32.W)
  val pc       = UInt(XLen.W)
  val next_pc  = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite   = Bool()
  val ResSrc     = UInt() // width left unspecified per spec (can be inferred elsewhere)
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

class WbuToRegIO extends NPCBundle {
  val rd       = UInt(5.W)
  val Res      = UInt(XLen.W)
  val RegWrite = Bool()
}

// -----------------------------
// ScoreBoard (normal class, counter per register)
// -----------------------------
class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  private val cntW = log2Ceil(maxScore + 1).max(1)
  val busy: Vec[UInt] = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(cntW.W))))

  def isBusy(idx: UInt): Bool = {
    Mux(idx === 0.U, false.B, busy(idx) =/= 0.U)
  }

  def mask(idx: UInt): UInt = {
    // one-hot; idx==0 still generates bit0=1, but update logic forces busy(0)=0
    (1.U(NR_GPR.W) << idx)(NR_GPR - 1, 0)
  }

  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 0 until NR_GPR) {
      if (i == 0) {
        busy(i) := 0.U
      } else {
        val set   = setMask(i)
        val clear = clearMask(i)
        val cur   = busy(i)

        when(set && clear) {
          busy(i) := cur
        }.elsewhen(set && !clear) {
          when(cur =/= maxScore.U) { busy(i) := cur + 1.U }.otherwise { busy(i) := cur }
        }.elsewhen(!set && clear) {
          when(cur =/= 0.U) { busy(i) := cur - 1.U }.otherwise { busy(i) := cur }
        }.otherwise {
          busy(i) := cur
        }
      }
    }
  }
}

// -----------------------------
// Handshake helper (block issue when invalid condition asserted)
// -----------------------------
object HandShakeDeal {
  def apply(in: DecoupledIO[DecodeIO], out: DecoupledIO[DecodeIO], anyInvalid: Bool): Unit = {
    out.valid := in.valid && !anyInvalid
    in.ready  := out.ready && !anyInvalid
  }
}

// -----------------------------
// ISU (dut)
// -----------------------------
class dut extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu   = Decoupled(new DecodeIO)
    val wb       = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  // Default: pass-through bits; we override fields we compute in this module
  io.to_exu.bits := io.from_idu.bits

  val inBits  = io.from_idu.bits
  val outBits = io.to_exu.bits

  // -----------------------------
  // Scoreboard hazard detection
  // -----------------------------
  val sb = new ScoreBoard(3)

  val rs1Busy = sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2)

  // If rs1/rs2 are busy, stall issue
  val AnyInvalidCondition = rs1Busy || rs2Busy

  // Handshake gating
  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  // -----------------------------
  // regfile connection function
  // -----------------------------
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    // override rfSrc in outgoing bundle for EXU visibility
    outBits.data.rfSrc1 := rfSrc1
    outBits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }

  val (rf1, rf2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  // -----------------------------
  // Operand processing
  // -----------------------------
  val src1 = Wire(UInt(XLen.W))
  val src2 = Wire(UInt(XLen.W))

  src1 := 0.U
  src2 := 0.U

  switch(inBits.ctrl.fuSrc1Type) {
    is(FuSrcType.rfSrc1) { src1 := rf1 }
    is(FuSrcType.pc)     { src1 := inBits.cf.pc }
    is(FuSrcType.zero)   { src1 := 0.U }
  }

  switch(inBits.ctrl.fuSrc2Type) {
    is(FuSrcType.rfSrc2) { src2 := rf2 }
    is(FuSrcType.imm)    { src2 := inBits.data.imm }
    is(FuSrcType.four)   { src2 := 4.U }
  }

  // override computed functional-unit operands
  outBits.data.fuSrc1 := src1
  outBits.data.fuSrc2 := src2

  // Keep IDU-provided imm as-is (already passed-through by := above)
  // outBits.data.imm remains inBits.data.imm

  // -----------------------------
  // Scoreboard update
  // -----------------------------
  val wbuClearMask   = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask  = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)

  // -----------------------------
  // Maintain Decoupled fields in DataSrc.Alu0Res
  // (Pass-through already, but ensure safe defaults if IDU leaves it unconnected)
  // -----------------------------
  // If your IDU always drives these, you can remove these two lines.
  outBits.data.Alu0Res.valid := inBits.data.Alu0Res.valid
  outBits.data.Alu0Res.bits  := inBits.data.Alu0Res.bits
}
