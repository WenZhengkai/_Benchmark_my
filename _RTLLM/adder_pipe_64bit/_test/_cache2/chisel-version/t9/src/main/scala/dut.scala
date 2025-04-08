import chisel3._
import chisel3.util._

class RCA16 extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(16.W))
    val b = Input(UInt(16.W))
    val cin = Input(UInt(1.W))
    val sum = Output(UInt(16.W))
    val cout = Output(UInt(1.W))
  })

  // Create a 16-bit ripple carry adder using full adders
  val fullAdders = VecInit(Seq.fill(16)(Module(new FullAdder).io))
  val carries = Wire(Vec(17, Bool()))
  carries(0) := io.cin

  for (i <- 0 until 16) {
    fullAdders(i).a := io.a(i)
    fullAdders(i).b := io.b(i)
    fullAdders(i).cin := carries(i)
    carries(i + 1) := fullAdders(i).cout
    io.sum(i) := fullAdders(i).sum
  }

  io.cout := carries(16)
}

class FullAdder extends Module {
  val io = IO(new Bundle {
    val a = Input(Bool())
    val b = Input(Bool())
    val cin = Input(Bool())
    val sum = Output(Bool())
    val cout = Output(Bool())
  })

  io.sum := io.a ^ io.b ^ io.cin
  io.cout := (io.a & io.b) | (io.b & io.cin) | (io.a & io.cin)
}

class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Task 1: Input Registering and Enable Pipeline
  val adda_reg = RegEnable(io.adda, 0.U, io.i_en)
  val addb_reg = RegEnable(io.addb, 0.U, io.i_en)

  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))
  en_pipeline(0) := io.i_en
  for (i <- 1 until en_pipeline.length) {
    en_pipeline(i) := en_pipeline(i - 1)
  }

  // Task 2: Instantiate RCAs for Pipeline Stages
  val rca1 = Module(new RCA16)
  rca1.io.a := adda_reg(15, 0)
  rca1.io.b := addb_reg(15, 0)
  rca1.io.cin := 0.U

  val rca2 = Module(new RCA16)
  rca2.io.a := adda_reg(31, 16)
  rca2.io.b := addb_reg(31, 16)

  val rca3 = Module(new RCA16)
  rca3.io.a := adda_reg(47, 32)
  rca3.io.b := addb_reg(47, 32)

  val rca4 = Module(new RCA16)
  rca4.io.a := adda_reg(63, 48)
  rca4.io.b := addb_reg(63, 48)

  // Task 3: Pipeline Stage Implementation
  // First stage output registered carry and sum
  val stage1_sum = RegNext(rca1.io.sum)
  val stage1_carry = RegNext(rca1.io.cout)

  // Connect cin for next stage and register outputs
  rca2.io.cin := stage1_carry
  val stage2_sum = RegNext(rca2.io.sum)
  val stage2_carry = RegNext(rca2.io.cout)

  rca3.io.cin := stage2_carry
  val stage3_sum = RegNext(rca3.io.sum)
  val stage3_carry = RegNext(rca3.io.cout)

  rca4.io.cin := stage3_carry
  val stage4_sum = RegNext(rca4.io.sum)
  val final_carry = RegNext(rca4.io.cout)
  
  // Task 4: Result Aggregation Logic
  val result_reg = Reg(UInt(65.W))
  result_reg := Cat(final_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum)

  // Task 5: Output Enable Generation
  io.result := result_reg
  io.o_en := en_pipeline(3)
}
