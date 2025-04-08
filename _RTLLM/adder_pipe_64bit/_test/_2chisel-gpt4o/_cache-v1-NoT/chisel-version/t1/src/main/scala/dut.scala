import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())
    val adda   = Input(UInt(64.W))
    val addb   = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // Task 2: Initialize registers for pipeline stages
  val stage1Reg = RegInit(0.U(16.W))
  val stage1Carry = RegInit(false.B)
  val stage2Reg = RegInit(0.U(16.W))
  val stage2Carry = RegInit(false.B)
  val stage3Reg = RegInit(0.U(16.W))
  val stage3Carry = RegInit(false.B)
  val stage4Reg = RegInit(0.U(16.W))
  val stage4Carry = RegInit(false.B)
  
  val pipelineEnable = RegInit(false.B)

  // Task 3: First stage of the pipeline for least significant 16 bits
  when(io.i_en) {
    val stage1Sum = io.adda(15, 0) +& io.addb(15, 0)
    stage1Reg := stage1Sum(15, 0)
    stage1Carry := stage1Sum(16)
  }

  // Task 4: Second stage of the pipeline
  when(io.i_en) {
    val stage2Sum = io.adda(31, 16) +& io.addb(31, 16) + stage1Carry
    stage2Reg := stage2Sum(15, 0)
    stage2Carry := stage2Sum(16)
  }

  // Task 5: Third stage of the pipeline
  when(io.i_en) {
    val stage3Sum = io.adda(47, 32) +& io.addb(47, 32) + stage2Carry
    stage3Reg := stage3Sum(15, 0)
    stage3Carry := stage3Sum(16)
  }

  // Task 6: Fourth stage of the pipeline for most significant bits
  when(io.i_en) {
    val stage4Sum = io.adda(63, 48) +& io.addb(63, 48) + stage3Carry
    stage4Reg := stage4Sum(15, 0)
    stage4Carry := stage4Sum(16)
  }

  // Task 7: Update the output enable signal
  pipelineEnable := io.i_en
  io.o_en := pipelineEnable

  // Task 8: Connect the final outputs
  val finalSum = Cat(stage4Carry, stage4Reg, stage3Reg, stage2Reg, stage1Reg)
  io.result := finalSum
}
