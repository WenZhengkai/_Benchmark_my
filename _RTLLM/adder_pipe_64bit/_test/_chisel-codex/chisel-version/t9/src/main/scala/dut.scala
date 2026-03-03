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

  // -------------------------
  // Stage valid pipeline
  // -------------------------
  val en0 = RegInit(false.B)
  val en1 = RegInit(false.B)
  val en2 = RegInit(false.B)
  val en3 = RegInit(false.B)

  en0 := io.i_en
  en1 := en0
  en2 := en1
  en3 := en2

  // -------------------------
  // Stage 0: [15:0]
  // -------------------------
  val s0 = RegInit(0.U(16.W))
  val c0 = RegInit(0.U(1.W))

  val a1_0 = RegInit(0.U(16.W))
  val b1_0 = RegInit(0.U(16.W))
  val a2_0 = RegInit(0.U(16.W))
  val b2_0 = RegInit(0.U(16.W))
  val a3_0 = RegInit(0.U(16.W))
  val b3_0 = RegInit(0.U(16.W))

  when(io.i_en) {
    val add0 = io.adda(15, 0) +& io.addb(15, 0)
    s0 := add0(15, 0)
    c0 := add0(16)

    a1_0 := io.adda(31, 16)
    b1_0 := io.addb(31, 16)
    a2_0 := io.adda(47, 32)
    b2_0 := io.addb(47, 32)
    a3_0 := io.adda(63, 48)
    b3_0 := io.addb(63, 48)
  }

  // -------------------------
  // Stage 1: [31:16]
  // -------------------------
  val s1 = RegInit(0.U(16.W))
  val c1 = RegInit(0.U(1.W))

  val a2_1 = RegInit(0.U(16.W))
  val b2_1 = RegInit(0.U(16.W))
  val a3_1 = RegInit(0.U(16.W))
  val b3_1 = RegInit(0.U(16.W))

  val s0_d1 = RegInit(0.U(16.W))

  when(en0) {
    val add1 = a1_0 +& b1_0 + c0
    s1 := add1(15, 0)
    c1 := add1(16)

    a2_1 := a2_0
    b2_1 := b2_0
    a3_1 := a3_0
    b3_1 := b3_0

    s0_d1 := s0
  }

  // -------------------------
  // Stage 2: [47:32]
  // -------------------------
  val s2 = RegInit(0.U(16.W))
  val c2 = RegInit(0.U(1.W))

  val a3_2 = RegInit(0.U(16.W))
  val b3_2 = RegInit(0.U(16.W))

  val s0_d2 = RegInit(0.U(16.W))
  val s1_d1 = RegInit(0.U(16.W))

  when(en1) {
    val add2 = a2_1 +& b2_1 + c1
    s2 := add2(15, 0)
    c2 := add2(16)

    a3_2 := a3_1
    b3_2 := b3_1

    s0_d2 := s0_d1
    s1_d1 := s1
  }

  // -------------------------
  // Stage 3: [63:48]
  // -------------------------
  val s3 = RegInit(0.U(16.W))
  val c3 = RegInit(0.U(1.W))

  val s0_d3 = RegInit(0.U(16.W))
  val s1_d2 = RegInit(0.U(16.W))
  val s2_d1 = RegInit(0.U(16.W))

  when(en2) {
    val add3 = a3_2 +& b3_2 + c2
    s3 := add3(15, 0)
    c3 := add3(16)

    s0_d3 := s0_d2
    s1_d2 := s1_d1
    s2_d1 := s2
  }

  // -------------------------
  // Output register stage
  // -------------------------
  val resultReg = RegInit(0.U(65.W))
  val oEnReg    = RegInit(false.B)

  oEnReg := en3
  when(en3) {
    resultReg := Cat(c3, s3, s2_d1, s1_d2, s0_d3)
  }

  io.result := resultReg
  io.o_en   := oEnReg
}
