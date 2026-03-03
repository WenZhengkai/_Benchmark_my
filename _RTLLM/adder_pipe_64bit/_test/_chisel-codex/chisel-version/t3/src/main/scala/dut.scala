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

  // ----------------------------
  // Enable pipeline (4 stages)
  // ----------------------------
  val en1 = RegInit(false.B)
  val en2 = RegInit(false.B)
  val en3 = RegInit(false.B)
  val en4 = RegInit(false.B)

  en1 := io.i_en
  en2 := en1
  en3 := en2
  en4 := en3

  // ----------------------------
  // Operand delay lines so each stage gets the correct 16-bit slice
  // ----------------------------
  val a_d1 = Reg(UInt(64.W))
  val a_d2 = Reg(UInt(64.W))
  val a_d3 = Reg(UInt(64.W))
  val b_d1 = Reg(UInt(64.W))
  val b_d2 = Reg(UInt(64.W))
  val b_d3 = Reg(UInt(64.W))

  a_d1 := io.adda
  a_d2 := a_d1
  a_d3 := a_d2

  b_d1 := io.addb
  b_d2 := b_d1
  b_d3 := b_d2

  // ----------------------------
  // Stage registers: partial sums and carries
  // ----------------------------
  val sum0 = RegInit(0.U(16.W))
  val sum1 = RegInit(0.U(16.W))
  val sum2 = RegInit(0.U(16.W))
  val sum3 = RegInit(0.U(16.W))

  val c0 = RegInit(false.B)
  val c1 = RegInit(false.B)
  val c2 = RegInit(false.B)
  val c3 = RegInit(false.B)

  // Delay registers to align lower partial sums to output cycle
  val sum0_d1 = RegInit(0.U(16.W))
  val sum0_d2 = RegInit(0.U(16.W))
  val sum0_d3 = RegInit(0.U(16.W))

  val sum1_d1 = RegInit(0.U(16.W))
  val sum1_d2 = RegInit(0.U(16.W))

  val sum2_d1 = RegInit(0.U(16.W))

  // ----------------------------
  // Stage 0: bits [15:0]
  // ----------------------------
  when(io.i_en) {
    val t0 = io.adda(15, 0) +& io.addb(15, 0) // 17-bit
    sum0 := t0(15, 0)
    c0 := t0(16)
  }

  // ----------------------------
  // Stage 1: bits [31:16]
  // ----------------------------
  when(en1) {
    val t1 = a_d1(31, 16) +& b_d1(31, 16) +& c0.asUInt
    sum1 := t1(15, 0)
    c1 := t1(16)

    sum0_d1 := sum0
  }

  // ----------------------------
  // Stage 2: bits [47:32]
  // ----------------------------
  when(en2) {
    val t2 = a_d2(47, 32) +& b_d2(47, 32) +& c1.asUInt
    sum2 := t2(15, 0)
    c2 := t2(16)

    sum0_d2 := sum0_d1
    sum1_d1 := sum1
  }

  // ----------------------------
  // Stage 3: bits [63:48]
  // ----------------------------
  when(en3) {
    val t3 = a_d3(63, 48) +& b_d3(63, 48) +& c2.asUInt
    sum3 := t3(15, 0)
    c3 := t3(16)

    sum0_d3 := sum0_d2
    sum1_d2 := sum1_d1
    sum2_d1 := sum2
  }

  // ----------------------------
  // Outputs
  // ----------------------------
  io.result := Cat(c3, sum3, sum2_d1, sum1_d2, sum0_d3) // 1 + 16*4 = 65 bits
  io.o_en := en4
}
