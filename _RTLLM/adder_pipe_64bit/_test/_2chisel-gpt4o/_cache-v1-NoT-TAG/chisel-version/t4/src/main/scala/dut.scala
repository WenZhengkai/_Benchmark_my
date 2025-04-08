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

  // Full-adder chaining for 16-bit Ripple Carry Adder
  val carries = Wire(Vec(16, Bool()))
  val sums    = Wire(Vec(16, Bool()))

  for (i <- 0 until 16) {
    val a_bit = io.a(i)
    val b_bit = io.b(i)
    val carry_in = if (i == 0) io.cin else carries(i - 1)

    sums(i) := a_bit ^ b_bit ^ carry_in
    carries(i) := (a_bit & b_bit) | (carry_in & (a_bit ^ b_bit))
  }

  io.sum := sums.asUInt
  io.cout := carries(15)
}

class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())
    val adda   = Input(UInt(64.W))
    val addb   = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // ------------------------------------------
  // Task 1: Input Registering and Enable Pipeline
  // ------------------------------------------

  // Registers to store inputs and pipeline the enable signal
  val adda_reg = RegEnable(io.adda, 0.U(64.W), io.i_en)
  val addb_reg = RegEnable(io.addb, 0.U(64.W), io.i_en)

  // 4-stage pipeline to track enable signal
  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))
  en_pipeline(0) := io.i_en
  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i - 1)
  }
  io.o_en := en_pipeline(3)

  // ------------------------------------------
  // Task 2: 16-bit Ripple Carry Adder (RCA16)
  // ------------------------------------------

  // Instantiate RCA16 modules for use in pipeline
  val rca1 = Module(new RCA16)
  val rca2 = Module(new RCA16)
  val rca3 = Module(new RCA16)
  val rca4 = Module(new RCA16)

  // ------------------------------------------
  // Task 3: Pipeline Stage Implementation
  // ------------------------------------------

  // Stage 1: Compute the least significant 16 bits
  rca1.io.a := adda_reg(15, 0)
  rca1.io.b := addb_reg(15, 0)
  rca1.io.cin := false.B
  val sum1 = RegNext(rca1.io.sum)
  val carry1 = RegNext(rca1.io.cout)

  // Stage 2: Compute the next 16 bits
  rca2.io.a := adda_reg(31, 16)
  rca2.io.b := addb_reg(31, 16)
  rca2.io.cin := carry1
  val sum2 = RegNext(rca2.io.sum)
  val carry2 = RegNext(rca2.io.cout)

  // Stage 3: Compute the next 16 bits
  rca3.io.a := adda_reg(47, 32)
  rca3.io.b := addb_reg(47, 32)
  rca3.io.cin := carry2
  val sum3 = RegNext(rca3.io.sum)
  val carry3 = RegNext(rca3.io.cout)

  // Stage 4: Compute the most significant 16 bits
  rca4.io.a := adda_reg(63, 48)
  rca4.io.b := addb_reg(63, 48)
  rca4.io.cin := carry3
  val sum4 = RegNext(rca4.io.sum)
  val carry4 = RegNext(rca4.io.cout)

  // ------------------------------------------
  // Task 4: Result Aggregation Logic
  // ------------------------------------------

  val result_reg = RegNext(Cat(carry4, sum4, sum3, sum2, sum1))
  io.result := result_reg

  // ------------------------------------------
  // Task 5: Output Enable Generation
  // ------------------------------------------

  // Output enable is driven by the last stage of the enable pipeline
  io.o_en := en_pipeline(3)
}

// Generate Verilog for the dut module

