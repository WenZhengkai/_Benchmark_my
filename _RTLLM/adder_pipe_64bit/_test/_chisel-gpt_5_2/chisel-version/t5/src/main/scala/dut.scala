import chisel3._
import chisel3.util._

/**
  * 64-bit ripple-carry adder split into 4x16-bit pipeline stages.
  *
  * - Input valid:  i_en
  * - Output valid: o_en asserted when result is valid
  * - Latency: 4 cycles from i_en high to o_en high (assuming i_en is a pulse)
  * - result is 65-bit: {carry_out, sum[63:0]}
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
  val en0 = RegInit(false.B)
  val en1 = RegInit(false.B)
  val en2 = RegInit(false.B)
  val en3 = RegInit(false.B)

  en0 := io.i_en
  en1 := en0
  en2 := en1
  en3 := en2
  io.o_en := en3

  // Stage operand registers (to align operands with pipeline stages)
  val a0 = Reg(UInt(64.W))
  val b0 = Reg(UInt(64.W))
  val a1 = Reg(UInt(64.W))
  val b1 = Reg(UInt(64.W))
  val a2 = Reg(UInt(64.W))
  val b2 = Reg(UInt(64.W))
  val a3 = Reg(UInt(64.W))
  val b3 = Reg(UInt(64.W))

  when(io.i_en) {
    a0 := io.adda
    b0 := io.addb
  }
  when(en0) { a1 := a0; b1 := b0 }
  when(en1) { a2 := a1; b2 := b1 }
  when(en2) { a3 := a2; b3 := b2 }

  // Carry pipeline registers between 16-bit chunks
  val c1 = RegInit(false.B) // carry after bits [15:0]
  val c2 = RegInit(false.B) // carry after bits [31:16]
  val c3 = RegInit(false.B) // carry after bits [47:32]
  val c4 = RegInit(false.B) // final carry after bits [63:48]

  // Partial sum registers per 16-bit chunk
  val s0 = Reg(UInt(16.W))
  val s1 = Reg(UInt(16.W))
  val s2 = Reg(UInt(16.W))
  val s3 = Reg(UInt(16.W))

  // ---- Stage 0: bits [15:0], carry-in = 0
  val add0 = Wire(UInt(17.W))
  add0 := a0(15, 0) +& b0(15, 0)

  when(io.i_en) {
    s0 := add0(15, 0)
    c1 := add0(16)
  }

  // ---- Stage 1: bits [31:16], carry-in = c1
  val add1 = Wire(UInt(17.W))
  add1 := a1(31, 16) +& b1(31, 16) + c1.asUInt

  when(en0) {
    s1 := add1(15, 0)
    c2 := add1(16)
  }

  // ---- Stage 2: bits [47:32], carry-in = c2
  val add2 = Wire(UInt(17.W))
  add2 := a2(47, 32) +& b2(47, 32) + c2.asUInt

  when(en1) {
    s2 := add2(15, 0)
    c3 := add2(16)
  }

  // ---- Stage 3: bits [63:48], carry-in = c3
  val add3 = Wire(UInt(17.W))
  add3 := a3(63, 48) +& b3(63, 48) + c3.asUInt

  when(en2) {
    s3 := add3(15, 0)
    c4 := add3(16)
  }

  // Output register (optional but keeps output stable when o_en is low)
  val resultReg = RegInit(0.U(65.W))
  when(en3) {
    resultReg := Cat(c4, s3, s2, s1, s0)
  }

  io.result := resultReg
}
