// package npc.core

import chisel3._
import chisel3.util._
import npc.utils._

// ScoreBoard class to track register usage and handle data hazards
class ScoreBoard(val maxScore: Int) extends HasNPCParameter {
  // Track busy status for each register
  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U((log2Ceil(maxScore) + 1).W))))

  // Check if a register is busy (has a non-zero score)
  def isBusy(idx: UInt): Bool = {
    busy(idx) =/= 0.U
  }

  // Generate a mask for the specified register index
  def mask(idx: UInt): UInt = {
    val mask = Wire(UInt(NR_GPR.W))
    mask := UIntToOH(idx)(NR_GPR-1, 0)
    mask
  }

  // Update register busy status based on set and clear masks
  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 0 until NR_GPR) {
      if (i == 0) {
        busy(i) := 0.U // x0 is always available
      } else {
        val set = setMask(i)
        val clear = clearMask(i)
        busy(i) := MuxCase(busy(i), Array(
          (set & clear) -> busy(i),                     // No change if both set and clear
          set -> Mux(busy(i) === maxScore.U, maxScore.U, busy(i) + 1.U), // Increment if set (with max cap)
          clear -> Mux(busy(i) === 0.U, 0.U, busy(i) - 1.U)              // Decrement if clear (with min cap)
        ))
      }
    }
  }
}

// Main ISU (Instruction Issue Unit) module
class ISU extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))  // Input from decode unit
    val to_exu = Decoupled(new DecodeIO)             // Output to execute unit
    val wb = Input(new WbuToRegIO)                   // Writeback feedback
    val from_reg = new Bundle {                      // Values from register file
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  // Instantiate the scoreboard for tracking register dependencies
  val sb = new ScoreBoard(3)
  
  // Connect most signals directly from input to output
  io.to_exu.bits := io.from_idu.bits
  
  // Helper function to connect register source values
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }
  
  // Get register values
  val (rfSrc1, rfSrc2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)
  
  // Determine actual operand values based on source type
  val fuSrc1 = MuxLookup(io.from_idu.bits.ctrl.fuSrc1Type, 0.U)(Seq(
    FuSrcType.rfSrc1 -> rfSrc1,
    FuSrcType.pc -> io.from_idu.bits.cf.pc,
    FuSrcType.zero -> 0.U
  ))
  
  val fuSrc2 = MuxLookup(io.from_idu.bits.ctrl.fuSrc2Type, 0.U)(Seq(
    FuSrcType.rfSrc2 -> rfSrc2,
    FuSrcType.imm -> io.from_idu.bits.data.imm,
    FuSrcType.four -> 4.U
  ))
  
  // Connect operand values to output
  io.to_exu.bits.data.fuSrc1 := fuSrc1
  io.to_exu.bits.data.fuSrc2 := fuSrc2
  
  // Check for data hazards by examining if source registers are busy
  val inBits = io.from_idu.bits
  val rs1Busy = inBits.ctrl.rs1 =/= 0.U && sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = inBits.ctrl.rs2 =/= 0.U && sb.isBusy(inBits.ctrl.rs2)
  
  // Determine if we need to stall due to data hazards
  val AnyInvalidCondition = rs1Busy || rs2Busy
  
  // Handle handshake signals based on hazard condition
  io.to_exu.valid := io.from_idu.valid && !AnyInvalidCondition
  io.from_idu.ready := io.to_exu.ready && !AnyInvalidCondition
  
  // Update scoreboard:
  // 1. Clear mask when writeback happens
  // 2. Set mask when instruction with register write is issued
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U)
  sb.update(isFireSetMask, wbuClearMask)
}

// Support classes and definitions
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
  val ResSrc = UInt(2.W)
  val fuSrc1Type = UInt(2.W)
  val fuSrc2Type = UInt(2.W)
  val fuType = UInt(3.W)
  val fuOpType = UInt(5.W)
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

// FuSrcType definition
object FuSrcType {
  val rfSrc1 = 0.U(2.W)
  val pc     = 1.U(2.W)
  val zero   = 2.U(2.W)
  
  val rfSrc2 = 0.U(2.W)
  val imm    = 1.U(2.W)
  val four   = 2.U(2.W)
  
  def apply() = UInt(2.W)
}

// Stub for the HasNPCParameter trait
trait HasNPCParameter {
  val XLen = 64
  val NR_GPR = 32
}

// Stub for the NPCBundle class
abstract class NPCBundle extends Bundle with HasNPCParameter
