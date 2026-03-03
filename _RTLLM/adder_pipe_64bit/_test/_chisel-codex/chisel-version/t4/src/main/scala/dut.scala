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

  // --------------------------------------------------------------------------
  // Valid pipeline (4 stages total: 16b + 16b + 16b + 16b)
  // --------------------------------------------------------------------------
  val v0 = RegInit(false.B)
  val v1 = RegInit(false.B)
  val v2 = RegInit(false.B)
  val v3 = RegInit(false.B)

  v0 := io.i_en
  v1 := v0
  v2 := v1
  v3 := v2

  // --------------------------------------------------------------------------
  // Stage 0: bits [15:0]
  // --------------------------------------------------------------------------
  val s0_sum0  = RegInit(0.U(16.W))
  val s0_carry = RegInit(0.U(1.W))
  val s0_a1    = RegInit(0.U(16.W))
  val s0_b1    = RegInit(0.U(16.W))
  val s0_a2    = RegInit(0.U(16.W))
  val s0_b2    = RegInit(0.U(16.W))
  val s0_a3    = RegInit(0.U(16.W))
  val s0_b3    = RegInit(0.U(16.W))

  when(io.i_en) {
    val add0 = io.adda(15, 0) +& io.addb(15, 0)
    s0_sum0  := add0(15, 0)
    s0_carry := add0(16)

    s0_a1 := io.adda(31, 16)
    s0_b1 := io.addb(31, 16)
    s0_a2 := io.adda(47, 32)
    s0_b2 := io.addb(47, 32)
    s0_a3 := io.adda(63, 48)
    s0_b3 := io.addb(63, 48)
  }

  // --------------------------------------------------------------------------
  // Stage 1: bits [31:16]
  // --------------------------------------------------------------------------
  val s1_sum0  = RegInit(0.U(16.W))
  val s1_sum1  = RegInit(0.U(16.W))
  val s1_carry = RegInit(0.U(1.W))
  val s1_a2    = RegInit(0.U(16.W))
  val s1_b2    = RegInit(0.U(16.W))
  val s1_a3    = RegInit(0.U(16.W))
  val s1_b3    = RegInit(0.U(16.W))

  when(v0) {
    val add1 = s0_a1 +& s0_b1 +& s0_carry
    s1_sum0  := s0_sum0
    s1_sum1  := add1(15, 0)
    s1_carry := add1(16)

    s1_a2 := s0_a2
    s1_b2 := s0_b2
    s1_a3 := s0_a3
    s1_b3 := s0_b3
  }

  // --------------------------------------------------------------------------
  // Stage 2: bits [47:32]
  // --------------------------------------------------------------------------
  val s2_sum0  = RegInit(0.U(16.W))
  val s2_sum1  = RegInit(0.U(16.W))
  val s2_sum2  = RegInit(0.U(16.W))
  val s2_carry = RegInit(0.U(1.W))
  val s2_a3    = RegInit(0.U(16.W))
  val s2_b3    = RegInit(0.U(16.W))

  when(v1) {
    val add2 = s1_a2 +& s1_b2 +& s1_carry
    s2_sum0  := s1_sum0
    s2_sum1  := s1_sum1
    s2_sum2  := add2(15, 0)
    s2_carry := add2(16)

    s2_a3 := s1_a3
    s2_b3 := s1_b3
  }

  // --------------------------------------------------------------------------
  // Stage 3: bits [63:48], then pack final 65-bit result
  // --------------------------------------------------------------------------
  val resultReg = RegInit(0.U(65.W))

  when(v2) {
    val add3 = s2_a3 +& s2_b3 +& s2_carry
    val sum3 = add3(15, 0)
    val cOut = add3(16)

    resultReg := Cat(cOut, sum3, s2_sum2, s2_sum1, s2_sum0)
  }

  io.result := resultReg
  io.o_en   := v3
}
