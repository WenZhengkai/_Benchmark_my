import chisel3._
import chisel3.util._

/** 64-bit ripple-carry adder split into 4x16-bit pipeline stages.
  *
  * - Inputs are captured when i_en is high.
  * - Four pipeline stages compute 16-bit chunks sequentially, propagating carry.
  * - Output result is valid when o_en is high (aligned with the 4-stage pipeline).
  */
class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())
    val adda   = Input(UInt(64.W))
    val addb   = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // ----------------------------
  // Stage 0: latch inputs
  // ----------------------------
  val en_s0 = RegInit(false.B)
  val a_s0  = Reg(UInt(64.W))
  val b_s0  = Reg(UInt(64.W))

  when(io.i_en) {
    a_s0 := io.adda
    b_s0 := io.addb
  }
  en_s0 := io.i_en

  // ----------------------------
  // Stage 1: bits [15:0]
  // ----------------------------
  val en_s1   = RegInit(false.B)
  val a_s1    = Reg(UInt(64.W))
  val b_s1    = Reg(UInt(64.W))
  val sum0_s1 = Reg(UInt(16.W))
  val c1_s1   = RegInit(0.U(1.W))

  val add0 = a_s0(15, 0) +& b_s0(15, 0) +& 0.U(1.W)

  when(en_s0) {
    a_s1    := a_s0
    b_s1    := b_s0
    sum0_s1 := add0(15, 0)
    c1_s1   := add0(16)
  }
  en_s1 := en_s0

  // ----------------------------
  // Stage 2: bits [31:16]
  // ----------------------------
  val en_s2    = RegInit(false.B)
  val a_s2     = Reg(UInt(64.W))
  val b_s2     = Reg(UInt(64.W))
  val sum0_s2  = Reg(UInt(16.W))
  val sum1_s2  = Reg(UInt(16.W))
  val c2_s2    = RegInit(0.U(1.W))

  val add1 = a_s1(31, 16) +& b_s1(31, 16) +& c1_s1

  when(en_s1) {
    a_s2    := a_s1
    b_s2    := b_s1
    sum0_s2 := sum0_s1
    sum1_s2 := add1(15, 0)
    c2_s2   := add1(16)
  }
  en_s2 := en_s1

  // ----------------------------
  // Stage 3: bits [47:32]
  // ----------------------------
  val en_s3    = RegInit(false.B)
  val a_s3     = Reg(UInt(64.W))
  val b_s3     = Reg(UInt(64.W))
  val sum0_s3  = Reg(UInt(16.W))
  val sum1_s3  = Reg(UInt(16.W))
  val sum2_s3  = Reg(UInt(16.W))
  val c3_s3    = RegInit(0.U(1.W))

  val add2 = a_s2(47, 32) +& b_s2(47, 32) +& c2_s2

  when(en_s2) {
    a_s3    := a_s2
    b_s3    := b_s2
    sum0_s3 := sum0_s2
    sum1_s3 := sum1_s2
    sum2_s3 := add2(15, 0)
    c3_s3   := add2(16)
  }
  en_s3 := en_s2

  // ----------------------------
  // Stage 4: bits [63:48] + final assembly
  // ----------------------------
  val en_s4   = RegInit(false.B)
  val res_s4  = RegInit(0.U(65.W))

  val add3 = a_s3(63, 48) +& b_s3(63, 48) +& c3_s3
  val sum3 = add3(15, 0)
  val c4   = add3(16)

  when(en_s3) {
    res_s4 := Cat(c4, sum3, sum2_s3, sum1_s3, sum0_s3) // 1 + 16*4 = 65
  }
  en_s4 := en_s3

  io.result := res_s4
  io.o_en   := en_s4
}
