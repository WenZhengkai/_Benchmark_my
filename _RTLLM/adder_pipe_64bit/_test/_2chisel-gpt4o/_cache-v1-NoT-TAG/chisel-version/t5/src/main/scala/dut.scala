import chisel3._
import chisel3.util._

class RCA16 extends Module {
  val io = IO(new Bundle {
    val a    = Input(UInt(16.W))
    val b    = Input(UInt(16.W))
    val cin  = Input(Bool())
    val sum  = Output(UInt(16.W))
    val cout = Output(Bool())
  })

  // 16-bit ripple carry adder using chained full adders
  val carry = Wire(Vec(17, Bool()))
  val sum   = Wire(Vec(16, Bool()))

  carry(0) := io.cin

  for (i <- 0 until 16) {
    val a_bit = io.a(i)
    val b_bit = io.b(i)
    val s_bit = a_bit ^ b_bit ^ carry(i)
    val c_bit = (a_bit & b_bit) | (a_bit & carry(i)) | (b_bit & carry(i))
    sum(i) := s_bit
    carry(i + 1) := c_bit
  }

  io.sum := sum.asUInt
  io.cout := carry(16)
}

class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())
    val adda   = Input(UInt(64.W))
    val addb   = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // Task 1: Input Registering and Enable Pipeline
  val adda_reg = RegEnable(io.adda, 0.U, io.i_en)
  val addb_reg = RegEnable(io.addb, 0.U, io.i_en)

  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))
  en_pipeline(0) := io.i_en
  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i - 1)
  }

  // Task 2: Instantiate RCA16 for each 16-bit slice
  val rca1 = Module(new RCA16)
  val rca2 = Module(new RCA16)
  val rca3 = Module(new RCA16)
  val rca4 = Module(new RCA16)

  // Task 3: Pipeline Stage Implementation
  val sum1_reg = Reg(UInt(16.W))
  val carry1_reg = Reg(Bool())

  val sum2_reg = Reg(UInt(16.W))
  val carry2_reg = Reg(Bool())

  val sum3_reg = Reg(UInt(16.W))
  val carry3_reg = Reg(Bool())

  val sum4_reg = Reg(UInt(16.W))
  val carry4_reg = Reg(Bool())

  // Stage 1: Lower 16 bits
  rca1.io.a := adda_reg(15, 0)
  rca1.io.b := addb_reg(15, 0)
  rca1.io.cin := 0.B
  sum1_reg := rca1.io.sum
  carry1_reg := rca1.io.cout

  // Stage 2: Bits 16 to 31
  rca2.io.a := adda_reg(31, 16)
  rca2.io.b := addb_reg(31, 16)
  rca2.io.cin := carry1_reg
  sum2_reg := rca2.io.sum
  carry2_reg := rca2.io.cout

  // Stage 3: Bits 32 to 47
  rca3.io.a := adda_reg(47, 32)
  rca3.io.b := addb_reg(47, 32)
  rca3.io.cin := carry2_reg
  sum3_reg := rca3.io.sum
  carry3_reg := rca3.io.cout

  // Stage 4: Bits 48 to 63
  rca4.io.a := adda_reg(63, 48)
  rca4.io.b := addb_reg(63, 48)
  rca4.io.cin := carry3_reg
  sum4_reg := rca4.io.sum
  carry4_reg := rca4.io.cout

  // Task 4: Result Aggregation Logic
  val result_reg = Reg(UInt(65.W))
  result_reg := Cat(carry4_reg, sum4_reg, sum3_reg, sum2_reg, sum1_reg)
  io.result := result_reg

  // Task 5: Output Enable Generation
  io.o_en := en_pipeline(3)
}
