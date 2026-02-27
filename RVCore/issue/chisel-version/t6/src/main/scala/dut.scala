// package core

import chisel3._
import chisel3.util._
import utils._

// HasNPCParameter trait to provide common parameters
trait HasNPCParameter {
  val XLen = 64
  val NR_GPR = 32
}

// Enumeration for functional unit source types
object FuSrcType {
  val rfSrc1 = 0.U(3.W)
  val pc = 1.U(3.W)
  val zero = 2.U(3.W)
  val rfSrc2 = 0.U(3.W)
  val imm = 1.U(3.W)
  val four = 2.U(3.W)
  
  def apply() = UInt(3.W)
}

// Enumeration for functional unit types
object FuType {
  val alu = 0.U(3.W)
  val bru = 1.U(3.W)
  val lsu = 2.U(3.W)
  val mdu = 3.U(3.W)
  val csr = 4.U(3.W)
  
  def apply() = UInt(3.W)
}

// Enumeration for functional unit operation types
object FuOpType {
  def apply() = UInt(5.W)
}

// Bundle class for NPC components
class NPCBundle extends Bundle with HasNPCParameter

// Control flow information bundle
class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
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
  val fuSrc1 = UInt(XLen.W)
  val fuSrc2 = UInt(XLen.W)
  val imm = UInt(XLen.W)
  
  val Alu0Res = Decoupled(UInt(XLen.W))
  val data_from_mem = UInt(XLen.W)
  val csrRdata = UInt(XLen.W)
  val rfSrc1 = UInt(XLen.W)
  val rfSrc2 = UInt(XLen.W)
}

// Decode information bundle
class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// Write-back unit to register file signal bundle
class WbuToRegIO extends NPCBundle {
  val rd = UInt(5.W)
  val Res = UInt(XLen.W)
  val RegWrite = Bool()
}

// ScoreBoard implementation for tracking register usage status
class ScoreBoard(maxScore: Int) extends HasNPCParameter {
  // Register array to track busy status of each register
  val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Ceil(maxScore + 1).W))))
  
  // Check if a register is busy
  def isBusy(idx: UInt): Bool = {
    busy(idx) =/= 0.U
  }
  
  // Generate a register bit mask based on register number
  def mask(idx: UInt): UInt = {
    val mask = Wire(UInt(NR_GPR.W))
    mask := UIntToOH(idx, NR_GPR)
    mask
  }
  
  // Update scoreboard based on set and clear masks
  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 1 until NR_GPR) {
      busy(i) := MuxCase(busy(i), Array(
        // Simultaneous set and clear - keep current value
        (setMask(i) && clearMask(i)) -> busy(i),
        // Set mask - increment counter (not exceeding maxScore)
        setMask(i) -> Mux(busy(i) === maxScore.U, maxScore.U, busy(i) + 1.U),
        // Clear mask - decrement counter (not going below 0)
        clearMask(i) -> Mux(busy(i) === 0.U, 0.U, busy(i) - 1.U)
      ))
    }
    // x0 is always 0 and not tracked
    busy(0) := 0.U
  }
}

// Handshake utility function
object HandShakeDeal {
  def apply[T <: Data](in: DecoupledIO[T], out: DecoupledIO[T], condition: Bool): Unit = {
    // Input is ready when output is ready and no blocking condition
    in.ready := out.ready && !condition
    // Output is valid when input is valid and no blocking condition
    out.valid := in.valid && !condition
    // Pass data from input to output
    out.bits := in.bits
  }
}

// Instruction Issue Unit module
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

  // Create scoreboard instance
  val sb = new ScoreBoard(3)
  
  // Data hazard detection
  val inBits = io.from_idu.bits
  val rs1Busy = sb.isBusy(inBits.ctrl.rs1) && inBits.ctrl.rs1 =/= 0.U
  val rs2Busy = sb.isBusy(inBits.ctrl.rs2) && inBits.ctrl.rs2 =/= 0.U
  
  // Determine if rs1 and rs2 are used based on operand types
  val useRs1 = inBits.ctrl.fuSrc1Type === FuSrcType.rfSrc1
  val useRs2 = inBits.ctrl.fuSrc2Type === FuSrcType.rfSrc2
  
  // Detect data hazards
  val rs1Hazard = useRs1 && rs1Busy
  val rs2Hazard = useRs2 && rs2Busy
  
  // Any blocking condition that should stall instruction issuance
  val AnyInvalidCondition = rs1Hazard || rs2Hazard
  
  // Handle handshake signals and data forwarding
  HandShakeDeal(io.from_idu, io.to_exu, AnyInvalidCondition)
  
  // Function to process register sources
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }
  
  // Process register values
  val (rfSrc1, rfSrc2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)
  
  // Select operand sources based on control signals
  io.to_exu.bits.data.fuSrc1 := MuxLookup(inBits.ctrl.fuSrc1Type, 0.U, Seq(
    FuSrcType.rfSrc1 -> rfSrc1,
    FuSrcType.pc -> inBits.cf.pc,
    FuSrcType.zero -> 0.U
  ))
  
  io.to_exu.bits.data.fuSrc2 := MuxLookup(inBits.ctrl.fuSrc2Type, 0.U, Seq(
    FuSrcType.rfSrc2 -> rfSrc2,
    FuSrcType.imm -> inBits.data.imm,
    FuSrcType.four -> 4.U
  ))
  
  // Get masks for scoreboard updates
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U)
  
  // Update scoreboard
  sb.update(isFireSetMask, wbuClearMask)
}
