import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())                // Enable signal for addition operation
    val adda   = Input(UInt(64.W))           // 64-bit input operand A
    val addb   = Input(UInt(64.W))           // 64-bit input operand B
    val result = Output(UInt(65.W))          // 65-bit result (includes carry out)
    val o_en   = Output(Bool())              // Output enable signal
  })

  // Pipeline registers for operands and carry
  val s1_en = RegInit(false.B)               // Stage 1 enable
  val s2_en = RegInit(false.B)               // Stage 2 enable
  val s3_en = RegInit(false.B)               // Stage 3 enable
  val s4_en = RegInit(false.B)               // Stage 4 enable
  val s1_adda = RegInit(0.U(64.W))           // Stage 1 operand A
  val s1_addb = RegInit(0.U(64.W))           // Stage 1 operand B
  val s2_sum = RegInit(0.U(16.W))            // Stage 2 partial sum
  val s2_carry = RegInit(0.U(1.W))           // Stage 2 carry out
  val s3_sum = RegInit(0.U(32.W))            // Stage 3 partial sum
  val s3_carry = RegInit(0.U(1.W))           // Stage 3 carry out
  val s4_sum = RegInit(0.U(48.W))            // Stage 4 partial sum
  val s4_carry = RegInit(0.U(1.W))           // Stage 4 carry out

  // Pipeline logic for 4 stages
  // 1st stage: Split input into 16-bit chunks and compute initial sum and carry
  when(io.i_en) {
    s1_en := io.i_en
    s1_adda := io.adda
    s1_addb := io.addb
  } .otherwise {
    s1_en := false.B
  }

  // Stage 2: Add lower 16 bits of the two operands
  val (sum1, carry1) = {
    val partialSum = s1_adda(15, 0) + s1_addb(15, 0)
    (partialSum(15, 0), partialSum(16))      // Output 16-bit sum and carry out
  }
  when(s1_en) {
    s2_en := s1_en
    s2_sum := sum1
    s2_carry := carry1
  } .otherwise {
    s2_en := false.B
  }

  // Stage 3: Add middle 16 bits along with carry from the previous stage
  val (sum2, carry2) = {
    val partialSum = s1_adda(31, 16) + s1_addb(31, 16) + s2_carry
    (partialSum(15, 0), partialSum(16))      // Output 16-bit sum and carry out
  }
  when(s2_en) {
    s3_en := s2_en
    s3_sum := Cat(sum2, s2_sum)              // Accumulate sum
    s3_carry := carry2
  } .otherwise {
    s3_en := false.B
  }

  // Stage 4: Add upper 16 bits along with carry from the previous stage
  val (sum3, carry3) = {
    val partialSum = s1_adda(47, 32) + s1_addb(47, 32) + s3_carry
    (partialSum(15, 0), partialSum(16))      // Output 16-bit sum and carry out
  }
  when(s3_en) {
    s4_en := s3_en
    s4_sum := Cat(sum3, s3_sum)
    s4_carry := carry3
  } .otherwise {
    s4_en := false.B
  }

  // Combine all bits into the final result in the last stage
  val (sum4, carry4) = {
    val partialSum = s1_adda(63, 48) + s1_addb(63, 48) + s4_carry
    (partialSum(15, 0), partialSum(16))      // Output 16-bit sum and carry out
  }
  val finalSum = Cat(sum4, s4_sum)
  val finalCarry = carry4

  // Write to output ports
  io.result := Cat(finalCarry, finalSum)    // Concatenate final carry and sum
  io.o_en := s4_en                          // Output enable is set in the last stage
}
