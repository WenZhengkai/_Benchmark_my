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
  // Enable pipeline (4 stages)
  // -------------------------
  val en1 = RegInit(false.B)
  val en2 = RegInit(false.B)
  val en3 = RegInit(false.B)
  val en4 = RegInit(false.B)

  en1 := io.i_en
  en2 := en1
  en3 := en2
  en4 := en3

  // -------------------------
  // Stage 0: bits [15:0]
  // -------------------------
  val s0_sum  = RegInit(0.U(16.W))
  val s0_cout = RegInit(0.U(1.W))

  val s0_a1 = RegInit(0.U(16.W))
  val s0_b1 = RegInit(0.U(16.W))
  val s0_a2 = RegInit(0.U(16.W))
  val s0_b2 = RegInit(0.U(16.W))
  val s0_a3 = RegInit(0.U(16.W))
  val s0_b3 = RegInit(0.U(16.W))

  val add0 = io.adda(15, 0) +& io.addb(15, 0)
  s0_sum  := add0(15, 0)
  s0_cout := add0(16)

  s0_a1 := io.adda(31, 16)
  s0_b1 := io.addb(31, 16)
  s0_a2 := io.adda(47, 32)
  s0_b2 := io.addb(47, 32)
  s0_a3 := io.adda(63, 48)
  s0_b3 := io.addb(63, 48)

  // -------------------------
  // Stage 1: bits [31:16]
  // -------------------------
  val s1_sum  = RegInit(0.U(16.W))
  val s1_cout = RegInit(0.U(1.W))

  val s1_sum0 = RegInit(0.U(16.W))
  val s1_a2   = RegInit(0.U(16.W))
  val s1_b2   = RegInit(0.U(16.W))
  val s1_a3   = RegInit(0.U(16.W))
  val s1_b3   = RegInit(0.U(16.W))

  val add1 = Cat(0.U(1.W), s0_a1) +& Cat(0.U(1.W), s0_b1) + s0_cout
  s1_sum  := add1(15, 0)
  s1_cout := add1(16)

  s1_sum0 := s0_sum
  s1_a2   := s0_a2
  s1_b2   := s0_b2
  s1_a3   := s0_a3
  s1_b3   := s0_b3

  // -------------------------
  // Stage 2: bits [47:32]
  // -------------------------
  val s2_sum  = RegInit(0.U(16.W))
  val s2_cout = RegInit(0.U(1.W))

  val s2_sum0 = RegInit(0.U(16.W))
  val s2_sum1 = RegInit(0.U(16.W))
  val s2_a3   = RegInit(0.U(16.W))
  val s2_b3   = RegInit(0.U(16.W))

  val add2 = Cat(0.U(1.W), s1_a2) +& Cat(0.U(1.W), s1_b2) + s1_cout
  s2_sum  := add2(15, 0)
  s2_cout := add2(16)

  s2_sum0 := s1_sum0
  s2_sum1 := s1_sum
  s2_a3   := s1_a3
  s2_b3   := s1_b3

  // -------------------------
  // Stage 3: bits [63:48]
  // -------------------------
  val s3_sum  = RegInit(0.U(16.W))
  val s3_cout = RegInit(0.U(1.W))

  val s3_sum0 = RegInit(0.U(16.W))
  val s3_sum1 = RegInit(0.U(16.W))
  val s3_sum2 = RegInit(0.U(16.W))

  val add3 = Cat(0.U(1.W), s2_a3) +& Cat(0.U(1.W), s2_b3) + s2_cout
  s3_sum  := add3(15, 0)
  s3_cout := add3(16)

  s3_sum0 := s2_sum0
  s3_sum1 := s2_sum1
  s3_sum2 := s2_sum

  // -------------------------
  // Output register
  // -------------------------
  val resultReg = RegInit(0.U(65.W))
  resultReg := Cat(s3_cout, s3_sum, s3_sum2, s3_sum1, s3_sum0)

  io.result := resultReg
  io.o_en   := en4
}

// Optional elaboration entry point
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
