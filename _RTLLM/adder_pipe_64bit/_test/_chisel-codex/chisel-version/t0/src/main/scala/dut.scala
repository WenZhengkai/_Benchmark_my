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
  // Enable pipeline (4 stages)
  // -----------------------------
  val en0 = RegInit(false.B)
  val en1 = RegInit(false.B)
  val en2 = RegInit(false.B)
  val en3 = RegInit(false.B)

  en0 := io.i_en
  en1 := en0
  en2 := en1
  en3 := en2

  io.o_en := en3

  // -----------------------------
  // Delay operands for upper stages
  // -----------------------------
  val a_r1 = RegInit(0.U(64.W))
  val b_r1 = RegInit(0.U(64.W))
  val a_r2 = RegInit(0.U(64.W))
  val b_r2 = RegInit(0.U(64.W))
  val a_r3 = RegInit(0.U(64.W))
  val b_r3 = RegInit(0.U(64.W))

  a_r1 := io.adda
  b_r1 := io.addb
  a_r2 := a_r1
  b_r2 := b_r1
  a_r3 := a_r2
  b_r3 := b_r2

  // -----------------------------
  // Stage 0: bits [15:0]
  // -----------------------------
  val sum0_w = io.adda(15, 0) +& io.addb(15, 0) // 17-bit
  val sum0_r = RegInit(0.U(16.W))
  val c0_r   = RegInit(0.U(1.W))

  sum0_r := sum0_w(15, 0)
  c0_r   := sum0_w(16)

  // -----------------------------
  // Stage 1: bits [31:16]
  // -----------------------------
  val sum1_w = a_r1(31, 16) +& b_r1(31, 16) +& c0_r // 17-bit
  val sum01_r = RegInit(0.U(32.W))
  val c1_r    = RegInit(0.U(1.W))

  sum01_r := Cat(sum1_w(15, 0), sum0_r)
  c1_r    := sum1_w(16)

  // -----------------------------
  // Stage 2: bits [47:32]
  // -----------------------------
  val sum2_w = a_r2(47, 32) +& b_r2(47, 32) +& c1_r // 17-bit
  val sum012_r = RegInit(0.U(48.W))
  val c2_r     = RegInit(0.U(1.W))

  sum012_r := Cat(sum2_w(15, 0), sum01_r)
  c2_r     := sum2_w(16)

  // -----------------------------
  // Stage 3: bits [63:48]
  // -----------------------------
  val sum3_w = a_r3(63, 48) +& b_r3(63, 48) +& c2_r // 17-bit
  val result_r = RegInit(0.U(65.W))

  // Final result = carry_out :: upper16 :: middle48
  result_r := Cat(sum3_w(16), sum3_w(15, 0), sum012_r)

  io.result := result_r
}
