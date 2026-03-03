import chisel3._
import chisel3.util._

/**
  * 64-bit ripple-carry adder split into 4 pipeline stages (16 bits per stage).
  * Latency: 4 cycles from i_en assertion to o_en/result valid.
  *
  * result is 65 bits: {carry_out, sum[63:0]}
  */
class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())
    val adda   = Input(UInt(64.W))
    val addb   = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // -----------------------------
  // Stage 0: register inputs
  // -----------------------------
  val s0_en   = RegInit(false.B)
  val s0_adda = Reg(UInt(64.W))
  val s0_addb = Reg(UInt(64.W))

  s0_en   := io.i_en
  s0_adda := io.adda
  s0_addb := io.addb

  // Helper to add two 16-bit parts + carry-in => (sum16, carryOut)
  def add16(a: UInt, b: UInt, cin: Bool): (UInt, Bool) = {
    val tmp = Wire(UInt(17.W))
    tmp := a +& b + cin.asUInt
    (tmp(15, 0), tmp(16))
  }

  // -----------------------------
  // Stage 1: bits [15:0]
  // -----------------------------
  val s1_en    = RegInit(false.B)
  val s1_adda  = Reg(UInt(64.W))
  val s1_addb  = Reg(UInt(64.W))
  val s1_sum0  = Reg(UInt(16.W))
  val s1_carry = RegInit(false.B)

  val (sum0_w, c1_w) = add16(s0_adda(15, 0), s0_addb(15, 0), false.B)

  s1_en    := s0_en
  s1_adda  := s0_adda
  s1_addb  := s0_addb
  s1_sum0  := sum0_w
  s1_carry := c1_w

  // -----------------------------
  // Stage 2: bits [31:16]
  // -----------------------------
  val s2_en     = RegInit(false.B)
  val s2_adda   = Reg(UInt(64.W))
  val s2_addb   = Reg(UInt(64.W))
  val s2_sum0   = Reg(UInt(16.W))
  val s2_sum1   = Reg(UInt(16.W))
  val s2_carry  = RegInit(false.B)

  val (sum1_w, c2_w) = add16(s1_adda(31, 16), s1_addb(31, 16), s1_carry)

  s2_en    := s1_en
  s2_adda  := s1_adda
  s2_addb  := s1_addb
  s2_sum0  := s1_sum0
  s2_sum1  := sum1_w
  s2_carry := c2_w

  // -----------------------------
  // Stage 3: bits [47:32]
  // -----------------------------
  val s3_en     = RegInit(false.B)
  val s3_adda   = Reg(UInt(64.W))
  val s3_addb   = Reg(UInt(64.W))
  val s3_sum0   = Reg(UInt(16.W))
  val s3_sum1   = Reg(UInt(16.W))
  val s3_sum2   = Reg(UInt(16.W))
  val s3_carry  = RegInit(false.B)

  val (sum2_w, c3_w) = add16(s2_adda(47, 32), s2_addb(47, 32), s2_carry)

  s3_en    := s2_en
  s3_adda  := s2_adda
  s3_addb  := s2_addb
  s3_sum0  := s2_sum0
  s3_sum1  := s2_sum1
  s3_sum2  := sum2_w
  s3_carry := c3_w

  // -----------------------------
  // Stage 4: bits [63:48] and output register
  // -----------------------------
  val s4_en     = RegInit(false.B)
  val s4_sum0   = Reg(UInt(16.W))
  val s4_sum1   = Reg(UInt(16.W))
  val s4_sum2   = Reg(UInt(16.W))
  val s4_sum3   = Reg(UInt(16.W))
  val s4_carry  = RegInit(false.B)

  val (sum3_w, c4_w) = add16(s3_adda(63, 48), s3_addb(63, 48), s3_carry)

  s4_en    := s3_en
  s4_sum0  := s3_sum0
  s4_sum1  := s3_sum1
  s4_sum2  := s3_sum2
  s4_sum3  := sum3_w
  s4_carry := c4_w

  // Output enable and result are aligned to stage 4
  io.o_en   := s4_en
  io.result := Cat(s4_carry, s4_sum3, s4_sum2, s4_sum1, s4_sum0)
}
