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

  // ---------------------------
  // Valid pipeline (4 stages)
  // ---------------------------
  val v0 = RegInit(false.B)
  val v1 = RegInit(false.B)
  val v2 = RegInit(false.B)
  val v3 = RegInit(false.B)

  v0 := io.i_en
  v1 := v0
  v2 := v1
  v3 := v2

  // ---------------------------
  // Stage 0 registers
  // ---------------------------
  val s0Sum0  = RegInit(0.U(16.W))
  val s0Carry = RegInit(false.B)
  val s0A1    = RegInit(0.U(16.W))
  val s0B1    = RegInit(0.U(16.W))
  val s0A2    = RegInit(0.U(16.W))
  val s0B2    = RegInit(0.U(16.W))
  val s0A3    = RegInit(0.U(16.W))
  val s0B3    = RegInit(0.U(16.W))

  // ---------------------------
  // Stage 1 registers
  // ---------------------------
  val s1Sum0  = RegInit(0.U(16.W))
  val s1Sum1  = RegInit(0.U(16.W))
  val s1Carry = RegInit(false.B)
  val s1A2    = RegInit(0.U(16.W))
  val s1B2    = RegInit(0.U(16.W))
  val s1A3    = RegInit(0.U(16.W))
  val s1B3    = RegInit(0.U(16.W))

  // ---------------------------
  // Stage 2 registers
  // ---------------------------
  val s2Sum0  = RegInit(0.U(16.W))
  val s2Sum1  = RegInit(0.U(16.W))
  val s2Sum2  = RegInit(0.U(16.W))
  val s2Carry = RegInit(false.B)
  val s2A3    = RegInit(0.U(16.W))
  val s2B3    = RegInit(0.U(16.W))

  // ---------------------------
  // Output register
  // ---------------------------
  val resultReg = RegInit(0.U(65.W))

  // Stage 0: bits [15:0]
  when(io.i_en) {
    val t0 = io.adda(15, 0) +& io.addb(15, 0)
    s0Sum0  := t0(15, 0)
    s0Carry := t0(16)

    s0A1 := io.adda(31, 16)
    s0B1 := io.addb(31, 16)
    s0A2 := io.adda(47, 32)
    s0B2 := io.addb(47, 32)
    s0A3 := io.adda(63, 48)
    s0B3 := io.addb(63, 48)
  }.otherwise {
    s0Sum0  := 0.U
    s0Carry := false.B
    s0A1    := 0.U
    s0B1    := 0.U
    s0A2    := 0.U
    s0B2    := 0.U
    s0A3    := 0.U
    s0B3    := 0.U
  }

  // Stage 1: bits [31:16]
  when(v0) {
    val t1 = s0A1 +& s0B1 +& s0Carry.asUInt
    s1Sum0  := s0Sum0
    s1Sum1  := t1(15, 0)
    s1Carry := t1(16)

    s1A2 := s0A2
    s1B2 := s0B2
    s1A3 := s0A3
    s1B3 := s0B3
  }.otherwise {
    s1Sum0  := 0.U
    s1Sum1  := 0.U
    s1Carry := false.B
    s1A2    := 0.U
    s1B2    := 0.U
    s1A3    := 0.U
    s1B3    := 0.U
  }

  // Stage 2: bits [47:32]
  when(v1) {
    val t2 = s1A2 +& s1B2 +& s1Carry.asUInt
    s2Sum0  := s1Sum0
    s2Sum1  := s1Sum1
    s2Sum2  := t2(15, 0)
    s2Carry := t2(16)

    s2A3 := s1A3
    s2B3 := s1B3
  }.otherwise {
    s2Sum0  := 0.U
    s2Sum1  := 0.U
    s2Sum2  := 0.U
    s2Carry := false.B
    s2A3    := 0.U
    s2B3    := 0.U
  }

  // Stage 3: bits [63:48] and final 65-bit result
  when(v2) {
    val t3 = s2A3 +& s2B3 +& s2Carry.asUInt
    resultReg := Cat(t3(16), t3(15, 0), s2Sum2, s2Sum1, s2Sum0)
  }.otherwise {
    resultReg := 0.U
  }

  io.result := resultReg
  io.o_en   := v3
}
