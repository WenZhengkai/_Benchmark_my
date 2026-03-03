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
  // Pipeline enable synchronization (4 stages)
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
  // Register the operands through the pipeline
  // (keep alignment of operand segments with each stage)
  // -----------------------------
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

  when(en0) {
    a1 := a0; b1 := b0
  }
  when(en1) {
    a2 := a1; b2 := b1
  }
  when(en2) {
    a3 := a2; b3 := b2
  }

  // -----------------------------
  // Ripple carry adder split into 4x16-bit, pipelined
  // -----------------------------
  val sum16_s0 = Reg(UInt(16.W))
  val sum16_s1 = Reg(UInt(16.W))
  val sum16_s2 = Reg(UInt(16.W))
  val sum16_s3 = Reg(UInt(16.W))

  val c1 = RegInit(0.U(1.W)) // carry into stage1
  val c2 = RegInit(0.U(1.W)) // carry into stage2
  val c3 = RegInit(0.U(1.W)) // carry into stage3
  val c4 = RegInit(0.U(1.W)) // final carry out

  // Stage 0: bits [15:0]
  when(io.i_en) {
    val add0 = a0(15, 0) +& b0(15, 0) // 17-bit
    sum16_s0 := add0(15, 0)
    c1       := add0(16)
  }

  // Stage 1: bits [31:16]
  when(en0) {
    val add1 = a1(31, 16) +& b1(31, 16) + c1 // 17-bit
    sum16_s1 := add1(15, 0)
    c2       := add1(16)
  }

  // Stage 2: bits [47:32]
  when(en1) {
    val add2 = a2(47, 32) +& b2(47, 32) + c2 // 17-bit
    sum16_s2 := add2(15, 0)
    c3       := add2(16)
  }

  // Stage 3: bits [63:48]
  when(en2) {
    val add3 = a3(63, 48) +& b3(63, 48) + c3 // 17-bit
    sum16_s3 := add3(15, 0)
    c4       := add3(16)
  }

  // -----------------------------
  // Output assembly (registered by construction of stage regs)
  // -----------------------------
  io.result := Cat(c4, sum16_s3, sum16_s2, sum16_s1, sum16_s0)
}
