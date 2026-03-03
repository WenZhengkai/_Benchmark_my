import chisel3._
import chisel3.util._

/**
  * 64-bit ripple-carry adder split into 4x16-bit pipeline stages.
  *
  * - Accepts input when i_en=1.
  * - Produces a 65-bit sum after 4 pipeline stages.
  * - o_en is the delayed/registered enable aligned with result.
  */
class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())
    val adda   = Input(UInt(64.W))
    val addb   = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // Stage 0 registers (latch inputs and enable)
  val en0   = RegInit(false.B)
  val a0    = Reg(UInt(64.W))
  val b0    = Reg(UInt(64.W))
  val sum0  = RegInit(0.U(16.W))
  val c0    = RegInit(0.U(1.W)) // carry out of stage0 into stage1

  // Stage 1 registers
  val en1   = RegInit(false.B)
  val a1    = Reg(UInt(64.W))
  val b1    = Reg(UInt(64.W))
  val sum1  = RegInit(0.U(16.W))
  val c1    = RegInit(0.U(1.W))

  // Stage 2 registers
  val en2   = RegInit(false.B)
  val a2    = Reg(UInt(64.W))
  val b2    = Reg(UInt(64.W))
  val sum2  = RegInit(0.U(16.W))
  val c2    = RegInit(0.U(1.W))

  // Stage 3 registers
  val en3   = RegInit(false.B)
  val sum3  = RegInit(0.U(16.W))
  val c3    = RegInit(0.U(1.W)) // final carry out (MSB+1)

  // Output registers
  val en4   = RegInit(false.B)
  val resR  = RegInit(0.U(65.W))

  // Default outputs
  io.result := resR
  io.o_en   := en4

  // Helper: add 16-bit chunks + carry-in -> (sum16, carryOut)
  def add16(x: UInt, y: UInt, cin: UInt): (UInt, UInt) = {
    val full = Wire(UInt(17.W))
    full := x +& y +& cin
    (full(15, 0), full(16))
  }

  // ----------------------------
  // Stage 0: bits [15:0], cin=0
  // ----------------------------
  val (s0, co0) = add16(io.adda(15, 0), io.addb(15, 0), 0.U)

  when(io.i_en) {
    a0   := io.adda
    b0   := io.addb
    sum0 := s0
    c0   := co0
  }
  en0 := io.i_en

  // ----------------------------
  // Stage 1: bits [31:16], cin=c0
  // ----------------------------
  val (s1, co1) = add16(a0(31, 16), b0(31, 16), c0)

  when(en0) {
    a1   := a0
    b1   := b0
    sum1 := s1
    c1   := co1
  }
  en1 := en0

  // ----------------------------
  // Stage 2: bits [47:32], cin=c1
  // ----------------------------
  val (s2, co2) = add16(a1(47, 32), b1(47, 32), c1)

  when(en1) {
    a2   := a1
    b2   := b1
    sum2 := s2
    c2   := co2
  }
  en2 := en1

  // ----------------------------
  // Stage 3: bits [63:48], cin=c2
  // ----------------------------
  val (s3, co3) = add16(a2(63, 48), b2(63, 48), c2)

  when(en2) {
    sum3 := s3
    c3   := co3
  }
  en3 := en2

  // ----------------------------
  // Output stage: assemble 65-bit result
  // ----------------------------
  when(en3) {
    resR := Cat(c3, sum3, sum2, sum1, sum0)
  }
  en4 := en3
}
