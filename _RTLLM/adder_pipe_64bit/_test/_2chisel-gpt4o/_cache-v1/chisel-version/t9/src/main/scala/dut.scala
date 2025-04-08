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
  
  // Define pipeline registers
  val stage1SumReg = RegInit(0.U(17.W))
  val stage2SumReg = RegInit(0.U(17.W))
  val stage3SumReg = RegInit(0.U(17.W))
  val stage4SumReg = RegInit(0.U(65.W))
  
  val stage1CarryReg = RegInit(0.U(1.W))
  val stage2CarryReg = RegInit(0.U(1.W))
  val stage3CarryReg = RegInit(0.U(1.W))
  
  val stage1EnReg = RegInit(false.B)
  val stage2EnReg = RegInit(false.B)
  val stage3EnReg = RegInit(false.B)
  val stage4EnReg = RegInit(false.B)

  // Stage 1: Add first 16 bits
  val stage1Sum = io.adda(15, 0) +& io.addb(15, 0)
  stage1SumReg := stage1Sum
  stage1CarryReg := stage1Sum(16) // Carry out
  stage1EnReg := io.i_en

  // Stage 2: Add second 16 bits with carry from stage 1
  val stage2Sum = io.adda(31, 16) +& io.addb(31, 16) + stage1CarryReg
  stage2SumReg := stage2Sum
  stage2CarryReg := stage2Sum(16) // Carry out
  stage2EnReg := stage1EnReg

  // Stage 3: Add third 16 bits with carry from stage 2
  val stage3Sum = io.adda(47, 32) +& io.addb(47, 32) + stage2CarryReg
  stage3SumReg := stage3Sum
  stage3CarryReg := stage3Sum(16) // Carry out
  stage3EnReg := stage2EnReg

  // Stage 4: Add fourth 16 bits with carry from stage 3
  val stage4Sum = io.adda(63, 48) +& io.addb(63, 48) + stage3CarryReg
  stage4SumReg := Cat(stage3CarryReg, stage4Sum)
  stage4EnReg := stage3EnReg

  // Output the final result and the enable signal
  io.result := Cat(stage4SumReg, stage1SumReg(15, 0), stage2SumReg(15, 0), stage3SumReg(15, 0))
  io.o_en := stage4EnReg
}

