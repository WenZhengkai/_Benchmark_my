import chisel3._
import chisel3.util._
import chisel3.experimental._

// Define common parameters and bundles
trait HasNPCParameter {
  val XLen = 32
  val NR_GPR = 32
  val IndependentBru = true
}

class NPCBundle extends Bundle with HasNPCParameter

// Redirect Bundle
class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid = Bool()
}

// WbuToRegIO Bundle
class WbuToRegIO extends NPCBundle {
  val rd = UInt(5.W)
  val Res = UInt(XLen.W)
  val RegWrite = Bool()
}

// CtrlFlow Bundle
class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

// DecodeIO Bundle
class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// CtrlSignal Bundle
class CtrlSignal extends NPCBundle {
  val MemWrite = Bool()
  val ResSrc = UInt()
  val fuSrc1Type = FuSrcType()
  val fuSrc2Type = FuSrcType()
  val fuType = FuType()
  val fuOpType = FuOpType()
  val rs1 = UInt(5.W)
  val rs2 = UInt(5.W)
  val rfWen = Bool()
  val rd = UInt(5.W)
}

// DataSrc Bundle
class DataSrc extends NPCBundle {
  val fuSrc1 = UInt(XLen.W)
  val fuSrc2 = UInt(XLen.W)
  val imm = UInt(XLen.W)
  val Alu0Res = Decoupled(UInt(XLen.W))
  val data_from_mem = UInt(XLen.W)
  val csrRdata = UInt(XLen.W)
  val rfSrc1 = UInt(XLen.W)
  val rfSrc2 = UInt(XLen.W)
}

// FuType Enumeration
object FuType extends HasNPCParameter {
  val num = 5
  val alu = "b000".U
  val lsu = "b001".U
  val mdu = "b010".U
  val csr = "b011".U
  val mou = "b100".U
  val bru = if (IndependentBru) "b101".U else alu
  def apply() = UInt(log2Up(num).W)
}

// FuOpType Enumeration
object FuOpType {
  def apply() = UInt(7.W)
}

// FuSrcType Enumeration
object FuSrcType {
  val rfSrc1 = "b000".U
  val rfSrc2 = "b001".U
  val pc = "b010".U
  val imm = "b011".U
  val zero = "b100".U
  val four = "b101".U
  def apply() = UInt(3.W)
}

// ScoreBoard Module
class ScoreBoard(maxScore: Int) extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val setMask = Input(UInt(NR_GPR.W))
    val clearMask = Input(UInt(NR_GPR.W))
    val isBusy = Output(UInt(NR_GPR.W))
  })

  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Up(maxScore + 1).W))))

  for (i <- 1 until NR_GPR) {
    when(io.setMask(i) && !io.clearMask(i)) {
      busy(i) := Mux(busy(i) < maxScore.U, busy(i) + 1.U, busy(i))
    }.elsewhen(!io.setMask(i) && io.clearMask(i)) {
      busy(i) := Mux(busy(i) > 0.U, busy(i) - 1.U, busy(i))
    }
  }

  io.isBusy := busy.asUInt
}

// IFU Module
class IFU extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val inst = Input(UInt(32.W))
    val redirect = Input(new Redirect)
    val to_idu = Decoupled(new CtrlFlow)
    val pc = Output(UInt(XLen.W))
  })

  val pcReg = RegInit("h80000000".U(XLen.W))
  val nextPc = Wire(UInt(XLen.W))

  // PC update logic
  when(io.redirect.valid) {
    nextPc := io.redirect.target
  }.otherwise {
    nextPc := pcReg + 4.U
  }

  pcReg := nextPc
  io.pc := pcReg

  // Control flow output
  io.to_idu.valid := true.B
  io.to_idu.bits.inst := io.inst
  io.to_idu.bits.pc := pcReg
  io.to_idu.bits.next_pc := nextPc
  io.to_idu.bits.isBranch := false.B
}

// IDU Module
class IDU extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val from_ifu = Flipped(Decoupled(new CtrlFlow))
    val to_isu = Decoupled(new DecodeIO)
  })

  // Instruction decoding logic
  val instType :: fuType :: fuOpType :: fuSrc1Type :: fuSrc2Type :: Nil = ListLookup(io.from_ifu.bits.inst, Instructions.DecodeDefault, Instructions.DecodeTable)

  // Control signal generation
  val ctrl = Wire(new CtrlSignal)
  ctrl.MemWrite := instType === "b0010".U
  ctrl.ResSrc := Mux(io.from_ifu.bits.inst(6, 0) === "b0000011".U, 1.U, Mux(io.from_ifu.bits.inst(6, 0) === "b1110011".U, 2.U, 0.U))
  ctrl.fuSrc1Type := fuSrc1Type
  ctrl.fuSrc2Type := fuSrc2Type
  ctrl.fuType := fuType
  ctrl.fuOpType := fuOpType
  ctrl.rs1 := io.from_ifu.bits.inst(19, 15)
  ctrl.rs2 := io.from_ifu.bits.inst(24, 20)
  ctrl.rfWen := instType(2, 2) === 1.U
  ctrl.rd := io.from_ifu.bits.inst(11, 7)

  // Immediate extension
  val imm = Wire(UInt(XLen.W))
  imm := MuxLookup(instType, 0.U, Seq(
    "b0100".U -> Cat(Fill(XLen - 12, io.from_ifu.bits.inst(31)), io.from_ifu.bits.inst(31, 20)),
    "b0110".U -> Cat(Fill(XLen - 20, io.from_ifu.bits.inst(31)), io.from_ifu.bits.inst(31, 12)),
    "b0111".U -> Cat(Fill(XLen - 21, io.from_ifu.bits.inst(31)), io.from_ifu.bits.inst(31), io.from_ifu.bits.inst(19, 12), io.from_ifu.bits.inst(20), io.from_ifu.bits.inst(30, 21), 0.U(1.W)),
    "b0010".U -> Cat(Fill(XLen - 12, io.from_ifu.bits.inst(31)), io.from_ifu.bits.inst(31, 25), io.from_ifu.bits.inst(11, 7)),
    "b0001".U -> Cat(Fill(XLen - 13, io.from_ifu.bits.inst(31)), io.from_ifu.bits.inst(31), io.from_ifu.bits.inst(7), io.from_ifu.bits.inst(30, 25), io.from_ifu.bits.inst(11, 8), 0.U(1.W))
  ))

  // Data source preparation
  val data = Wire(new DataSrc)
  data.imm := imm
  data <> DontCare

  // Output connection
  io.to_isu.valid := io.from_ifu.valid
  io.to_isu.bits.cf := io.from_ifu.bits
  io.to_isu.bits.ctrl := ctrl
  io.to_isu.bits.data := data
}

// ISU Module
class ISU extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu = Decoupled(new DecodeIO)
    val wb = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  val sb = Module(new ScoreBoard(3))

  // Data hazard detection
  val rs1Busy = sb.io.isBusy(io.from_idu.bits.ctrl.rs1)
  val rs2Busy = sb.io.isBusy(io.from_idu.bits.ctrl.rs2)
  val AnyInvalidCondition = rs1Busy || rs2Busy

  // Handshake processing
  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)

  // Operand processing
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (io.from_idu.bits.ctrl.rs1, io.from_idu.bits.ctrl.rs2)
  }

  val (rs1, rs2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  // Scoreboard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.io.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(io.from_idu.bits.ctrl.rfWen && io.to_exu.fire, sb.io.mask(io.from_idu.bits.ctrl.rd), 0.U)
  sb.io.update(isFireSetMask, wbuClearMask)

  // Connect Output
  io.to_exu.bits := io.from_idu.bits
}

// dut Module
class dut extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val redirect = Input(Bool())
    val inst = Input(UInt(32.W))
    val ifuredirect = Input(new Redirect)
    val wb = Input(new WbuToRegIO)
    val rfSrc1 = Input(UInt(XLen.W))
    val rfSrc2 = Input(UInt(XLen.W))
    val pc = Output(UInt(XLen.W))
    val to_exu = Decoupled(new DecodeIO)
    val rs1 = Output(UInt(5.W))
    val rs2 = Output(UInt(5.W))
  })

  val ifu = Module(new IFU)
  val idu = Module(new IDU)
  val isu = Module(new ISU)

  // Interconnections
  ifu.io.inst := io.inst
  io.pc := ifu.io.pc
  ifu.io.redirect := io.ifuredirect
  io.to_exu <> isu.io.to_exu
  isu.io.wb := io.wb
  io.rs1 := isu.io.from_idu.bits.ctrl.rs1
  io.rs2 := isu.io.from_idu.bits.ctrl.rs2

  // Stage connections
  StageConnect(ifu.io.to_idu, idu.io.from_ifu, idu.io.to_isu.fire, io.redirect)
  StageConnect(idu.io.to_isu, isu.io.from_idu, isu.io.to_exu.fire, io.redirect)
}

// Helper functions
object HandShakeDeal {
  def apply(in: DecoupledIO[CtrlFlow], out: DecoupledIO[DecodeIO], invalid: Bool): Unit = {
    out.valid := in.valid && !invalid
    in.ready := out.ready && !invalid
  }
}

object StageConnect {
  def apply(in: DecoupledIO[CtrlFlow], out: DecoupledIO[DecodeIO], fire: Bool, redirect: Bool): Unit = {
    out.valid := in.valid && !redirect
    in.ready := out.ready && !redirect
    when(fire) {
      out.bits := in.bits
    }
  }
}

// Instructions and decoding tables
object Instructions extends HasNPCParameter {
  val DecodeDefault = List("b0000".U, FuType.alu, ALUOpType.sll, FuSrcType.zero, FuSrcType.zero)
  val DecodeTable = Array(
    "b????????????_?????_000_?????_0010011".U -> List("b0100".U, FuType.alu, ALUOpType.add, FuSrcType.rfSrc1, FuSrcType.imm),
    // Add more instructions as needed
  )
}

// Main object to generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
