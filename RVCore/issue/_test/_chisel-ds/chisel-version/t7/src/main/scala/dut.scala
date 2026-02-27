import chisel3._
import chisel3.util._

// Define NPCBundle for extending Bundles
class NPCBundle extends Bundle {
  // Define common fields if necessary
}

// Define HasNPCParameter trait for parameters
trait HasNPCParameter {
  val NR_GPR: Int = 32
  val XLen: Int = 64
}

// Define ScoreBoard class
class ScoreBoard(maxScore: Int) extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val isBusy = Input(UInt(5.W))
    val mask = Input(UInt(5.W))
    val update = Input(new Bundle {
      val setMask = UInt(NR_GPR.W)
      val clearMask = UInt(NR_GPR.W)
    })
    val busy = Output(Vec(NR_GPR, UInt(log2Ceil(maxScore + 1).W)))
  })

  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Ceil(maxScore + 1).W))))

  // Function to check if a register is busy
  def isBusy(idx: UInt): Bool = {
    busy(idx) =/= 0.U
  }

  // Function to generate a mask
  def mask(idx: UInt): UInt = {
    (1.U << idx).asUInt
  }

  // Function to update the scoreboard
  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 0 until NR_GPR) {
      when(setMask(i) && !clearMask(i)) {
        busy(i) := Mux(busy(i) < maxScore.U, busy(i) + 1.U, busy(i))
      }.elsewhen(!setMask(i) && clearMask(i)) {
        busy(i) := Mux(busy(i) > 0.U, busy(i) - 1.U, busy(i))
      }
    }
  }

  // Connect IO
  io.busy := busy
}

// Define WbuToRegIO class
class WbuToRegIO extends NPCBundle with HasNPCParameter {
  val rd = UInt(5.W)
  val Res = UInt(XLen.W)
  val RegWrite = Bool()
}

// Define DecodeIO class
class DecodeIO extends NPCBundle with HasNPCParameter {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// Define CtrlFlow class
class CtrlFlow extends NPCBundle with HasNPCParameter {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

// Define CtrlSignal class
class CtrlSignal extends NPCBundle with HasNPCParameter {
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

// Define DataSrc class
class DataSrc extends NPCBundle with HasNPCParameter {
  val fuSrc1 = UInt(XLen.W)
  val fuSrc2 = UInt(XLen.W)
  val imm = UInt(XLen.W)
  val Alu0Res = Decoupled(UInt(XLen.W))
  val data_from_mem = UInt(XLen.W)
  val csrRdata = UInt(XLen.W)
  val rfSrc1 = UInt(XLen.W)
  val rfSrc2 = UInt(XLen.W)
}

// Define ISU module
class ISU(maxScore: Int) extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu = Decoupled(new DecodeIO)
    val wb = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  val sb = Module(new ScoreBoard(maxScore))

  val AnyInvalidCondition = sb.io.isBusy(io.from_idu.bits.ctrl.rs1) || sb.io.isBusy(io.from_idu.bits.ctrl.rs2)

  // Handshake signal handling
  when(AnyInvalidCondition) {
    io.from_idu.ready := false.B
    io.to_exu.valid := false.B
  }.otherwise {
    io.from_idu.ready := io.to_exu.ready
    io.to_exu.valid := io.from_idu.valid
  }

  // Connect register file
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    (rfSrc1, rfSrc2)
  }

  val (rs1, rs2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)

  // Operand processing
  io.to_exu.bits.data.fuSrc1 := MuxLookup(io.from_idu.bits.ctrl.fuSrc1Type, 0.U, Seq(
    FuSrcType.rfSrc1 -> rs1,
    FuSrcType.pc -> io.from_idu.bits.cf.pc,
    FuSrcType.zero -> 0.U
  ))

  io.to_exu.bits.data.fuSrc2 := MuxLookup(io.from_idu.bits.ctrl.fuSrc2Type, 0.U, Seq(
    FuSrcType.rfSrc2 -> rs2,
    FuSrcType.imm -> io.from_idu.bits.data.imm,
    FuSrcType.four -> 4.U
  ))

  // Scoreboard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.io.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(io.from_idu.bits.ctrl.rfWen && io.to_exu.fire, sb.io.mask(io.from_idu.bits.ctrl.rd), 0.U)
  sb.io.update.setMask := isFireSetMask
  sb.io.update.clearMask := wbuClearMask

  // Connect output
  io.to_exu.bits.cf := io.from_idu.bits.cf
  io.to_exu.bits.ctrl := io.from_idu.bits.ctrl
  io.to_exu.bits.data.rfSrc1 := rs1
  io.to_exu.bits.data.rfSrc2 := rs2
}

// Define FuSrcType enumeration
object FuSrcType extends Enumeration {
  type FuSrcType = Value
  val rfSrc1, pc, zero, rfSrc2, imm, four = Value
}

// Define FuType enumeration
object FuType extends Enumeration {
  type FuType = Value
  val ALU, MEM, CSR = Value
}

// Define FuOpType enumeration
object FuOpType extends Enumeration {
  type FuOpType = Value
  val ADD, SUB, AND, OR, XOR, SLL, SRL, SRA = Value
}

// Main object to generate Verilog
/*
object ISU extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new ISU(3), args)
}
*/
