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

  val fullAdders = Array.fill(16)(Module(new FullAdder).io)

  val carry = Wire(Vec(16, Bool()))
  carry(0) := io.cin

  for (i <- 0 until 16) {
    fullAdders(i).a := io.a(i)
    fullAdders(i).b := io.b(i)
    fullAdders(i).cin := carry(i)
    carry(i + 1) := fullAdders(i).cout
  }

  io.sum := Cat(fullAdders.map(_.sum).reverse)
  io.cout := carry(15)
}

class FullAdder extends Module {
  val io = IO(new Bundle {
    val a    = Input(Bool())
    val b    = Input(Bool())
    val cin  = Input(Bool())
    val sum  = Output(Bool())
    val cout = Output(Bool())
  })

  io.sum := io.a ^ io.b ^ io.cin
  io.cout := (io.a & io.b) | (io.a & io.cin) | (io.b & io.cin)
}

class dut extends Module {
  val io = IO(new Bundle {
    val i_en  = Input(Bool())
    val adda  = Input(UInt(64.W))
    val addb  = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // Task 1: Registers for Input and Enable Pipeline
  val adda_reg = RegEnable(io.adda, 0.U(64.W), io.i_en)
  val addb_reg = RegEnable(io.addb, 0.U(64.W), io.i_en)

  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))
  when(io.i_en) {
    en_pipeline(0) := io.i_en
  }

  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i - 1)
  }

  // Task 2: RCA16 Design
  // Already implemented above.

  // Task 3: Pipeline Stages
  // Stage 1
  val rca1 = Module(new RCA16)
  rca1.io.a := adda_reg(15, 0)
  rca1.io.b := addb_reg(15, 0)
  rca1.io.cin := false.B
  val stage1_sum = RegEnable(rca1.io.sum, 0.U(16.W), en_pipeline(0))
  val stage1_carry = RegEnable(rca1.io.cout, false.B, en_pipeline(0))

  // Stage 2
  val rca2 = Module(new RCA16)
  rca2.io.a := adda_reg(31, 16)
  rca2.io.b := addb_reg(31, 16)
  rca2.io.cin := stage1_carry
  val stage2_sum = RegEnable(rca2.io.sum, 0.U(16.W), en_pipeline(1))
  val stage2_carry = RegEnable(rca2.io.cout, false.B, en_pipeline(1))

  // Stage 3
  val rca3 = Module(new RCA16)
  rca3.io.a := adda_reg(47, 32)
  rca3.io.b := addb_reg(47, 32)
  rca3.io.cin := stage2_carry
  val stage3_sum = RegEnable(rca3.io.sum, 0.U(16.W), en_pipeline(2))
  val stage3_carry = RegEnable(rca3.io.cout, false.B, en_pipeline(2))

  // Stage 4
  val rca4 = Module(new RCA16)
  rca4.io.a := adda_reg(63, 48)
  rca4.io.b := addb_reg(63, 48)
  rca4.io.cin := stage3_carry
  val stage4_sum = RegEnable(rca4.io.sum, 0.U(16.W), en_pipeline(3))
  val final_carry = RegEnable(rca4.io.cout, false.B, en_pipeline(3))

  // Task 4: Result Aggregation Logic
  val result_reg = RegEnable(Cat(final_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum), 0.U(65.W), en_pipeline(3))

  // Task 5: Output Enable Generation
  io.result := result_reg
  io.o_en := en_pipeline(3)
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
