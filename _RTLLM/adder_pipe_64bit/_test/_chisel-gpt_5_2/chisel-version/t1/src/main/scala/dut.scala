import chisel3._
import chisel3.util._

/**
  * 64-bit ripple-carry adder implemented as a 4-stage (16-bit each) pipeline.
  *
  * - i_en is pipelined through 4 stages; o_en asserts when final result is valid.
  * - result is 65 bits: {carry_out, sum[63:0]}.
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

  // Registers to hold operands through the pipeline
  val a1 = Reg(UInt(64.W))
  val b1 = Reg(UInt(64.W))
  val a2 = Reg(UInt(64.W))
  val b2 = Reg(UInt(64.W))
  val a3 = Reg(UInt(64.W))
  val b3 = Reg(UInt(64.W))
  val a4 = Reg(UInt(64.W))
  val b4 = Reg(UInt(64.W))

  // Capture operands at stage 1, then pipeline forward
  a1 := io.adda; b1 := io.addb
  a2 := a1;     b2 := b1
  a3 := a2;     b3 := b2
  a4 := a3;     b4 := b3

  // Sum registers for 4x16-bit chunks
  val sum0 = RegInit(0.U(16.W))
  val sum1 = RegInit(0.U(16.W))
  val sum2 = RegInit(0.U(16.W))
  val sum3 = RegInit(0.U(16.W))

  // Carry registers between stages
  val c1 = RegInit(0.U(1.W))
  val c2 = RegInit(0.U(1.W))
  val c3 = RegInit(0.U(1.W))
  val c4 = RegInit(0.U(1.W)) // final carry-out

  // Stage 1: bits [15:0], carry-in = 0
  val s1 = Wire(UInt(17.W))
  s1 := a1(15, 0) +& b1(15, 0) +& 0.U
  sum0 := s1(15, 0)
  c1   := s1(16)

  // Stage 2: bits [31:16]
  val s2 = Wire(UInt(17.W))
  s2 := a2(31, 16) +& b2(31, 16) +& c1
  sum1 := s2(15, 0)
  c2   := s2(16)

  // Stage 3: bits [47:32]
  val s3 = Wire(UInt(17.W))
  s3 := a3(47, 32) +& b3(47, 32) +& c2
  sum2 := s3(15, 0)
  c3   := s3(16)

  // Stage 4: bits [63:48]
  val s4 = Wire(UInt(17.W))
  s4 := a4(63, 48) +& b4(63, 48) +& c3
  sum3 := s4(15, 0)
  c4   := s4(16)

  io.result := Cat(c4, sum3, sum2, sum1, sum0)
}
