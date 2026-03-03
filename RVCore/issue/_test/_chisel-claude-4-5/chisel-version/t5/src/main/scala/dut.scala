import chisel3._
import chisel3.util._

// Assume these traits and objects are defined elsewhere in your codebase
trait HasNPCParameter {
  val NR_GPR = 32
  val XLen = 64
}

abstract class NPCBundle extends Bundle with HasNPCParameter

object FuSrcType {
  def rfSrc1 = 0.U
  def rfSrc2 = 1.U
  def pc = 2.U
  def imm = 3.U
  def zero = 4.U
  def four = 5.U
}

object FuType {
  def apply() = UInt(4.W)
}

object FuOpType {
  def apply() = UInt(7.W)
}

object FuSrcType {
  def apply() = UInt(3.W)
  val rfSrc1 = 0.U
  val rfSrc2 = 1.U
  val pc = 2.U
  val imm = 3.U
  val zero = 4.U
  val four = 5.U
}

// Bundle definitions
class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite = Bool()
  val ResSrc = UInt(2.W)
  val fuSrc1Type = FuSrcType()
  val fuSrc2Type = FuSrcType()
  val fuType = FuType()
  val fuOpType = FuOpType()
  val rs1 = UInt(5.W)
  val rs2 = UInt(5.W)
  val rfWen = Bool()
  val rd = UInt(5.W)
}

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

class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

class WbuToRegIO extends NPCBundle {
  val rd = UInt(5.W)
  val Res = UInt(XLen.W)
  val RegWrite = Bool()
}

// ScoreBoard class
class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  // Create register group to track usage status of each register
  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Ceil(maxScore + 1).W))))
  
  // Check if register is busy
  def isBusy(idx: UInt): Bool = {
    busy(idx) =/= 0.U
  }
  
  // Generate register bit mask based on register number
  def mask(idx: UInt): UInt = {
    UIntToOH(idx, NR_GPR)
  }
  
  // Update scoreboard status according to set/clear mask
  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 0 until NR_GPR) {
      if (i == 0) {
        // busy(0) is always kept at 0
        busy(i) := 0.U
      } else {
        val setBit = setMask(i)
        val clearBit = clearMask(i)
        
        when(setBit && clearBit) {
          // Keep original value when setting and clearing at the same time
          busy(i) := busy(i)
        }.elsewhen(setBit) {
          // Set mask to increase count value (not exceeding maxScore)
          when(busy(i) < maxScore.U) {
            busy(i) := busy(i) + 1.U
          }
        }.elsewhen(clearBit) {
          // Clear mask to reduce count value (not less than 0)
          when(busy(i) > 0.U) {
            busy(i) := busy(i) - 1.U
          }
        }.otherwise {
          // Keep original value by default
          busy(i) := busy(i)
        }
      }
    }
  }
}

// ISU Module
class dut extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu = Decoupled(new DecodeIO)
    val wb = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })
  
  // Instantiate ScoreBoard
  val sb = new ScoreBoard(3)
  
  // Get input signals
  val inBits = io.from_idu.bits
  
  // Function to handle register file connections
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }
  
  // Get register values
  val (rfSrc1, rfSrc2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)
  
  // Data hazard detection
  val rs1Busy = sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2)
  val AnyInvalidCondition = rs1Busy || rs2Busy
  
  // Handshake handling function
  def HandShakeDeal(in: DecoupledIO[DecodeIO], out: DecoupledIO[DecodeIO], condition: Bool): Unit = {
    in.ready := out.ready && !condition
    out.valid := in.valid && !condition
  }
  
  // Handle handshake signals
  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)
  
  // Connect DecodeIO from input to output (default connections)
  io.to_exu.bits := io.from_idu.bits
  
  // Operand processing - Select operand source according to fuSrc1Type
  val fuSrc1 = MuxLookup(inBits.ctrl.fuSrc1Type, 0.U)(Seq(
    FuSrcType.rfSrc1 -> rfSrc1,
    FuSrcType.pc -> inBits.cf.pc,
    FuSrcType.zero -> 0.U,
    FuSrcType.four -> 4.U
  ))
  
  // Select operand source according to fuSrc2Type
  val fuSrc2 = MuxLookup(inBits.ctrl.fuSrc2Type, 0.U)(Seq(
    FuSrcType.rfSrc2 -> rfSrc2,
    FuSrcType.imm -> inBits.data.imm,
    FuSrcType.pc -> inBits.cf.pc,
    FuSrcType.zero -> 0.U,
    FuSrcType.four -> 4.U
  ))
  
  // Override fuSrc outputs
  io.to_exu.bits.data.fuSrc1 := fuSrc1
  io.to_exu.bits.data.fuSrc2 := fuSrc2
  
  // Scoreboard update
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U)
  sb.update(isFireSetMask, wbuClearMask)
}
