// package npc

import chisel3._
import chisel3.util._
import npc.NPCConfig._

// HasNPCParameter trait provides access to CPU configuration parameters
trait HasNPCParameter {
  val XLen = NPCConfig.XLEN
  val NR_GPR = NPCConfig.GPRs
}

// NPCBundle - Base bundle class for all NPC bundles
class NPCBundle extends Bundle with HasNPCParameter

// Control flow information bundle
class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

// Function unit source type - defines where operands come from
object FuSrcType {
  val rfSrc1 = 0.U(3.W)
  val pc = 1.U(3.W)
  val zero = 2.U(3.W)
  val rfSrc2 = 0.U(3.W)
  val imm = 1.U(3.W)
  val four = 2.U(3.W)

  def apply() = UInt(3.W)
}

// Function unit type
object FuType {
  val alu = 0.U(3.W)
  val lsu = 1.U(3.W)
  val mdu = 2.U(3.W)
  val csr = 3.U(3.W)
  val bru = 4.U(3.W)

  def apply() = UInt(3.W)
}

// Function unit operation type
object FuOpType {
  val add = 0.U(5.W)
  // Other operations would be defined here
  
  def apply() = UInt(5.W)
}

// Control signal bundle
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

// Data source bundle
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

// Decode I/O bundle
class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// Write back unit to register file I/O bundle
class WbuToRegIO extends NPCBundle {
  val rd = UInt(5.W)
  val Res = UInt(XLen.W)
  val RegWrite = Bool()
}

// ScoreBoard implementation
class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  // Register busy status array
  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Ceil(maxScore + 1).W))))
  
  // Check if a register is busy
  def isBusy(idx: UInt): Bool = {
    busy(idx) =/= 0.U
  }
  
  // Generate a mask for a specific register
  def mask(idx: UInt): UInt = {
    // Create a one-hot encoding for the specified register
    val res = Wire(UInt(NR_GPR.W))
    res := UIntToOH(idx, NR_GPR)
    res
  }
  
  // Update the scoreboard based on set and clear masks
  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 1 until NR_GPR) {
      val set = setMask(i)
      val clear = clearMask(i)
      
      when(set && clear) {
        // If both set and clear, don't change
      }.elsewhen(set) {
        // Increment but don't exceed maxScore
        busy(i) := Mux(busy(i) === maxScore.U, maxScore.U, busy(i) + 1.U)
      }.elsewhen(clear) {
        // Decrement but don't go below 0
        busy(i) := Mux(busy(i) === 0.U, 0.U, busy(i) - 1.U)
      }
    }
    
    // Register 0 is always ready (hardwired to 0)
    busy(0) := 0.U
  }
}

// Instruction Issue Unit (ISU) module
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
  
  // Instantiate ScoreBoard with maximum score of 3
  val sb = new ScoreBoard(3)
  
  // Create local aliases for convenience
  val in = io.from_idu
  val out = io.to_exu
  val inBits = in.bits
  
  // Connect the output bundle directly to the input bundle
  out.bits := inBits
  
  // Get register values
  val rfSrc1 = io.from_reg.rfSrc1
  val rfSrc2 = io.from_reg.rfSrc2
  
  // Check for hazards
  val rs1Busy = sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2)
  val rs1Used = (inBits.ctrl.fuSrc1Type === FuSrcType.rfSrc1)
  val rs2Used = (inBits.ctrl.fuSrc2Type === FuSrcType.rfSrc2)
  
  // Determine if there's a hazard
  val AnyInvalidCondition = (rs1Busy && rs1Used) || (rs2Busy && rs2Used)
  
  // Handle handshake protocol
  def HandShakeDeal(in: DecoupledIO[DecodeIO], out: DecoupledIO[DecodeIO], invalid: Bool): Unit = {
    out.valid := in.valid && !invalid
    in.ready := out.ready && !invalid
  }
  
  HandShakeDeal(in, out, AnyInvalidCondition)
  
  // Source operand processing function
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    // Connect register values to output
    out.bits.data.rfSrc1 := rfSrc1
    out.bits.data.rfSrc2 := rfSrc2
    
    // Return the values for further use
    (rfSrc1, rfSrc2)
  }
  
  // Process the source operands
  val (rs1, rs2) = rs1_rs2(rfSrc1, rfSrc2)
  
  // Select operands based on type
  val fuSrc1 = MuxLookup(inBits.ctrl.fuSrc1Type, 0.U)(Seq(
    FuSrcType.rfSrc1 -> rs1,
    FuSrcType.pc -> inBits.cf.pc,
    FuSrcType.zero -> 0.U
  ))
  
  val fuSrc2 = MuxLookup(inBits.ctrl.fuSrc2Type, 0.U)(Seq(
    FuSrcType.rfSrc2 -> rs2,
    FuSrcType.imm -> inBits.data.imm,
    FuSrcType.four -> 4.U
  ))
  
  // Connect the operands to the output
  out.bits.data.fuSrc1 := fuSrc1
  out.bits.data.fuSrc2 := fuSrc2
  
  // ScoreBoard update logic
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(inBits.ctrl.rfWen && out.fire, sb.mask(inBits.ctrl.rd), 0.U)
  sb.update(isFireSetMask, wbuClearMask)
}

// Configuration object for NPC
object NPCConfig {
  val XLEN = 64
  val GPRs = 32
}
