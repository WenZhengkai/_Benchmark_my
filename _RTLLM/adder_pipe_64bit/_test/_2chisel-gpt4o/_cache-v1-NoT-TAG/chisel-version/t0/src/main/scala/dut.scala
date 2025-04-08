import chisel3._
import chisel3.util._

/** RCA16: 16-bit ripple carry adder */
class RCA16 extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(16.W))
    val b = Input(UInt(16.W))
    val cin = Input(Bool())
    val sum = Output(UInt(16.W))
    val cout = Output(Bool())
  })

  val (sum, carry) = (0 until 16).foldLeft((VecInit(Seq.fill(16)(false.B)), io.cin)) {
    case ((sumVec, carryIn), i) =>
      val a_bit = io.a(i)
      val b_bit = io.b(i)
      val full_adder_sum = a_bit ^ b_bit ^ carryIn
      val carryOut = (a_bit && b_bit) || (b_bit && carryIn) || (a_bit && carryIn)
      sumVec(i) := full_adder_sum
      (sumVec, carryOut)
  }

  io.sum := sum.asUInt
  io.cout := carry
}

/** adder_pipe_64bit: Pipelined 64-bit ripple carry adder */
class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Pipeline enable signal
  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))
  en_pipeline(0) := io.i_en
  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i - 1)
  }

  // Registers to hold input operands
  val adda_reg = RegEnable(io.adda, 0.U(64.W), io.i_en)
  val addb_reg = RegEnable(io.addb, 0.U(64.W), io.i_en)

  // Pipeline stage 1
  val stage1_adda = adda_reg(15, 0)
  val stage1_addb = addb_reg(15, 0)
  val stage1_sum = RegInit(0.U(16.W))
  val stage1_carry = RegInit(false.B)
  val rca1 = Module(new RCA16)
  rca1.io.a := stage1_adda
  rca1.io.b := stage1_addb
  rca1.io.cin := false.B
  when(en_pipeline(0)) {
    stage1_sum := rca1.io.sum
    stage1_carry := rca1.io.cout
  }

  // Pipeline stage 2
  val stage2_adda = adda_reg(31, 16)
  val stage2_addb = addb_reg(31, 16)
  val stage2_sum = RegInit(0.U(16.W))
  val stage2_carry = RegInit(false.B)
  val rca2 = Module(new RCA16)
  rca2.io.a := stage2_adda
  rca2.io.b := stage2_addb
  rca2.io.cin := stage1_carry
  when(en_pipeline(1)) {
    stage2_sum := rca2.io.sum
    stage2_carry := rca2.io.cout
  }

  // Pipeline stage 3
  val stage3_adda = adda_reg(47, 32)
  val stage3_addb = addb_reg(47, 32)
  val stage3_sum = RegInit(0.U(16.W))
  val stage3_carry = RegInit(false.B)
  val rca3 = Module(new RCA16)
  rca3.io.a := stage3_adda
  rca3.io.b := stage3_addb
  rca3.io.cin := stage2_carry
  when(en_pipeline(2)) {
    stage3_sum := rca3.io.sum
    stage3_carry := rca3.io.cout
  }

  // Pipeline stage 4
  val stage4_adda = adda_reg(63, 48)
  val stage4_addb = addb_reg(63, 48)
  val stage4_sum = RegInit(0.U(16.W))
  val stage4_carry = RegInit(false.B)
  val rca4 = Module(new RCA16)
  rca4.io.a := stage4_adda
  rca4.io.b := stage4_addb
  rca4.io.cin := stage3_carry
  when(en_pipeline(3)) {
    stage4_sum := rca4.io.sum
    stage4_carry := rca4.io.cout
  }

  // Result aggregation
  val result_reg = RegInit(0.U(65.W))
  when(en_pipeline(3)) {
    result_reg := Cat(stage4_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum)
  }

  // Connect outputs
  io.result := result_reg
  io.o_en := en_pipeline(3)
}

/** Generate Verilog */
