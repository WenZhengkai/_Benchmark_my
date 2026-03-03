// package npc

import chisel3._
import chisel3.util._

// -------------------- Common base --------------------
trait HasNPCParameter {
  val XLen: Int = 64
  val NR_GPR: Int = 32
}
abstract class NPCBundle extends Bundle with HasNPCParameter

// -------------------- Enums / Types --------------------
object FuSrcType extends ChiselEnum {
  val rfSrc1, pc, zero, rfSrc2, imm, four = Value
}
object FuType extends ChiselEnum {
  val none = Value
}
object FuOpType extends ChiselEnum {
  val none = Value
}

// -------------------- Bundles --------------------
class CtrlFlow extends NPCBundle {
  val inst     = UInt(32.W)
  val pc       = UInt(XLen.W)
  val next_pc  = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite   = Bool()
  val ResSrc     = UInt() // left width-unspecified by spec
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

// -------------------- ScoreBoard --------------------
class ScoreBoard(val maxScore: Int) extends HasNPCParameter {
  require(maxScore >= 1, "maxScore must be >= 1")

  private val scoreW = log2Ceil(maxScore + 1)
  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(scoreW.W))))

  def isBusy(idx: UInt): Bool = {
    Mux(idx === 0.U, false.B, busy(idx) =/= 0.U)
  }

  def mask(idx: UInt): UInt = {
    (1.U(NR_GPR.W) << idx)(NR_GPR - 1, 0)
  }

  def update(setMask: UInt, clearMask: UInt): Unit = {
    require(setMask.getWidth == NR_GPR)
    require(clearMask.getWidth == NR_GPR)

    for (i <- 0 until NR_GPR) {
      if (i == 0) {
        busy(0) := 0.U
      } else {
        val set   = setMask(i)
        val clear = clearMask(i)
        val cur   = busy(i)

        when(set && clear) {
          busy(i) := cur
        }.elsewhen(set) {
          when(cur < maxScore.U) { busy(i) := cur + 1.U } .otherwise { busy(i) := cur }
        }.elsewhen(clear) {
          when(cur =/= 0.U) { busy(i) := cur - 1.U } .otherwise { busy(i) := cur }
        }.otherwise {
          busy(i) := cur
        }
      }
    }
  }
}

// -------------------- Handshake helper --------------------
object HandShakeDeal {
  // If block is true => output invalid + input not-ready
  def apply(in: DecoupledIO[DecodeIO], out: DecoupledIO[DecodeIO], block: Bool): Unit = {
    out.valid := in.valid && !block
    in.ready  := out.ready && !block
  }
}

// -------------------- dut: ISU --------------------
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

  // Default pass-through
  io.to_exu.bits := io.from_idu.bits

  // ---------------- Data hazard detection ----------------
  val sb = new ScoreBoard(3)

  val inBits = io.from_idu.bits
  val rs1    = inBits.ctrl.rs1
  val rs2    = inBits.ctrl.rs2

  val rs1Busy = sb.isBusy(rs1)
  val rs2Busy = sb.isBusy(rs2)

  val anyInvalidCondition = rs1Busy || rs2Busy

  // Handshake control
  HandShakeDeal(io.from_idu, io.to_exu, anyInvalidCondition)

  // ---------------- Regfile connection function ----------------
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }
  val (rf1, rf2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  // ---------------- Operand processing ----------------
  val src1 = Wire(UInt(XLen.W))
  val src2 = Wire(UInt(XLen.W))

  src1 := MuxLookup(inBits.ctrl.fuSrc1Type.asUInt, rf1, Seq(
    FuSrcType.rfSrc1.asUInt -> rf1,
    FuSrcType.pc.asUInt     -> inBits.cf.pc,
    FuSrcType.zero.asUInt   -> 0.U
  ))

  src2 := MuxLookup(inBits.ctrl.fuSrc2Type.asUInt, rf2, Seq(
    FuSrcType.rfSrc2.asUInt -> rf2,
    FuSrcType.imm.asUInt    -> inBits.data.imm,
    FuSrcType.four.asUInt   -> 4.U
  ))

  io.to_exu.bits.data.fuSrc1 := src1
  io.to_exu.bits.data.fuSrc2 := src2

  // ---------------- Scoreboard update ----------------
  val wbuClearMask   = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U(NR_GPR.W))
  val isFireSetMask  = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U(NR_GPR.W))
  sb.update(isFireSetMask, wbuClearMask)
}
