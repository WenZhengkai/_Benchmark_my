import chisel3._
import chisel3.util._

/**
  * dut: 64-bit ripple-carry adder implemented as a 4-stage (16-bit per stage) pipeline.
  *
  * - Inputs are captured when i_en is asserted.
  * - The addition is performed over 4 sequential pipeline stages:
  *     stage0: bits [15:0]
  *     stage1: bits [31:16]
  *     stage2: bits [47:32]
  *     stage3: bits [63:48]
  * - result is 65 bits (includes final carry-out).
  * - o_en asserts when the output result is valid.
  */
class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())
    val adda   = Input(UInt(64.W))
    val addb   = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // Pipeline enable shift register (tracks validity through 4 stages)
  val en0 = RegInit(false.B)
  val en1 = RegInit(false.B)
  val en2 = RegInit(false.B)
  val en3 = RegInit(false.B)

  // Register inputs at stage 0 when enabled
  val a0 = RegInit(0.U(64.W))
  val b0 = RegInit(0.U(64.W))

  when(io.i_en) {
    a0 := io.adda
    b0 := io.addb
  }

  en0 := io.i_en
  en1 := en0
  en2 := en1
  en3 := en2

  // Stage 0: add lower 16 bits, carry-in = 0
  val sum0_reg   = RegInit(0.U(16.W))
  val carry0_reg = RegInit(0.U(1.W))

  val s0 = a0(15, 0) +& b0(15, 0) // 17-bit result
  when(en0) {
    sum0_reg   := s0(15, 0)
    carry0_reg := s0(16)
  }

  // Stage 1: add bits [31:16] with carry from stage 0
  val a1 = RegInit(0.U(64.W))
  val b1 = RegInit(0.U(64.W))
  when(en0) {
    a1 := a0
    b1 := b0
  }

  val sum1_reg   = RegInit(0.U(16.W))
  val carry1_reg = RegInit(0.U(1.W))

  val s1 = a1(31, 16) +& b1(31, 16) + carry0_reg
  when(en1) {
    sum1_reg   := s1(15, 0)
    carry1_reg := s1(16)
  }

  // Stage 2: add bits [47:32] with carry from stage 1
  val a2 = RegInit(0.U(64.W))
  val b2 = RegInit(0.U(64.W))
  when(en1) {
    a2 := a1
    b2 := b1
  }

  val sum2_reg   = RegInit(0.U(16.W))
  val carry2_reg = RegInit(0.U(1.W))

  val s2 = a2(47, 32) +& b2(47, 32) + carry1_reg
  when(en2) {
    sum2_reg   := s2(15, 0)
    carry2_reg := s2(16)
  }

  // Stage 3: add bits [63:48] with carry from stage 2, produce final carry
  val a3 = RegInit(0.U(64.W))
  val b3 = RegInit(0.U(64.W))
  when(en2) {
    a3 := a2
    b3 := b2
  }

  val sum3_reg       = RegInit(0.U(16.W))
  val finalCarry_reg = RegInit(0.U(1.W))

  val s3 = a3(63, 48) +& b3(63, 48) + carry2_reg
  when(en3) {
    sum3_reg       := s3(15, 0)
    finalCarry_reg := s3(16)
  }

  // Output assembly (valid when en3 is high)
  io.result := Cat(finalCarry_reg, sum3_reg, sum2_reg, sum1_reg, sum0_reg)
  io.o_en   := en3
}
