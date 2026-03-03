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

  // -----------------------------
  // Valid pipeline (4 stages)
  // -----------------------------
  val v0 = RegInit(false.B)
  val v1 = RegInit(false.B)
  val v2 = RegInit(false.B)
  val v3 = RegInit(false.B)

  v0 := io.i_en
  v1 := v0
  v2 := v1
  v3 := v2

  io.o_en := v3

  // -----------------------------
  // Delay operand chunks to align with each stage
  // -----------------------------
  val a1_d1 = Reg(UInt(16.W))
  val b1_d1 = Reg(UInt(16.W))

  val a2_d1 = Reg(UInt(16.W))
  val b2_d1 = Reg(UInt(16.W))
  val a2_d2 = Reg(UInt(16.W))
  val b2_d2 = Reg(UInt(16.W))

  val a3_d1 = Reg(UInt(16.W))
  val b3_d1 = Reg(UInt(16.W))
  val a3_d2 = Reg(UInt(16.W))
  val b3_d2 = Reg(UInt(16.W))
  val a3_d3 = Reg(UInt(16.W))
  val b3_d3 = Reg(UInt(16.W))

  a1_d1 := io.adda(31, 16)
  b1_d1 := io.addb(31, 16)

  a2_d1 := io.adda(47, 32)
  b2_d1 := io.addb(47, 32)
  a2_d2 := a2_d1
  b2_d2 := b2_d1

  a3_d1 := io.adda(63, 48)
  b3_d1 := io.addb(63, 48)
  a3_d2 := a3_d1
  b3_d2 := b3_d1
  a3_d3 := a3_d2
  b3_d3 := b3_d2

  // -----------------------------
  // Stage 0: bits [15:0]
  // -----------------------------
  val s0 = io.adda(15, 0) +& io.addb(15, 0) // 17-bit
  val sum0_r   = Reg(UInt(16.W))
  val carry0_r = Reg(UInt(1.W))
  sum0_r   := s0(15, 0)
  carry0_r := s0(16)

  // -----------------------------
  // Stage 1: bits [31:16]
  // -----------------------------
  val s1 = a1_d1 +& b1_d1 +& carry0_r
  val sum1_r   = Reg(UInt(16.W))
  val carry1_r = Reg(UInt(1.W))
  sum1_r   := s1(15, 0)
  carry1_r := s1(16)

  // -----------------------------
  // Stage 2: bits [47:32]
  // -----------------------------
  val s2 = a2_d2 +& b2_d2 +& carry1_r
  val sum2_r   = Reg(UInt(16.W))
  val carry2_r = Reg(UInt(1.W))
  sum2_r   := s2(15, 0)
  carry2_r := s2(16)

  // -----------------------------
  // Stage 3: bits [63:48]
  // -----------------------------
  val s3 = a3_d3 +& b3_d3 +& carry2_r
  val sum3_r   = Reg(UInt(16.W))
  val carry3_r = Reg(UInt(1.W))
  sum3_r   := s3(15, 0)
  carry3_r := s3(16)

  // -----------------------------
  // Align partial sums for final output
  // -----------------------------
  val sum0_d1 = Reg(UInt(16.W))
  val sum0_d2 = Reg(UInt(16.W))
  val sum0_d3 = Reg(UInt(16.W))

  val sum1_d1 = Reg(UInt(16.W))
  val sum1_d2 = Reg(UInt(16.W))

  val sum2_d1 = Reg(UInt(16.W))

  sum0_d1 := sum0_r
  sum0_d2 := sum0_d1
  sum0_d3 := sum0_d2

  sum1_d1 := sum1_r
  sum1_d2 := sum1_d1

  sum2_d1 := sum2_r

  io.result := Cat(carry3_r, sum3_r, sum2_d1, sum1_d2, sum0_d3)
}
