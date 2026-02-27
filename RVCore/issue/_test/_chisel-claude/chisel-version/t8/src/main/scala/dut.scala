// package npc

import chisel3._
import chisel3.util._
import npc.NPCConfig._

// ScoreBoard class for tracking register usage
class ScoreBoard(val maxScore: Int) extends HasNPCParameter {
  private val busy = RegInit(VecInit(Seq.fill(NR_GPR)(0.U(log2Ceil(maxScore + 1).W))))
  
  def isBusy(idx: UInt): Bool = {
    busy(idx) =/= 0.U
  }
  
  def mask(idx: UInt): UInt = {
    val res = Wire(UInt(NR_GPR.W))
    res := (1.U(NR_GPR.W) << idx)(NR_GPR-1, 0)
    res
  }
  
  def update(setMask: UInt, clearMask: UInt): Unit = {
    for (i <- 1 until NR_GPR) {
      val set = setMask(i)
      val clear = clearMask(i)
      busy(i) := MuxCase(busy(i), Seq(
        (set && clear) -> busy(i),
        set -> Mux(busy(i) === maxScore.U, maxScore.U, busy(i) + 1.U),
        clear -> Mux(busy(i) === 0.U, 0.U, busy(i) - 1.U)
      ))
    }
    // Register 0 is always not busy
    busy(0) := 0.U
  }
}

// Main ISU Module
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
  
  // Initialize ScoreBoard with maxScore = 3
  val sb = new ScoreBoard(3)
  
  // Directly connect all signals from IDU to EXU by default
  io.to_exu.bits := io.from_idu.bits
  
  // Handle register file connections
  def rs1_rs2(rfSrc1: UInt, rfSrc2: UInt): (UInt, UInt) = {
    io.to_exu.bits.data.rfSrc1 := rfSrc1
    io.to_exu.bits.data.rfSrc2 := rfSrc2
    (rfSrc1, rfSrc2)
  }
  
  // Read register values
  val (rfSrc1, rfSrc2) = rs1_rs2(io.from_reg.rfSrc1, io.from_reg.rfSrc2)
  
  // Process operands based on fuSrcType
  when(io.from_idu.valid) {
    // Handle source operand 1
    io.to_exu.bits.data.fuSrc1 := MuxLookup(io.from_idu.bits.ctrl.fuSrc1Type, 0.U, Seq(
      FuSrcType.rfSrc1 -> rfSrc1,
      FuSrcType.pc -> io.from_idu.bits.cf.pc,
      FuSrcType.zero -> 0.U
    ))
    
    // Handle source operand 2
    io.to_exu.bits.data.fuSrc2 := MuxLookup(io.from_idu.bits.ctrl.fuSrc2Type, 0.U, Seq(
      FuSrcType.rfSrc2 -> rfSrc2,
      FuSrcType.imm -> io.from_idu.bits.data.imm,
      FuSrcType.four -> 4.U
    ))
  }
  
  // Check for data hazards
  val rs1Busy = sb.isBusy(io.from_idu.bits.ctrl.rs1) && 
                io.from_idu.bits.ctrl.fuSrc1Type === FuSrcType.rfSrc1
  val rs2Busy = sb.isBusy(io.from_idu.bits.ctrl.rs2) && 
                io.from_idu.bits.ctrl.fuSrc2Type === FuSrcType.rfSrc2
  
  // Determine if there's any condition that would prevent instruction issue
  val AnyInvalidCondition = rs1Busy || rs2Busy
  
  // Handshake control
  io.to_exu.valid := io.from_idu.valid && !AnyInvalidCondition
  io.from_idu.ready := io.to_exu.ready && !AnyInvalidCondition
  
  // Update ScoreBoard
  val inBits = io.from_idu.bits
  val wbuClearMask = Mux(io.wb.RegWrite, sb.mask(io.wb.rd), 0.U)
  val isFireSetMask = Mux(inBits.ctrl.rfWen && io.to_exu.fire, sb.mask(inBits.ctrl.rd), 0.U)
  sb.update(isFireSetMask, wbuClearMask)
}

// Bundle definitions for signals between modules
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

// Define FuSrcType object
object FuSrcType {
  val rfSrc1 = 0.U(2.W)
  val pc = 1.U(2.W)
  val zero = 2.U(2.W)
  
  val rfSrc2 = 0.U(2.W)
  val imm = 1.U(2.W)
  val four = 2.U(2.W)
}

// Trait for configuration parameters
trait HasNPCParameter {
  val XLen = 64
  val NR_GPR = 32
}

// NPCBundle class for common signal bundles
abstract class NPCBundle extends Bundle with HasNPCParameter
