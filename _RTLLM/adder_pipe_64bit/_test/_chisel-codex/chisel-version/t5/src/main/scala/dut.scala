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

  // Enable pipeline (4 stages)
  val en1 = RegInit(false.B)
  val en2 = RegInit(false.B)
  val en3 = RegInit(false.B)
  val en4 = RegInit(false.B)

  en1 := io.i_en
  en2 := en1
  en3 := en2
  en4 := en3

  // Operand pipelines for upper chunks
  val a_r1 = RegInit(0.U(64.W))
  val a_r2 = RegInit(0.U(64.W))
  val a_r3 = RegInit(0.U(64.W))
  val b_r1 = RegInit(0.U(64.W))
  val b_r2 = RegInit(0.U(64.W))
  val b_r3 = RegInit(0.U(64.W))

  a_r1 := io.adda
  a_r2 := a_r1
  a_r3 := a_r2
  b_r1 := io.addb
  b_r2 := b_r1
  b_r3 := b_r2

  // Stage 0: bits [15:0]
  val s0 = io.adda(15, 0) +& io.addb(15, 0) // 17 bits
  val sum0_r   = RegInit(0.U(16.W))
  val carry0_r = RegInit(0.U(1.W))
  sum0_r   := s0(15, 0)
  carry0_r := s0(16)

  // Stage 1: bits [31:16]
  val s1 = a_r1(31, 16) +& b_r1(31, 16) + carry0_r
  val psum1_r  = RegInit(0.U(32.W)) // [31:0]
  val carry1_r = RegInit(0.U(1.W))
  psum1_r  := Cat(s1(15, 0), sum0_r)
  carry1_r := s1(16)

  // Stage 2: bits [47:32]
  val s2 = a_r2(47, 32) +& b_r2(47, 32) + carry1_r
  val psum2_r  = RegInit(0.U(48.W)) // [47:0]
  val carry2_r = RegInit(0.U(1.W))
  psum2_r  := Cat(s2(15, 0), psum1_r)
  carry2_r := s2(16)

  // Stage 3: bits [63:48] + final carry-out
  val s3 = a_r3(63, 48) +& b_r3(63, 48) + carry2_r
  val result_r = RegInit(0.U(65.W))
  result_r := Cat(s3(16), s3(15, 0), psum2_r)

  io.result := result_r
  io.o_en   := en4
}
