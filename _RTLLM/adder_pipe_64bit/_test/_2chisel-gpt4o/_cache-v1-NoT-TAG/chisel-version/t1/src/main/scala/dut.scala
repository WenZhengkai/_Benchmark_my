import chisel3._
import chisel3.util._

/** 16-bit Ripple Carry Adder (RCA16) Module */
class RCA16 extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(16.W))      // 16-bit operand A
    val b = Input(UInt(16.W))      // 16-bit operand B
    val cin = Input(UInt(1.W))     // Carry-in
    val sum = Output(UInt(16.W))   // 16-bit sum output
    val cout = Output(UInt(1.W))   // Carry-out
  })

  // Full-adder chaining for 16 bits
  val (sum, carry) = (0 until 16).foldLeft((Wire(Vec(16, Bool())), Wire(UInt(1.W)))) { (prev, i) =>
    val s = Wire(Bool())
    val c = Wire(UInt(1.W))
    val a_bit = io.a(i)
    val b_bit = io.b(i)
    val carry_in = if (i == 0) io.cin else prev._2
    s := a_bit ^ b_bit ^ carry_in    // Sum bit
    c := (a_bit & b_bit) | (carry_in & (a_bit ^ b_bit)) // Carry logic
    prev._1(i) := s
    (prev._1, c)
  }

  io.sum := sum.asUInt
  io.cout := carry
}

/** 64-bit Pipelined Ripple Carry Adder (dut) Module */
class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())          // Enable signal for addition operation
    val adda = Input(UInt(64.W))      // 64-bit input operand A
    val addb = Input(UInt(64.W))      // 64-bit input operand B
    val result = Output(UInt(65.W))   // 65-bit result (sum)
    val o_en = Output(Bool())         // Output enable (valid signal)
  })

  // Task 1: Input Registering and Enable Pipeline
  val adda_reg = RegEnable(io.adda, 0.U, io.i_en) // Register for adda
  val addb_reg = RegEnable(io.addb, 0.U, io.i_en) // Register for addb

  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B))) // 4-stage enable pipeline
  en_pipeline(0) := io.i_en
  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i - 1)
  }

  // Task 2: Instantiate 16-bit RCA logic
  val rca1 = Module(new RCA16)
  val rca2 = Module(new RCA16)
  val rca3 = Module(new RCA16)
  val rca4 = Module(new RCA16)

  // Task 3: Pipeline Stages and 16-bit slicing
  // Stage 1
  val stage1_sum = RegInit(0.U(16.W))
  val stage1_carry = RegInit(0.U(1.W))
  when(en_pipeline(0)) {
    rca1.io.a := adda_reg(15, 0)
    rca1.io.b := addb_reg(15, 0)
    rca1.io.cin := 0.U
    stage1_sum := rca1.io.sum
    stage1_carry := rca1.io.cout
  }

  // Stage 2
  val stage2_sum = RegInit(0.U(16.W))
  val stage2_carry = RegInit(0.U(1.W))
  when(en_pipeline(1)) {
    rca2.io.a := adda_reg(31, 16)
    rca2.io.b := addb_reg(31, 16)
    rca2.io.cin := stage1_carry
    stage2_sum := rca2.io.sum
    stage2_carry := rca2.io.cout
  }

  // Stage 3
  val stage3_sum = RegInit(0.U(16.W))
  val stage3_carry = RegInit(0.U(1.W))
  when(en_pipeline(2)) {
    rca3.io.a := adda_reg(47, 32)
    rca3.io.b := addb_reg(47, 32)
    rca3.io.cin := stage2_carry
    stage3_sum := rca3.io.sum
    stage3_carry := rca3.io.cout
  }

  // Stage 4
  val stage4_sum = RegInit(0.U(16.W))
  val stage4_carry = RegInit(0.U(1.W))
  when(en_pipeline(3)) {
    rca4.io.a := adda_reg(63, 48)
    rca4.io.b := addb_reg(63, 48)
    rca4.io.cin := stage3_carry
    stage4_sum := rca4.io.sum
    stage4_carry := rca4.io.cout
  }

  // Task 4: Result Aggregation Logic
  val result_reg = RegInit(0.U(65.W))
  when(en_pipeline(3)) {
    result_reg := Cat(stage4_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum)
  }
  io.result := result_reg

  // Task 5: Output Enable Generation
  io.o_en := en_pipeline(3) // Output enable is valid at the final stage
}


