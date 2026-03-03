import chisel3._
import chisel3.util._

/**
  * 64-bit ripple-carry adder implemented as a 4-stage (16-bit per stage) pipeline.
  *
  * - Inputs are captured when i_en is high.
  * - Then 4 pipeline stages compute bits [15:0], [31:16], [47:32], [63:48] sequentially.
  * - result is 65-bit: {carry_out, sum[63:0]}
  * - o_en asserts for one cycle when the corresponding result is valid.
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
  // Pipeline enable shift-register
  // ----------------------------
  val en_s0 = RegInit(false.B)
  val en_s1 = RegInit(false.B)
  val en_s2 = RegInit(false.B)
  val en_s3 = RegInit(false.B)

  en_s0 := io.i_en
  en_s1 := en_s0
  en_s2 := en_s1
  en_s3 := en_s2

  io.o_en := en_s3

  // ----------------------------
  // Input operand pipeline regs
  // Keep operands aligned with the staged computation
  // ----------------------------
  val a_s0 = Reg(UInt(64.W))
  val b_s0 = Reg(UInt(64.W))
  when(io.i_en) {
    a_s0 := io.adda
    b_s0 := io.addb
  }

  val a_s1 = Reg(UInt(64.W))
  val b_s1 = Reg(UInt(64.W))
  when(en_s0) {
    a_s1 := a_s0
    b_s1 := b_s0
  }

  val a_s2 = Reg(UInt(64.W))
  val b_s2 = Reg(UInt(64.W))
  when(en_s1) {
    a_s2 := a_s1
    b_s2 := b_s1
  }

  val a_s3 = Reg(UInt(64.W))
  val b_s3 = Reg(UInt(64.W))
  when(en_s2) {
    a_s3 := a_s2
    b_s3 := b_s2
  }

  // ----------------------------
  // Stage 0: bits [15:0]
  // ----------------------------
  val sum16_s0  = Reg(UInt(16.W))
  val carry_s0  = RegInit(0.U(1.W))

  val add0 = Wire(UInt(17.W))
  add0 := a_s0(15, 0) +& b_s0(15, 0) +& 0.U

  when(io.i_en) {
    sum16_s0 := add0(15, 0)
    carry_s0 := add0(16)
  }

  // Accumulated sum through the pipeline
  val sum_lo_s1 = Reg(UInt(32.W)) // [31:0] valid after stage1
  val sum_lo_s2 = Reg(UInt(48.W)) // [47:0] valid after stage2
  val sum_lo_s3 = Reg(UInt(64.W)) // [63:0] valid after stage3
  val carry_s1  = RegInit(0.U(1.W))
  val carry_s2  = RegInit(0.U(1.W))
  val carry_s3  = RegInit(0.U(1.W))

  // ----------------------------
  // Stage 1: bits [31:16]
  // ----------------------------
  val add1 = Wire(UInt(17.W))
  add1 := a_s1(31, 16) +& b_s1(31, 16) +& carry_s0

  when(en_s0) {
    sum_lo_s1 := Cat(add1(15, 0), sum16_s0) // [31:16] ++ [15:0]
    carry_s1  := add1(16)
  }

  // ----------------------------
  // Stage 2: bits [47:32]
  // ----------------------------
  val add2 = Wire(UInt(17.W))
  add2 := a_s2(47, 32) +& b_s2(47, 32) +& carry_s1

  when(en_s1) {
    sum_lo_s2 := Cat(add2(15, 0), sum_lo_s1) // [47:32] ++ [31:0]
    carry_s2  := add2(16)
  }

  // ----------------------------
  // Stage 3: bits [63:48]
  // ----------------------------
  val add3 = Wire(UInt(17.W))
  add3 := a_s3(63, 48) +& b_s3(63, 48) +& carry_s2

  when(en_s2) {
    sum_lo_s3 := Cat(add3(15, 0), sum_lo_s2) // [63:48] ++ [47:0]
    carry_s3  := add3(16)
  }

  // ----------------------------
  // Output register (aligned with en_s3)
  // ----------------------------
  val result_r = RegInit(0.U(65.W))
  when(en_s3) {
    result_r := Cat(carry_s3, sum_lo_s3)
  }

  io.result := result_r
}
