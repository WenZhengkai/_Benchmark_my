import chisel3._
import chisel3.util._

// Module definition for 64-bit pipelined ripple carry adder
class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())        // Input enable
    val adda   = Input(UInt(64.W))   // 64-bit input operand A
    val addb   = Input(UInt(64.W))   // 64-bit input operand B
    val result = Output(UInt(65.W))  // 65-bit output to hold the sum
    val o_en   = Output(Bool())      // Output enable
  })

  // Define pipeline registers
  val regA0 = RegInit(0.U(16.W)) // Pipeline registers for operand A
  val regA1 = RegInit(0.U(16.W))
  val regA2 = RegInit(0.U(16.W))
  val regA3 = RegInit(0.U(16.W))

  val regB0 = RegInit(0.U(16.W)) // Pipeline registers for operand B
  val regB1 = RegInit(0.U(16.W))
  val regB2 = RegInit(0.U(16.W))
  val regB3 = RegInit(0.U(16.W))

  val regC0 = RegInit(0.U(1.W)) // Carry register between pipeline stages
  val regC1 = RegInit(0.U(1.W))
  val regC2 = RegInit(0.U(1.W))

  val regSum0 = RegInit(0.U(16.W)) // Registers to hold partial sum
  val regSum1 = RegInit(0.U(16.W))
  val regSum2 = RegInit(0.U(16.W))
  val regSum3 = RegInit(0.U(16.W))
  val regSumCarry = RegInit(0.U(1.W)) // Register to hold final carry

  val regEnable = RegInit(false.B) // Pipeline register for input enable sync
  val regEnableDelayed = RegInit(false.B)

  // Splitting 64-bit inputs into 16-bit chunks
  val chunkA = VecInit(io.adda(15, 0), io.adda(31, 16), io.adda(47, 32), io.adda(63, 48))
  val chunkB = VecInit(io.addb(15, 0), io.addb(31, 16), io.addb(47, 32), io.addb(63, 48))

  // Stage 1: Process first 16 bits
  when(io.i_en) {
    regA0 := chunkA(0)
    regB0 := chunkB(0)
    regEnable := io.i_en
  }
  when(regEnable) {
    val sum0 = regA0 +& regB0
    regSum0 := sum0(15, 0) // Save 16-bit sum
    regC0 := sum0(16)      // Save carry-out
  }

  // Stage 2: Process second 16 bits
  when(regEnable) {
    regA1 := chunkA(1)
    regB1 := chunkB(1)
    regEnableDelayed := regEnable
  }
  when(regEnableDelayed) {
    val sum1 = regA1 +& regB1 + regC0 // Add carry from stage 1
    regSum1 := sum1(15, 0)           // Save 16-bit sum
    regC1 := sum1(16)                // Save carry-out
  }

  // Stage 3: Process third 16 bits
  when(regEnableDelayed) {
    regA2 := chunkA(2)
    regB2 := chunkB(2)
  }
  when(regEnableDelayed) {
    val sum2 = regA2 +& regB2 + regC1 // Add carry from stage 2
    regSum2 := sum2(15, 0)           // Save 16-bit sum
    regC2 := sum2(16)                // Save carry-out
  }

  // Stage 4: Process fourth 16 bits
  when(regEnableDelayed) {
    regA3 := chunkA(3)
    regB3 := chunkB(3)
  }
  when(regEnableDelayed) {
    val sum3 = regA3 +& regB3 + regC2 // Add carry from stage 3
    regSum3 := sum3(15, 0)           // Save 16-bit sum
    regSumCarry := sum3(16)          // Save final carry
  }

  // Output the final result after all pipeline stages
  io.result := Cat(regSumCarry, regSum3, regSum2, regSum1, regSum0)
  io.o_en := regEnableDelayed
}


