import chisel3._
import chisel3.util._

class ScoreBoard(maxScore: Int, NR_GPR: Int) extends Module {
  val io = IO(new Bundle {
    val isBusy = Input(UInt(log2Ceil(NR_GPR).W))
    val mask = Input(UInt(log2Ceil(NR_GPR).W))
    val update = Input(new Bundle {
      val setMask = UInt(NR_GPR.W)
      val clearMask = UInt(NR_GPR.W)
    })
  })

  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Ceil(maxScore + 1).W))))

  def isBusy(idx: UInt): Bool = {
    busy(idx) =/= 0.U
  }

  def mask(idx: UInt): UInt = {
    (1.U << idx).asUInt()
  }

  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 1 until NR_GPR) {
      when(setMask(i) && clearMask(i)) {
        busy(i) := busy(i)
      }.elsewhen(setMask(i)) {
        busy(i) := Mux(busy(i) < maxScore.U, busy(i) + 1.U, busy(i))
      }.elsewhen(clearMask(i)) {
        busy(i) := Mux(busy(i) > 0.U, busy(i) - 1.U, busy(i))
      }.otherwise {
        busy(i) := busy(i)
      }
    }
  }
}

class WbuToRegIO(XLen: Int) extends Bundle {
  val rd = UInt(5.W)
  val Res = UInt(XLen.W)
  val RegWrite = Bool()
}

class CtrlFlow(XLen: Int) extends Bundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends Bundle {
  val MemWrite = Bool()
  val ResSrc = UInt()
  val fuSrc1Type = UInt()
  val fuSrc2Type = UInt()
  val fuType = UInt()
  val fuOpType = UInt()
  val rs1 = UInt(5.W)
  val rs2 = UInt(5.W)
  val rfWen = Bool()
  val rd = UInt(5.W)
}

class DataSrc(XLen: Int) extends Bundle {
  val fuSrc1 = UInt(XLen.W)
  val fuSrc2 = UInt(XLen.W)
  val imm = UInt(XLen.W)
  val Alu0Res = DecoupledIO(UInt(XLen.W))
  val data_from_mem = UInt(XLen.W)
  val csrRdata = UInt(XLen.W)
  val rfSrc1 = UInt(XLen.W)
  val rfSrc2 = UInt(XLen.W)
}

class DecodeIO(XLen: Int) extends Bundle {
  val cf = new CtrlFlow(XLen)
  val ctrl = new CtrlSignal
  val data = new DataSrc(XLen)
}

class dut(maxScore: Int, NR_GPR: Int, XLen: Int) extends Module {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO(XLen)))
    val to_exu = Decoupled(new DecodeIO(XLen))
    val wb = Input(new WbuToRegIO(XLen))
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  val sb = Module(new ScoreBoard(maxScore, NR_GPR))

  val AnyInvalidCondition = sb.io.isBusy(io.from_idu.bits.ctrl.rs1) || sb.io.isBusy(io.from_idu.bits.ctrl.rs2)

  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }

  def HandShakeDeal(in: DecoupledIO[DecodeIO], out: DecoupledIO[DecodeIO], condition: Bool): Unit = {
    out.valid := in.valid && !condition
    in.ready := out.ready && !condition
  }

  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  val (rs1, rs2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  io.to_exu.bits.data.fuSrc1 := MuxLookup(io.from_idu.bits.ctrl.fuSrc1Type, 0.U, Seq(
    "rfSrc1".U -> rs1,
    "pc".U -> io.from_idu.bits.cf.pc,
    "zero".U -> 0.U,
    "rfSrc2".U -> rs2,
    "imm".U -> io.from_idu.bits.data.imm,
    "four".U -> 4.U
  ))

  io.to_exu.bits.data.fuSrc2 := MuxLookup(io.from_idu.bits.ctrl.fuSrc2Type, 0.U, Seq(
    "rfSrc1".U -> rs1,
    "pc".U -> io.from_idu.bits.cf.pc,
    "zero".U -> 0.U,
    "rfSrc2".U -> rs2,
    "imm".U -> io.from_idu.bits.data.imm,
    "four".U -> 4.U
  ))

  val wbuClearMask = Mux(io.wb.RegWrite, sb.io.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(io.from_idu.bits.ctrl.rfWen && io.to_exu.fire, sb.io.mask(io.from_idu.bits.ctrl.rd), 0.U)
  sb.io.update.setMask := isFireSetMask
  sb.io.update.clearMask := wbuClearMask

  io.to_exu.bits := io.from_idu.bits
}
