import chisel3._
import chisel3.util._
import chisel3.experimental._

// Common Bundles and Parameters
class Redirect extends Bundle {
  val target = UInt(XLen.W)
  val valid = Bool()
}

class WbuToRegIO extends Bundle {
  val rd = UInt(5.W)
  val Res = UInt(XLen.W)
  val RegWrite = Bool()
}

class CtrlFlow extends Bundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends Bundle {
  val MemWrite = Bool()
  val ResSrc = UInt()
  val fuSrc1Type = UInt(3.W)
  val fuSrc2Type = UInt(3.W)
  val fuType = UInt(3.W)
  val fuOpType = UInt(7.W)
  val rs1 = UInt(5.W)
  val rs2 = UInt(5.W)
  val rfWen = Bool()
  val rd = UInt(5.W)
}

class DataSrc extends Bundle {
  val fuSrc1 = UInt(XLen.W)
  val fuSrc2 = UInt(XLen.W)
  val imm = UInt(XLen.W)
  val Alu0Res = DecoupledIO(UInt(XLen.W))
  val data_from_mem = UInt(XLen.W)
  val csrRdata = UInt(XLen.W)
  val rfSrc1 = UInt(XLen.W)
  val rfSrc2 = UInt(XLen.W)
}

class DecodeIO extends Bundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// IFU Module
class IFU_LLM2 extends Module {
  val io = IO(new Bundle {
    val inst = Input(UInt(32.W))
    val redirect = Input(new Redirect)
    val to_idu = DecoupledIO(new CtrlFlow)
    val pc = Output(UInt(XLen.W))
  })

  val pcReg = RegInit(0x80000000.U(XLen.W))
  val nextPc = Wire(UInt(XLen.W))

  // Simple branch prediction: PC + 4
  nextPc := pcReg + 4.U

  // Update PC register
  when(io.redirect.valid) {
    pcReg := io.redirect.target
  }.otherwise {
    pcReg := nextPc
  }

  // Outputs
  io.pc := pcReg
  io.to_idu.bits.inst := io.inst
  io.to_idu.bits.pc := pcReg
  io.to_idu.bits.next_pc := nextPc
  io.to_idu.bits.isBranch := false.B
  io.to_idu.valid := true.B
}

// IDU Module
class IDU_LLM2 extends Module {
  val io = IO(new Bundle {
    val from_ifu = Flipped(DecoupledIO(new CtrlFlow))
    val to_isu = DecoupledIO(new DecodeIO)
  })

  // Instruction decoding logic
  val inst = io.from_ifu.bits.inst
  val instType = Wire(UInt(4.W))
  val fuType = Wire(UInt(3.W))
  val fuOpType = Wire(UInt(7.W))
  val fuSrc1Type = Wire(UInt(3.W))
  val fuSrc2Type = Wire(UInt(3.W))

  // Example decoding for ADDI
  when(inst(6, 0) === "b0010011".U) {
    instType := "b0100".U // TYPE_I
    fuType := "b000".U // FuType.alu
    fuOpType := "b0000000".U // ALUOpType.add
    fuSrc1Type := "b000".U // FuSrcType.rfSrc1
    fuSrc2Type := "b011".U // FuSrcType.imm
  }.otherwise {
    instType := "b0000".U // TYPE_N
    fuType := "b000".U // FuType.alu
    fuOpType := "b0000000".U // ALUOpType.sll
    fuSrc1Type := "b100".U // FuSrcType.zero
    fuSrc2Type := "b100".U // FuSrcType.zero
  }

  // Control signal generation
  io.to_isu.bits.ctrl.MemWrite := false.B
  io.to_isu.bits.ctrl.ResSrc := 0.U
  io.to_isu.bits.ctrl.fuSrc1Type := fuSrc1Type
  io.to_isu.bits.ctrl.fuSrc2Type := fuSrc2Type
  io.to_isu.bits.ctrl.fuType := fuType
  io.to_isu.bits.ctrl.fuOpType := fuOpType
  io.to_isu.bits.ctrl.rs1 := inst(19, 15)
  io.to_isu.bits.ctrl.rs2 := inst(24, 20)
  io.to_isu.bits.ctrl.rfWen := instType(2)
  io.to_isu.bits.ctrl.rd := inst(11, 7)

  // Immediate extension
  val imm = Wire(UInt(XLen.W))
  imm := Cat(Fill(XLen - 12, inst(31)), inst(31, 20))
  io.to_isu.bits.data.imm := imm

  // Handshake logic
  io.to_isu.bits.cf := io.from_ifu.bits
  io.to_isu.valid := io.from_ifu.valid
  io.from_ifu.ready := io.to_isu.ready
}

// ISU Module
class ISU_LLM2 extends Module {
  val io = IO(new Bundle {
    val from_idu = Flipped(DecoupledIO(new DecodeIO))
    val to_exu = DecoupledIO(new DecodeIO)
    val wb = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  // Scoreboard logic
  val sb = new ScoreBoard(3)
  val isBusy = sb.isBusy(io.from_idu.bits.ctrl.rs1) || sb.isBusy(io.from_idu.bits.ctrl.rs2)
  val anyInvalidCondition = isBusy

  // Handshake logic
  io.to_exu.bits := io.from_idu.bits
  io.to_exu.valid := io.from_idu.valid && !anyInvalidCondition
  io.from_idu.ready := io.to_exu.ready && !anyInvalidCondition

  // Scoreboard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(io.from_idu.bits.ctrl.rfWen && io.to_exu.fire, sb.mask(io.from_idu.bits.ctrl.rd), 0.U)
  sb.update(isFireSetMask, wbuClearMask)

  // Operand processing
  io.to_exu.bits.data.fuSrc1 := MuxLookup(io.from_idu.bits.ctrl.fuSrc1Type, 0.U, Seq(
    "b000".U -> io.from_reg.rfSrc1,
    "b010".U -> io.from_idu.bits.cf.pc,
    "b100".U -> 0.U
  ))
  io.to_exu.bits.data.fuSrc2 := MuxLookup(io.from_idu.bits.ctrl.fuSrc2Type, 0.U, Seq(
    "b001".U -> io.from_reg.rfSrc2,
    "b011".U -> io.from_idu.bits.data.imm,
    "b101".U -> 4.U
  ))
}

// dut Module
class dut extends Module {
  val io = IO(new Bundle {
    val redirect = Input(Bool())
    val inst = Input(UInt(32.W))
    val ifuredirect = Input(new Redirect)
    val wb = Input(new WbuToRegIO)
    val rfSrc1 = Input(UInt(XLen.W))
    val rfSrc2 = Input(UInt(XLen.W))
    val pc = Output(UInt(XLen.W))
    val to_exu = DecoupledIO(new DecodeIO)
    val rs1 = Output(UInt(5.W))
    val rs2 = Output(UInt(5.W))
  })

  // Submodule instantiation
  val ifu = Module(new IFU_LLM2)
  val idu = Module(new IDU_LLM2)
  val isu = Module(new ISU_LLM2)

  // Interconnections
  ifu.io.inst := io.inst
  ifu.io.redirect := io.ifuredirect
  io.pc := ifu.io.pc

  StageConnect(ifu.io.to_idu, idu.io.from_ifu, idu.io.to_isu.fire, io.redirect)
  StageConnect(idu.io.to_isu, isu.io.from_idu, isu.io.to_exu.fire, io.redirect)

  isu.io.wb := io.wb
  isu.io.from_reg.rfSrc1 := io.rfSrc1
  isu.io.from_reg.rfSrc2 := io.rfSrc2
  io.to_exu <> isu.io.to_exu

  val (rs1, rs2) = isu.rs1_rs2(io.rfSrc1, io.rfSrc2)
  io.rs1 := rs1
  io.rs2 := rs2
}

// Utility functions
object StageConnect {
  def apply[T <: Data](left: DecoupledIO[T], right: DecoupledIO[T], fire: Bool, flush: Bool): Unit = {
    right.bits := left.bits
    right.valid := left.valid && !flush
    left.ready := right.ready && !flush
  }
}

class ScoreBoard(maxScore: Int) {
  val NR_GPR = 32
  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Up(maxScore + 1).W))))

  def isBusy(idx: UInt): Bool = busy(idx) =/= 0.U
  def mask(idx: UInt): UInt = (1.U << idx).asUInt
  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 1 until NR_GPR) {
      when(setMask(i) && !clearMask(i)) {
        busy(i) := busy(i) + 1.U
      }.elsewhen(!setMask(i) && clearMask(i)) {
        busy(i) := busy(i) - 1.U
      }
    }
  }
}
