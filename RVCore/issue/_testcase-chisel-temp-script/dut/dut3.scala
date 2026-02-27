// package npc

import chisel3._
import chisel3.util._

// Trait containing core parameters
trait HasNPCParameter {
  val XLen = 64
  val NR_GPR = 32
}

// FuSrcType enumeration
object FuSrcType {
  val rfSrc1 = 0.U(3.W)
  val pc = 1.U(3.W)
  val zero = 2.U(3.W)
  val rfSrc2 = 0.U(3.W)
  val imm = 1.U(3.W)
  val four = 2.U(3.W)
  
  def apply() = UInt(3.W)
}

// FuType enumeration
object FuType {
  def apply() = UInt(3.W)
}

// FuOpType enumeration
object FuOpType {
  def apply() = UInt(5.W)
}

// Base bundle class for NPC
class NPCBundle extends Bundle with HasNPCParameter

// Control flow information bundle
class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)         // Current control flow instruction
  val pc = UInt(XLen.W)         // Instruction address
  val next_pc = UInt(XLen.W)    // Next instruction address
  val isBranch = Bool()         // Is branch instruction
}

// Control signal bundle
class CtrlSignal extends NPCBundle {
  val MemWrite = Bool()
  val ResSrc = UInt(3.W)
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
  val fuSrc1 = UInt(XLen.W)              // Functional unit operand 1
  val fuSrc2 = UInt(XLen.W)              // Functional unit operand 2
  val imm = UInt(XLen.W)                 // Immediate value
  val Alu0Res = Decoupled(UInt(XLen.W))  // ALU calculation result
  val data_from_mem = UInt(XLen.W)       // Data read from memory
  val csrRdata = UInt(XLen.W)            // Data read from CSR
  val rfSrc1 = UInt(XLen.W)              // Data read from register 1
  val rfSrc2 = UInt(XLen.W)              // Data read from register 2
}

// Decode IO bundle
class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow     // Control flow information
  val ctrl = new CtrlSignal // Control signal
  val data = new DataSrc    // Data source information
}

// Write-back to register IO bundle
class WbuToRegIO extends NPCBundle {
  val rd = UInt(5.W)
  val Res = UInt(XLen.W)
  val RegWrite = Bool()
}

// ScoreBoard class for tracking register usage
class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  // Register busy status counters
  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Ceil(maxScore+1).W))))
  
  // Check if register is busy
  def isBusy(idx: UInt): Bool = busy(idx) > 0.U
  
  // Generate a mask for a specific register
  def mask(idx: UInt): UInt = UIntToOH(idx)(NR_GPR-1, 0)
  
  // Update scoreboard status
  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 1 until NR_GPR) {
      val set = setMask(i)
      val clear = clearMask(i)
      busy(i) := MuxCase(busy(i), Array(
        (set && clear) -> busy(i),
        set -> Mux(busy(i) === maxScore.U, maxScore.U, busy(i) + 1.U),
        clear -> Mux(busy(i) === 0.U, 0.U, busy(i) - 1.U)
      ))
    }
    // r0 is always available
    busy(0) := 0.U
  }
}

// Handshake deal function
object HandShakeDeal {
  def apply[T <: Data](in: DecoupledIO[T], out: DecoupledIO[T], valid: Bool): Unit = {
    out.valid := in.valid && !valid
    in.ready := out.ready && !valid
    out.bits := in.bits
  }
}

// Instruction Issue Unit (ISU) Module
class ISU extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO)) // From decode unit
    val to_exu = Decoupled(new DecodeIO)           // To execution unit
    val wb = Input(new WbuToRegIO)                // Write-back feedback
    val from_reg = new Bundle {                   // Register file values
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })

  // Create ScoreBoard instance
  val sb = new ScoreBoard(3)
  
  // Define helper function for register value handling
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }
  
  // Connect input to output by default
  io.to_exu.bits := io.from_idu.bits
  
  // Process registers
  val (rfSrc1, rfSrc2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)
  
  // Operand selection based on control signals
  // Src1 selection
  io.to_exu.bits.data.fuSrc1 := MuxLookup(io.from_idu.bits.ctrl.fuSrc1Type, 0.U, Seq(
    FuSrcType.rfSrc1 -> rfSrc1,
    FuSrcType.pc -> io.from_idu.bits.cf.pc,
    FuSrcType.zero -> 0.U
  ))
  
  // Src2 selection
  io.to_exu.bits.data.fuSrc2 := MuxLookup(io.from_idu.bits.ctrl.fuSrc2Type, 0.U, Seq(
    FuSrcType.rfSrc2 -> rfSrc2,
    FuSrcType.imm -> io.from_idu.bits.data.imm,
    FuSrcType.four -> 4.U
  ))
  
  // Check data hazards
  val rs1_busy = sb.isBusy(io.from_idu.bits.ctrl.rs1) && io.from_idu.bits.ctrl.rs1 =/= 0.U
  val rs2_busy = sb.isBusy(io.from_idu.bits.ctrl.rs2) && io.from_idu.bits.ctrl.rs2 =/= 0.U
  
  // Determine if there's any reason to stall
  val AnyInvalidCondition = rs1_busy || rs2_busy
  
  // Handle handshake signals
  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)
  
  // Update scoreboard
  val inBits = io.from_idu.bits
  val out = io.to_exu
  
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(inBits.ctrl.rfWen && out.fire, sb.mask(inBits.ctrl.rd), 0.U)
  sb.update(isFireSetMask, wbuClearMask)
}
