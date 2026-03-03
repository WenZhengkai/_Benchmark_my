import chisel3._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())
    val adda   = Input(UInt(64.W))
    val addb   = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // Enable pipeline (4 stages)
  val en0 = RegInit(false.B)
  val en1 = RegInit(false.B)
  val en2 = RegInit(false.B)
  val en3 = RegInit(false.B)

  en0 := io.i_en
  en1 := en0
  en2 := en1
  en3 := en2

  // Operand pipeline registers for upper chunks
  val a_p0 = RegInit(0.U(64.W))
  val b_p0 = RegInit(0.U(64.W))
  val a_p1 = RegInit(0.U(64.W))
  val b_p1 = RegInit(0.U(64.W))
  val a_p2 = RegInit(0.U(64.W))
  val b_p2 = RegInit(0.U(64.W))

  when(io.i_en) {
    a_p0 := io.adda
    b_p0 := io.addb
  }
  when(en0) {
    a_p1 := a_p0
    b_p1 := b_p0
  }
  when(en1) {
    a_p2 := a_p1
    b_p2 := b_p1
  }

  // Stage results and carries
  val sum0_r = RegInit(0.U(16.W))
  val sum1_r = RegInit(0.U(16.W))
  val sum2_r = RegInit(0.U(16.W))
  val sum3_r = RegInit(0.U(16.W))

  val c1_r = RegInit(0.U(1.W))
  val c2_r = RegInit(0.U(1.W))
  val c3_r = RegInit(0.U(1.W))
  val c4_r = RegInit(0.U(1.W))

  // Delay lower partial sums so all chunks align at output
  val sum0_p1 = RegInit(0.U(16.W))
  val sum0_p2 = RegInit(0.U(16.W))
  val sum0_p3 = RegInit(0.U(16.W))
  val sum1_p2 = RegInit(0.U(16.W))
  val sum1_p3 = RegInit(0.U(16.W))
  val sum2_p3 = RegInit(0.U(16.W))

  // Stage 0: bits [15:0]
  when(io.i_en) {
    val s0 = io.adda(15, 0) +& io.addb(15, 0) // 17-bit
    sum0_r := s0(15, 0)
    c1_r   := s0(16)
  }

  // Stage 1: bits [31:16]
  when(en0) {
    val s1 = a_p0(31, 16) +& b_p0(31, 16) + c1_r // 17-bit
    sum1_r := s1(15, 0)
    c2_r   := s1(16)

    sum0_p1 := sum0_r
  }

  // Stage 2: bits [47:32]
  when(en1) {
    val s2 = a_p1(47, 32) +& b_p1(47, 32) + c2_r // 17-bit
    sum2_r := s2(15, 0)
    c3_r   := s2(16)

    sum0_p2 := sum0_p1
    sum1_p2 := sum1_r
  }

  // Stage 3: bits [63:48]
  when(en2) {
    val s3 = a_p2(63, 48) +& b_p2(63, 48) + c3_r // 17-bit
    sum3_r := s3(15, 0)
    c4_r   := s3(16)

    sum0_p3 := sum0_p2
    sum1_p3 := sum1_p2
    sum2_p3 := sum2_r
  }

  io.result := Cat(c4_r, sum3_r, sum2_p3, sum1_p3, sum0_p3)
  io.o_en   := en3
}
