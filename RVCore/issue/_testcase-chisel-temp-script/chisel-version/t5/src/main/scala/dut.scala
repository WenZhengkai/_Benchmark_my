// package npc
import chisel3._
import chisel3.util._

// Define some utility types for functional unit source and operation types
object FuSrcType {
  def rfSrc1 = 0.U(2.W)
  def pc     = 1.U(2.W)
  def zero   = 2.U(2.W)
  def apply() = UInt(2.W)
  
  def rfSrc2 = 0.U(2.W)
  def imm    = 1.U(2.W)
  def four   = 2.U(2.W)
}

object FuType {
  def alu    = 0.U(3.W)
  def lsu    = 1.U(3.W)
  def mdu    = 2.U(3.W)
  def csr    = 3.U(3.W)
  def bru    = 4.U(3.W)
  def apply() = UInt(3.W)
}

object FuOpType {
  def apply() = UInt(5.W)
}

// Trait containing common parameters for NPC
trait HasNPCParameter {
  val XLen = 64
  val NR_GPR = 32
}

// Base bundle for NPC modules
class NPCBundle extends Bundle with HasNPCParameter

// Control flow bundle
class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)        // Current control flow instruction
  val pc = UInt(XLen.W)        // Instruction address
  val next_pc = UInt(XLen.W)   // Next instruction address
  val isBranch = Bool()        // Is it a branch instruction
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
  val fuSrc1 = UInt(XLen.W)               // Functional unit operand 1
  val fuSrc2 = UInt(XLen.W)               // Functional unit operand 2
  val imm = UInt(XLen.W)                  // Immediate value
  val Alu0Res = Decoupled(UInt(XLen.W))   // ALU calculation result
  val data_from_mem = UInt(XLen.W)        // Data read from memory
  val csrRdata = UInt(XLen.W)             // Data read from CSR
  val rfSrc1 = UInt(XLen.W)               // Data read from register
  val rfSrc2 = UInt(XLen.W)               // Data read from register
}

// Decode IO bundle
class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow      // Control flow information
  val ctrl = new CtrlSignal  // Control signal
  val data = new DataSrc     // Data source information
}

// Write-back unit to register IO bundle
class WbuToRegIO extends NPCBundle {
  val rd = UInt(5.W)         // Destination register
  val Res = UInt(XLen.W)     // Result to write
  val RegWrite = Bool()      // Write enable
}

// ScoreBoard class for tracking register usage
class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Ceil(maxScore + 1).W))))
  
  // Check if a register is busy
  def isBusy(idx: UInt): Bool = {
    busy(idx) =/= 0.U
  }
  
  // Generate a register bit mask based on the register number
  def mask(idx: UInt): UInt = {
    val maskWire = Wire(UInt(NR_GPR.W))
    maskWire := (1.U(NR_GPR.W) << idx)
    maskWire
  }
  
  // Update the scoreboard status according to the set/clear mask
  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 0 until NR_GPR) {
      if (i == 0) {
        // r0 is always 0, no need to track
        busy(i) := 0.U
      } else {
        val set = (setMask & (1.U << i.U)).orR
        val clear = (clearMask & (1.U << i.U)).orR
        
        busy(i) := MuxCase(busy(i), Array(
          (set && clear) -> busy(i),
          set -> Mux(busy(i) === maxScore.U, maxScore.U, busy(i) + 1.U),
          clear -> Mux(busy(i) === 0.U, 0.U, busy(i) - 1.U)
        ))
      }
    }
  }
}

// Instruction Issue Unit module
class dut extends Module with HasNPCParameter {
  val io = IO(new Bundle {
    val from_idu = Flipped(Decoupled(new DecodeIO))   // Input from decode unit
    val to_exu = Decoupled(new DecodeIO)              // Output to execution unit
    val wb = Input(new WbuToRegIO)                    // Feedback from write-back unit
    val from_reg = new Bundle {                       // Register values from register file
      val rfSrc1 = Input(UInt(XLen.W))
      val rfSrc2 = Input(UInt(XLen.W))
    }
  })
  
  // Create scoreboard with max score of 3
  val sb = new ScoreBoard(3)
  
  // Connect decode IO signal
  val inBits = io.from_idu.bits
  
  // Check for data hazards
  val rs1Busy = sb.isBusy(inBits.ctrl.rs1) && inBits.ctrl.rs1 =/= 0.U
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2) && inBits.ctrl.rs2 =/= 0.U
  val rs1Used = inBits.ctrl.fuSrc1Type === FuSrcType.rfSrc1
  val rs2Used = inBits.ctrl.fuSrc2Type === FuSrcType.rfSrc2
  
  // Detect invalid conditions that should stall the pipeline
  val AnyInvalidCondition = (rs1Busy && rs1Used) || (rs2Busy && rs2Used)
  
  // Function to handle operand selection from register file
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    val rs1 = MuxLookup(inBits.ctrl.fuSrc1Type, 0.U, Seq(
      FuSrcType.rfSrc1 -> rfSrc1,
      FuSrcType.pc     -> inBits.cf.pc,
      FuSrcType.zero   -> 0.U
    ))
    
    val rs2 = MuxLookup(inBits.ctrl.fuSrc2Type, 0.U, Seq(
      FuSrcType.rfSrc2 -> rfSrc2,
      FuSrcType.imm    -> inBits.data.imm,
      FuSrcType.four   -> 4.U
    ))
    
    (rs1, rs2)
  }
  
  // Connect input to output
  io.to_exu.bits := inBits
  
  // Connect operand data
  val (fuSrc1, fuSrc2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)
  io.to_exu.bits.data.fuSrc1 := fuSrc1
  io.to_exu.bits.data.fuSrc2 := fuSrc2
  io.to_exu.bits.data.rfSrc1 := io.from_reg.rfSrc1
  io.to_exu.bits.data.rfSrc2 := io.from_reg.rfSrc2
  
  // Handle handshake signals
  io.to_exu.valid := io.from_idu.valid && !AnyInvalidCondition
  io.from_idu.ready := io.to_exu.ready && !AnyInvalidCondition
  
  // Update the scoreboard
  val out = io.to_exu
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(inBits.ctrl.rfWen && out.fire, sb.mask(inBits.ctrl.rd), 0.U)
  sb.update(isFireSetMask, wbuClearMask)
}
