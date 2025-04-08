

import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en  = Input(Bool())                // Enable signal for addition operation
    val adda  = Input(UInt(64.W))           // 64-bit input operand A
    val addb  = Input(UInt(64.W))           // 64-bit input operand B
    val result = Output(UInt(65.W))         // 65-bit output representing the sum
    val o_en  = Output(Bool())              // Output enable signal
  })

  val stage0_en = RegInit(false.B)          // Pipeline register: enable after stage 0
  val stage1_en = RegInit(false.B)          // Pipeline register: enable after stage 1
  val stage2_en = RegInit(false.B)          // Pipeline register: enable after stage 2
  val stage3_en = RegInit(false.B)          // Pipeline register: enable after stage 3

  val regA = Reg(UInt(64.W))                // Pipeline registered operand A
  val regB = Reg(UInt(64.W))                // Pipeline registered operand B

  val stage0_sum = Reg(UInt(16.W))          // Stage 0 sum
  val stage0_carry = Reg(Bool())            // Stage 0 carry-out

  val stage1_sum = Reg(UInt(16.W))          // Stage 1 sum
  val stage1_carry = Reg(Bool())            // Stage 1 carry-out

  val stage2_sum = Reg(UInt(16.W))          // Stage 2 sum
  val stage2_carry = Reg(Bool())            // Stage 2 carry-out

  val stage3_sum = Reg(UInt(16.W))          // Stage 3 sum
  val stage3_carry = Reg(Bool())            // Final carry-out (MSB carry)

  // Registers to store the final result
  val resultReg = Reg(UInt(65.W))           // 65-bit result register
  val resultValid = RegInit(false.B)        // Output enable signal register

  // Input synchronization with i_en
  when(io.i_en) {
    regA := io.adda
    regB := io.addb
    stage0_en := true.B
  }.otherwise {
    stage0_en := false.B
  }
  
  // Pipeline stage 0 (LSBs: 15:0)
  when(stage0_en) {
    val partialSum = regA(15, 0) +& regB(15, 0) // Add with carry
    stage0_sum := partialSum(15, 0)            // Store lower 16 bits
    stage0_carry := partialSum(16)             // Store carry-out
    stage1_en := true.B
  }.otherwise {
    stage1_en := false.B
  }

  // Pipeline stage 1 (Bits: 31:16)
  when(stage1_en) {
    val partialSum = regA(31, 16) +& regB(31, 16) + stage0_carry
    stage1_sum := partialSum(15, 0)
    stage1_carry := partialSum(16)
    stage2_en := true.B
  }.otherwise {
    stage2_en := false.B
  }

  // Pipeline stage 2 (Bits: 47:32)
  when(stage2_en) {
    val partialSum = regA(47, 32) +& regB(47, 32) + stage1_carry
    stage2_sum := partialSum(15, 0)
    stage2_carry := partialSum(16)
    stage3_en := true.B
  }.otherwise {
    stage3_en := false.B
  }

  // Pipeline stage 3 (MSBs: 63:48)
  when(stage3_en) {
    val partialSum = regA(63, 48) +& regB(63, 48) + stage2_carry
    stage3_sum := partialSum(15, 0)
    stage3_carry := partialSum(16)
    resultValid := true.B
  }.otherwise {
    resultValid := false.B
  }

  // Combine pipeline results to form final result
  when(resultValid) {
    resultReg := Cat(stage3_carry, stage3_sum, stage2_sum, stage1_sum, stage0_sum)
  }

  // Assign outputs
  io.result := resultReg
  io.o_en := resultValid
}


