import chisel3._
import chisel3.util._

/** 64-bit ripple-carry adder split into 4 pipeline stages (16-bit each).
  * - Input valid:  i_en
  * - Output valid: o_en (i_en delayed by 4 stages)
  * - Output sum:   result (65-bit)
  */
class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())
    val adda   = Input(UInt(64.W))
    val addb   = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // Pipeline enable shift register (4 stages)
  val en1 = RegInit(false.B)
  val en2 = RegInit(false.B)
  val en3 = RegInit(false.B)
  val en4 = RegInit(false.B)

  en1 := io.i_en
  en2 := en1
  en3 := en2
  en4 := en3
  io.o_en := en4

  // Stage 0: register inputs when enabled
  val a0 = RegInit(0.U(64.W))
  val b0 = RegInit(0.U(64.W))
  when(io.i_en) {
    a0 := io.adda
    b0 := io.addb
  }

  // ---- Stage 1: bits [15:0] ----
  val s0_reg  = RegInit(0.U(16.W))
  val c1_reg  = RegInit(0.U(1.W))
  val a1_reg  = RegInit(0.U(64.W))
  val b1_reg  = RegInit(0.U(64.W))

  val part0 = a0(15, 0) +& b0(15, 0) // 17-bit
  when(en1) {
    s0_reg := part0(15, 0)
    c1_reg := part0(16)
    a1_reg := a0
    b1_reg := b0
  }

  // ---- Stage 2: bits [31:16] + carry ----
  val s1_reg  = RegInit(0.U(16.W))
  val c2_reg  = RegInit(0.U(1.W))
  val s01_reg = RegInit(0.U(32.W))
  val a2_reg  = RegInit(0.U(64.W))
  val b2_reg  = RegInit(0.U(64.W))

  val part1 = a1_reg(31, 16) +& b1_reg(31, 16) + c1_reg // 17-bit
  when(en2) {
    s1_reg  := part1(15, 0)
    c2_reg  := part1(16)
    s01_reg := Cat(part1(15, 0), s0_reg) // [31:16]=s1, [15:0]=s0
    a2_reg  := a1_reg
    b2_reg  := b1_reg
  }

  // ---- Stage 3: bits [47:32] + carry ----
  val s2_reg   = RegInit(0.U(16.W))
  val c3_reg   = RegInit(0.U(1.W))
  val s012_reg = RegInit(0.U(48.W))
  val a3_reg   = RegInit(0.U(64.W))
  val b3_reg   = RegInit(0.U(64.W))

  val part2 = a2_reg(47, 32) +& b2_reg(47, 32) + c2_reg // 17-bit
  when(en3) {
    s2_reg   := part2(15, 0)
    c3_reg   := part2(16)
    s012_reg := Cat(part2(15, 0), s01_reg) // [47:32]=s2, [31:0]=s01
    a3_reg   := a2_reg
    b3_reg   := b2_reg
  }

  // ---- Stage 4: bits [63:48] + carry, produce final 65-bit result ----
  val result_reg = RegInit(0.U(65.W))

  val part3 = a3_reg(63, 48) +& b3_reg(63, 48) + c3_reg // 17-bit: [16]=carry out
  when(en4) {
    // Final sum: {carry_out, sum[63:48], sum[47:0]}
    result_reg := Cat(part3(16), part3(15, 0), s012_reg)
  }

  io.result := result_reg
}
