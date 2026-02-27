import chisel3._
import chisel3.util._

class RippleCarryAdder(width: Int) extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(width.W))
    val addb = Input(UInt(width.W))
    val result = Output(UInt((width+1).W))
    val o_en = Output(Bool())
  })
  
  // Define the number of bits per pipeline stage (16 bits per stage for 64-bit total)
  val segmentWidth = 16
  val numStages = width / segmentWidth  // 4 stages for 64-bit
  
  // Pipeline enable registers
  val pipelineEnable = RegInit(VecInit(Seq.fill(numStages)(false.B)))
  
  // First stage gets input enable
  pipelineEnable(0) := io.i_en
  
  // Propagate enable signal through the pipeline
  for (i <- 1 until numStages) {
    pipelineEnable(i) := pipelineEnable(i-1)
  }
  
  // Output enable is the last stage enable
  io.o_en := pipelineEnable(numStages-1)
  
  // Segment the input operands for pipeline stages
  val addaSegments = Wire(Vec(numStages, UInt(segmentWidth.W)))
  val addbSegments = Wire(Vec(numStages, UInt(segmentWidth.W)))
  
  for (i <- 0 until numStages) {
    addaSegments(i) := io.adda((i+1)*segmentWidth-1, i*segmentWidth)
    addbSegments(i) := io.addb((i+1)*segmentWidth-1, i*segmentWidth)
  }
  
  // Pipeline registers for operand segments
  val addaRegs = Reg(Vec(numStages, UInt(segmentWidth.W)))
  val addbRegs = Reg(Vec(numStages, UInt(segmentWidth.W)))
  
  // First stage receives direct inputs
  when (io.i_en) {
    addaRegs(0) := addaSegments(0)
    addbRegs(0) := addbSegments(0)
  }
  
  // Carry registers between pipeline stages
  val carryRegs = RegInit(VecInit(Seq.fill(numStages)(false.B)))
  
  // Partial sum registers
  val sumRegs = Reg(Vec(numStages, UInt(segmentWidth.W)))
  
  // First stage addition (no input carry)
  val firstStageSum = Wire(UInt((segmentWidth+1).W))
  firstStageSum := addaRegs(0) +& addbRegs(0)  // +& operator includes carry
  
  when (pipelineEnable(0)) {
    sumRegs(0) := firstStageSum(segmentWidth-1, 0)
    carryRegs(0) := firstStageSum(segmentWidth)
  }
  
  // Subsequent pipeline stages
  for (i <- 1 until numStages) {
    // Propagate operands through pipeline
    when (pipelineEnable(i-1)) {
      addaRegs(i) := addaSegments(i)
      addbRegs(i) := addbSegments(i)
    }
    
    // Perform addition with previous stage's carry
    val stageSum = Wire(UInt((segmentWidth+1).W))
    stageSum := addaRegs(i) +& addbRegs(i) + carryRegs(i-1)
    
    // Store results in registers
    when (pipelineEnable(i)) {
      sumRegs(i) := stageSum(segmentWidth-1, 0)
      if (i < numStages - 1) {
        carryRegs(i) := stageSum(segmentWidth)
      } else {
        // For the last stage, we need to include the carry in the final result
        carryRegs(i) := stageSum(segmentWidth)
      }
    }
  }
  
  // Combine all partial sums for the final result
  val resultWire = Wire(UInt((width+1).W))
  resultWire := Cat(carryRegs(numStages-1), 
                   sumRegs(numStages-1), 
                   sumRegs(numStages-2), 
                   sumRegs(numStages-3), 
                   sumRegs(0))
  
  io.result := resultWire
}

// Top-level module named "dut" as specified
class dut extends RippleCarryAdder(64) {
  // The parent class RippleCarryAdder already implements all required functionality
}

// Optional: object for generating Verilog
/*
object dutGenerator extends App {
  chisel3.Driver.execute(args, () => new dut())
}
*/
