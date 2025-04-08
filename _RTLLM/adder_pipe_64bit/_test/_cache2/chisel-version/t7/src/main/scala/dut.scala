import chisel3._
import chisel3.util._

// 16-bit Ripple Carry Adder (RCA16) Module
class RCA16 extends Module {
  val io = IO(new Bundle {
    val a    = Input(UInt(16.W))
    val b    = Input(UInt(16.W))
    val cin  = Input(UInt(1.W))
    val sum  = Output(UInt(16.W))
    val cout = Output(UInt(1.W))
  })

  // Ripple carry logic
  val (sum, cout) = (0 until 16).foldLeft((Wire(Vec(16, Bool())), io.cin)) { case ((sums, carry), i) =>
    val fa_sum = Wire(Bool())
    val fa_cout = Wire(Bool())
    val a_bit = io.a(i)
    val b_bit = io.b(i)
    fa_sum := a_bit ^ b_bit ^ carry
    fa_cout := (a_bit & b_bit) | (a_bit & carry) | (b_bit & carry)
    
    sums(i) := fa_sum
    (sums, fa_cout)
  }
  
  io.sum := sum.asUInt()
  io.cout := cout
}

// dut Module
class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())
    val adda   = Input(UInt(64.W))
    val addb   = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // Task 1: Input Registering and Enable Pipeline
  val adda_reg = RegEnable(io.adda, 0.U(64.W), io.i_en)
  val addb_reg = RegEnable(io.addb, 0.U(64.W), io.i_en)

  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))
  en_pipeline(0) := io.i_en
  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i - 1)
  }
  io.o_en := en_pipeline(3)

  // Task 2 & 3: 16-bit Ripple Carry Adder and Pipeline
  val stage1_sum = Reg(UInt(16.W))
  val stage2_sum = Reg(UInt(16.W))
  val stage3_sum = Reg(UInt(16.W))
  val stage4_sum = Reg(UInt(16.W))

  val stage1_carry = Reg(UInt(1.W))
  val stage2_carry = Reg(UInt(1.W))
  val stage3_carry = Reg(UInt(1.W))
  val stage4_carry = Wire(UInt(1.W))  // Final carry-out

  // Stage 1
  val rca1 = Module(new RCA16())
  rca1.io.a := adda_reg(15, 0)
  rca1.io.b := addb_reg(15, 0)
  rca1.io.cin := 0.U
  stage1_sum := rca1.io.sum
  stage1_carry := rca1.io.cout

  // Stage 2
  val rca2 = Module(new RCA16())
  rca2.io.a := adda_reg(31, 16)
  rca2.io.b := addb_reg(31, 16)
  rca2.io.cin := stage1_carry
  stage2_sum := rca2.io.sum
  stage2_carry := rca2.io.cout

  // Stage 3
  val rca3 = Module(new RCA16())
  rca3.io.a := adda_reg(47, 32)
  rca3.io.b := addb_reg(47, 32)
  rca3.io.cin := stage2_carry
  stage3_sum := rca3.io.sum
  stage3_carry := rca3.io.cout

  // Stage 4
  val rca4 = Module(new RCA16())
  rca4.io.a := adda_reg(63, 48)
  rca4.io.b := addb_reg(63, 48)
  rca4.io.cin := stage3_carry
  stage4_sum := rca4.io.sum
  stage4_carry := rca4.io.cout

  // Task 4: Result Aggregation Logic
  val result_reg = Reg(UInt(65.W))
  result_reg := Cat(stage4_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum)
  io.result := result_reg
}
