// package npc

import chisel3._
import chisel3.util._

// Main ISU module
class dut extends NPCModule {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu = Decoupled(new DecodeIO))
    val wb = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  // Instantiate the scoreboard
  val sb = new ScoreBoard(3)
  
  // Check for data hazards
  val inBits = io.from_idu.bits
  val rs1Busy = sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2)
  
  // Determine if there's a hazard
  val rs1Check = (inBits.ctrl.fuSrc1Type === FuSrcType.rfSrc1) && rs1Busy && (inBits.ctrl.rs1 =/= 0.U)
  val rs2Check = (inBits.ctrl.fuSrc2Type === FuSrcType.rfSrc2) && rs2Busy && (inBits.ctrl.rs2 =/= 0.U)
  val AnyInvalidCondition = rs1Check || rs2Check
  
  // Connect and process the register file
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }
  
  val (rfSrc1, rfSrc2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)
  
  // Handle operand selection based on source types
  io.to_exu.bits.data.fuSrc1 := MuxCase(0.U, Array(
    (inBits.ctrl.fuSrc1Type === FuSrcType.rfSrc1) -> rfSrc1,
    (inBits.ctrl.fuSrc1Type === FuSrcType.pc) -> inBits.cf.pc,
    (inBits.ctrl.fuSrc1Type === FuSrcType.zero) -> 0.U
  ))
  
  io.to_exu.bits.data.fuSrc2 := MuxCase(0.U, Array(
    (inBits.ctrl.fuSrc2Type === FuSrcType.rfSrc2) -> rfSrc2,
    (inBits.ctrl.fuSrc2Type === FuSrcType.imm) -> inBits.data.imm,
    (inBits.ctrl.fuSrc2Type === FuSrcType.four) -> 4.U
  ))
  
  // Handle scoreboard updates
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U)
  sb.update(isFireSetMask, wbuClearMask)
  
  // Connect other signals
  io.to_exu.bits.cf := inBits.cf
  io.to_exu.bits.ctrl := inBits.ctrl
  io.to_exu.bits.data.imm := inBits.data.imm
  io.to_exu.bits.data.Alu0Res := inBits.data.Alu0Res
  io.to_exu.bits.data.data_from_mem := inBits.data.data_from_mem
  io.to_exu.bits.data.csrRdata := inBits.data.csrRdata
  
  // Handshake management
  io.to_exu.valid := io.from_idu.valid && !AnyInvalidCondition
  io.from_idu.ready := io.to_exu.ready && !AnyInvalidCondition
}

// ScoreBoard implementation
class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  // Register to track usage status of each register
  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Ceil(maxScore + 1).W))))
  
  // Check if a register is busy
  def isBusy(idx: UInt): Bool = {
    busy(idx) =/= 0.U
  }
  
  // Generate a register bit mask based on register number
  def mask(idx: UInt): UInt = {
    val mask = Wire(UInt(NR_GPR.W))
    mask := UIntToOH(idx)(NR_GPR-1, 0)
    mask
  }
  
  // Update the scoreboard status
  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 0 until NR_GPR) {
      if (i == 0) {
        busy(i) := 0.U  // x0 is always 0
      } else {
        val doSet = setMask(i)
        val doClear = clearMask(i)
        busy(i) := MuxCase(busy(i), Array(
          (doSet && doClear) -> busy(i),
          doSet -> Mux(busy(i) === maxScore.U, maxScore.U, busy(i) + 1.U),
          doClear -> Mux(busy(i) === 0.U, 0.U, busy(i) - 1.U)
        ))
      }
    }
  }
}

// Supporting class definitions (assumed to be defined elsewhere)
class WbuToRegIO extends NPCBundle {
  val rd = UInt(5.W)
  val Res = UInt(XLen.W)
  val RegWrite = Bool()
}

class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

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

// Assumed to be defined elsewhere
object FuSrcType {
  def apply() = UInt(3.W)
  def rfSrc1 = 0.U(3.W)
  def pc = 1.U(3.W)
  def zero = 2.U(3.W)
  def rfSrc2 = 0.U(3.W)
  def imm = 1.U(3.W)
  def four = 2.U(3.W)
}

// Assumed to be defined elsewhere
object FuType {
  def apply() = UInt(3.W)
}

// Assumed to be defined elsewhere
object FuOpType {
  def apply() = UInt(5.W)
}

// Base traits assumed to be defined elsewhere
trait HasNPCParameter {
  val NR_GPR = 32
  val XLen = 64
}

trait NPCModule extends Module with HasNPCParameter
trait NPCBundle extends Bundle with HasNPCParameter
