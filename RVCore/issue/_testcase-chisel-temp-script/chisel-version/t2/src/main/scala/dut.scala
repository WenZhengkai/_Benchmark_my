// package npc

import chisel3._
import chisel3.util._
import npc.util._

// ScoreBoard class for tracking register usage
class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  // Array of busy registers for tracking register usage
  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Ceil(maxScore + 1).W))))
  
  // Check if register is busy
  def isBusy(idx: UInt): Bool = {
    Mux(idx === 0.U, false.B, busy(idx) =/= 0.U)
  }
  
  // Generate a mask for the specified register
  def mask(idx: UInt): UInt = {
    val res = Wire(UInt(NR_GPR.W))
    res := 0.U
    when(idx =/= 0.U) {
      res := UIntToOH(idx)(NR_GPR-1, 0)
    }
    res
  }
  
  // Update scoreboard with set and clear masks
  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 1 until NR_GPR) {
      when(setMask(i) && clearMask(i)) {
        // If both set and clear, keep current value
      }.elsewhen(setMask(i)) {
        // Increment score, but not beyond maxScore
        busy(i) := Mux(busy(i) === maxScore.U, maxScore.U, busy(i) + 1.U)
      }.elsewhen(clearMask(i)) {
        // Decrement score, but not below 0
        busy(i) := Mux(busy(i) === 0.U, 0.U, busy(i) - 1.U)
      }
    }
    // Register 0 is always kept at 0
    busy(0) := 0.U
  }
}

// Main ISU module
class ISU extends NPCModule {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))
    val to_exu = Decoupled(new DecodeIO))
    val wb = Input(new WbuToRegIO)
    val from_reg = new Bundle {
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })
  
  // Instantiate ScoreBoard
  val sb = new ScoreBoard(3)
  
  // Function to handle handshake signals
  def HandShakeDeal(in: DecoupledIO[DecodeIO], out: DecoupledIO[DecodeIO], invalidCond: Bool): Unit = {
    // Set default values
    out.valid := false.B
    in.ready := false.B
    
    when(!invalidCond) {
      out.valid := in.valid
      in.ready := out.ready
    }
  }
  
  // Function to process register sources
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    // Forward register values to output
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }
  
  // Create references for cleaner code
  val inBits = io.from_idu.bits
  val out = io.to_exu
  
  // Default connection - pass through all signals
  out.bits := inBits
  
  // Data hazard detection
  val rs1Busy = sb.isBusy(inBits.ctrl.rs1)
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2)
  
  // Determine if there's any invalid condition that would block instruction issue
  val rs1Used = inBits.ctrl.fuSrc1Type === FuSrcType.rfSrc1
  val rs2Used = inBits.ctrl.fuSrc2Type === FuSrcType.rfSrc2
  val AnyInvalidCondition = (rs1Busy && rs1Used) || (rs2Busy && rs2Used)
  
  // Handle the handshake based on invalid conditions
  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)
  
  // Process register sources
  val (rfSrc1, rfSrc2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)
  
  // Select operand sources based on fuSrcType
  // Source 1 selection
  when(inBits.ctrl.fuSrc1Type === FuSrcType.rfSrc1) {
    out.bits.data.fuSrc1 := rfSrc1
  }.elsewhen(inBits.ctrl.fuSrc1Type === FuSrcType.pc) {
    out.bits.data.fuSrc1 := inBits.cf.pc
  }.elsewhen(inBits.ctrl.fuSrc1Type === FuSrcType.zero) {
    out.bits.data.fuSrc1 := 0.U
  }.otherwise {
    out.bits.data.fuSrc1 := rfSrc1 // Default case
  }
  
  // Source 2 selection
  when(inBits.ctrl.fuSrc2Type === FuSrcType.rfSrc2) {
    out.bits.data.fuSrc2 := rfSrc2
  }.elsewhen(inBits.ctrl.fuSrc2Type === FuSrcType.imm) {
    out.bits.data.fuSrc2 := inBits.data.imm
  }.elsewhen(inBits.ctrl.fuSrc2Type === FuSrcType.four) {
    out.bits.data.fuSrc2 := 4.U
  }.otherwise {
    out.bits.data.fuSrc2 := rfSrc2 // Default case
  }
  
  // Update scoreboard
  // Clear mask when a register write is completed
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)
  // Set mask when a new instruction with register write is issued
  val isFireSetMask = Mux(inBits.ctrl.rfWen && out.fire, sb.mask(inBits.ctrl.rd), 0.U)
  
  // Apply updates to scoreboard
  sb.update(isFireSetMask, wbuClearMask)
}
