// Import necessary Chisel libraries
import chisel3._
import chisel3.util._

/**
 * A pipeline 64-bit ripple carry adder module.
 */
class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())          // Enable signal for addition operation
    val adda   = Input(UInt(64.W))      // 64-bit input operand A
    val addb   = Input(UInt(64.W))      // 64-bit input operand B
    val result = Output(UInt(65.W))     // 65-bit output (sum)
    val o_en   = Output(Bool())         // Output enable signal
  })

  // Pipeline stage registers
  val s0_en   = RegNext(next = io.i_en, init = false.B) // Stage 0 enable
  val s1_en   = RegNext(next = s0_en, init = false.B)   // Stage 1 enable
  val s2_en   = RegNext(next = s1_en, init = false.B)   // Stage 2 enable
  val s3_en   = RegNext(next = s2_en, init = false.B)   // Stage 3 enable
  val s4_en   = RegNext(next = s3_en, init = false.B)   // Final stage enable

  // Pipeline registers for input operands
  val stage0_adda = RegNext(next = io.adda(15, 0), init = 0.U(16.W))
  val stage0_addb = RegNext(next = io.addb(15, 0), init = 0.U(16.W))
  val stage1_adda = RegNext(next = io.adda(31, 16), init = 0.U(16.W))
  val stage1_addb = RegNext(next = io.addb(31, 16), init = 0.U(16.W))
  val stage2_adda = RegNext(next = io.adda(47, 32), init = 0.U(16.W))
  val stage2_addb = RegNext(next = io.addb(47, 32), init = 0.U(16.W))
  val stage3_adda = RegNext(next = io.adda(63, 48), init = 0.U(16.W))
  val stage3_addb = RegNext(next = io.addb(63, 48), init = 0.U(16.W))

  // Pipeline registers for carry and intermediate sums
  val stage1_carry = Reg(UInt(1.W))
  val stage1_sum   = Reg(UInt(16.W))
  val stage2_carry = Reg(UInt(1.W))
  val stage2_sum   = Reg(UInt(16.W))
  val stage3_carry = Reg(UInt(1.W))
  val stage3_sum   = Reg(UInt(16.W))
  val stage4_carry = Reg(UInt(1.W))
  val stage4_sum   = Reg(UInt(16.W))

  // Stage 0: Compute least significant 16 bits
  val stage0_add = stage0_adda +& stage0_addb
  stage1_sum := stage0_add(15, 0)
  stage1_carry := stage0_add(16)

  // Stage 1: Compute next 16 bits using previous carry
  val stage1_add = stage1_adda +& stage1_addb + stage1_carry
  stage2_sum := stage1_add(15, 0)
  stage2_carry := stage1_add(16)

  // Stage 2: Compute next 16 bits using previous carry
  val stage2_add = stage2_adda +& stage2_addb + stage2_carry
  stage3_sum := stage2_add(15, 0)
  stage3_carry := stage2_add(16)

  // Stage 3: Compute most significant 16 bits using previous carry
  val stage3_add = stage3_adda +& stage3_addb + stage3_carry
  stage4_sum := stage3_add(15, 0)
  stage4_carry := stage3_add(16)

  // Final stage: Combine all the results
  io.result := Cat(stage4_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum)
  io.o_en := s4_en
}


