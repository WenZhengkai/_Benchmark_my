import chisel3._
import chisel3.util._

/**
  * 64-bit ripple-carry adder, split into 4x16-bit pipeline stages.
  *
  * - Input:  i_en, adda(64), addb(64)
  * - Output: result(65) = adda + addb, o_en indicates valid result
  *
  * Pipeline:
  *   Stage0: bits [15:0]
  *   Stage1: bits [31:16]
  *   Stage2: bits [47:32]
  *   Stage3: bits [63:48] + final carry -> 65-bit result
  */
class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())
    val adda   = Input(UInt(64.W))
    val addb   = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // -------- Pipeline enable shift register (aligns with 4 stages) --------
  val en_s0 = RegInit(false.B)
  val en_s1 = RegInit(false.B)
  val en_s2 = RegInit(false.B)
  val en_s3 = RegInit(false.B)

  en_s0 := io.i_en
  en_s1 := en_s0
  en_s2 := en_s1
  en_s3 := en_s2
  io.o_en := en_s3

  // -------- Operand pipeline registers (to align with stage computations) --------
  val a_s0 = Reg(UInt(64.W))
  val b_s0 = Reg(UInt(64.W))

  val a_s1 = Reg(UInt(64.W))
  val b_s1 = Reg(UInt(64.W))

  val a_s2 = Reg(UInt(64.W))
  val b_s2 = Reg(UInt(64.W))

  val a_s3 = Reg(UInt(64.W))
  val b_s3 = Reg(UInt(64.W))

  // Capture inputs; can be unconditional so pipeline stays time-aligned.
  a_s0 := io.adda
  b_s0 := io.addb
  a_s1 := a_s0
  b_s1 := b_s0
  a_s2 := a_s1
  b_s2 := b_s1
  a_s3 := a_s2
  b_s3 := b_s2

  // -------- Partial sums and carries per stage --------
  val sum0_r   = RegInit(0.U(16.W))
  val sum1_r   = RegInit(0.U(16.W))
  val sum2_r   = RegInit(0.U(16.W))
  val sum3_r   = RegInit(0.U(16.W))
  val carry0_r = RegInit(0.U(1.W))
  val carry1_r = RegInit(0.U(1.W))
  val carry2_r = RegInit(0.U(1.W))
  val carry3_r = RegInit(0.U(1.W)) // final carry out

  // Stage 0: add bits [15:0], carry-in = 0
  val a0 = a_s0(15, 0)
  val b0 = b_s0(15, 0)
  val s0 = a0 +& b0 // 17-bit
  sum0_r   := s0(15, 0)
  carry0_r := s0(16)

  // Stage 1: add bits [31:16] with carry from stage 0
  val a1 = a_s1(31, 16)
  val b1 = b_s1(31, 16)
  val s1 = a1 +& b1 +& carry0_r // 17-bit
  sum1_r   := s1(15, 0)
  carry1_r := s1(16)

  // Stage 2: add bits [47:32] with carry from stage 1
  val a2 = a_s2(47, 32)
  val b2 = b_s2(47, 32)
  val s2 = a2 +& b2 +& carry1_r // 17-bit
  sum2_r   := s2(15, 0)
  carry2_r := s2(16)

  // Stage 3: add bits [63:48] with carry from stage 2
  val a3 = a_s3(63, 48)
  val b3 = b_s3(63, 48)
  val s3 = a3 +& b3 +& carry2_r // 17-bit
  sum3_r   := s3(15, 0)
  carry3_r := s3(16)

  // -------- Result register (optional; gives clean registered output) --------
  val result_r = RegInit(0.U(65.W))
  result_r := Cat(carry3_r, sum3_r, sum2_r, sum1_r, sum0_r)
  io.result := result_r
}
