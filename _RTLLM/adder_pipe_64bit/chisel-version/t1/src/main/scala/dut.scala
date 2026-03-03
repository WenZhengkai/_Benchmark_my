import chisel3._

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
  val en1 = RegInit(false.B)
  val en2 = RegInit(false.B)
  val en3 = RegInit(false.B)
  val en4 = RegInit(false.B)

  en1 := io.i_en
  en2 := en1
  en3 := en2
  en4 := en3

  io.o_en := en4

  // -----------------------------
  // Delay operand slices to align with carry pipeline
  // -----------------------------
  val a1_d1 = RegInit(0.U(16.W))
  val b1_d1 = RegInit(0.U(16.W))

  val a2_d1 = RegInit(0.U(16.W))
  val b2_d1 = RegInit(0.U(16.W))
  val a2_d2 = RegInit(0.U(16.W))
  val b2_d2 = RegInit(0.U(16.W))

  val a3_d1 = RegInit(0.U(16.W))
  val b3_d1 = RegInit(0.U(16.W))
  val a3_d2 = RegInit(0.U(16.W))
  val b3_d2 = RegInit(0.U(16.W))
  val a3_d3 = RegInit(0.U(16.W))
  val b3_d3 = RegInit(0.U(16.W))

  a1_d1 := io.adda(31, 16)
  b1_d1 := io.addb(31, 16)

  a2_d1 := io.adda(47, 32)
  b2_d1 := io.addb(47, 32)
  a2_d2 := a2_d1
  b2_d2 := b2_d1

  a3_d1 := io.adda(63, 48)
  b3_d1 := io.addb(63, 48)
  a3_d2 := a3_d1
  b3_d2 := b3_d1
  a3_d3 := a3_d2
  b3_d3 := b3_d2

  // -----------------------------
  // Stage 0: bits [15:0]
  // -----------------------------
  val s0_sum_r   = RegInit(0.U(16.W))
  val c0_r       = RegInit(false.B)
  val s0_add     = io.adda(15, 0) +& io.addb(15, 0) // 17 bits

  s0_sum_r := s0_add(15, 0)
  c0_r     := s0_add(16)

  // -----------------------------
  // Stage 1: bits [31:16]
  // -----------------------------
  val s1_sum_r   = RegInit(0.U(16.W))
  val c1_r       = RegInit(false.B)
  val s1_add     = (a1_d1 +& b1_d1) + c0_r.asUInt   // width may be >17; carry at bit 16 is valid

  s1_sum_r := s1_add(15, 0)
  c1_r     := s1_add(16)

  // -----------------------------
  // Stage 2: bits [47:32]
  // -----------------------------
  val s2_sum_r   = RegInit(0.U(16.W))
  val c2_r       = RegInit(false.B)
  val s2_add     = (a2_d2 +& b2_d2) + c1_r.asUInt

  s2_sum_r := s2_add(15, 0)
  c2_r     := s2_add(16)

  // -----------------------------
  // Stage 3: bits [63:48]
  // -----------------------------
  val s3_sum_r   = RegInit(0.U(16.W))
  val c3_r       = RegInit(false.B)
  val s3_add     = (a3_d3 +& b3_d3) + c2_r.asUInt

  s3_sum_r := s3_add(15, 0)
  c3_r     := s3_add(16)

  // -----------------------------
  // Align partial sums for final assembly
  // -----------------------------
  val s0_d1 = RegInit(0.U(16.W))
  val s0_d2 = RegInit(0.U(16.W))
  val s0_d3 = RegInit(0.U(16.W))

  val s1_d1 = RegInit(0.U(16.W))
  val s1_d2 = RegInit(0.U(16.W))

  val s2_d1 = RegInit(0.U(16.W))

  s0_d1 := s0_sum_r
  s0_d2 := s0_d1
  s0_d3 := s0_d2

  s1_d1 := s1_sum_r
  s1_d2 := s1_d1

  s2_d1 := s2_sum_r

  // -----------------------------
  // Output register
  // -----------------------------
  val result_r = RegInit(0.U(65.W))
  when(en4) {
    result_r := Cat(c3_r.asUInt, s3_sum_r, s2_d1, s1_d2, s0_d3)
  }

  io.result := result_r
}
