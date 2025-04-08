import chisel3._
import chisel3.util._

// Ripple Carry Adder Module
class RCA16 extends Module {
  val io = IO(new Bundle {
    val a    = Input(UInt(16.W))
    val b    = Input(UInt(16.W))
    val cin  = Input(UInt(1.W))
    val sum  = Output(UInt(16.W))
    val cout = Output(UInt(1.W))
  })

  // Initialize the sum and carry Vec
  val sum = Wire(Vec(16, Bool()))
  val carry = Wire(Vec(17, Bool()))
  carry(0) := io.cin

  // Implement the full adders
  for (i <- 0 until 16) {
    val aBit = io.a(i)
    val bBit = io.b(i)
    sum(i) := aBit ^ bBit ^ carry(i)
    carry(i + 1) := (aBit & bBit) | (aBit & carry(i)) | (bBit & carry(i))
  }

  // Connect the outputs
  io.sum := sum.asUInt
  io.cout := carry(16)
}

// Top-level AdderPipeline64bit module
class dut extends Module {
  val io = IO(new Bundle {
    val i_en  = Input(Bool())
    val adda  = Input(UInt(64.W))
    val addb  = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en  = Output(Bool())
  })

  // Task 1: Input Registering and Enable Pipeline
  val adda_reg = RegEnable(io.adda, 0.U(64.W), io.i_en)
  val addb_reg = RegEnable(io.addb, 0.U(64.W), io.i_en)
  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))
  en_pipeline(0) := io.i_en
  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i-1)
  }

  // Task 3: Pipeline Stage Implementation
  val stage1_sum = Reg(UInt(16.W))
  val stage2_sum = Reg(UInt(16.W))
  val stage3_sum = Reg(UInt(16.W))
  val stage4_sum = Reg(UInt(16.W))

  val stage1_cout = Reg(Bool())
  val stage2_cout = Reg(Bool())
  val stage3_cout = Reg(Bool())
  val final_carry = Reg(Bool())

  // Instantiate and connect RCA16 modules for each stage
  val rca1 = Module(new RCA16)
  rca1.io.a := adda_reg(15, 0)
  rca1.io.b := addb_reg(15, 0)
  rca1.io.cin := 0.U
  stage1_sum := rca1.io.sum
  stage1_cout := rca1.io.cout

  val rca2 = Module(new RCA16)
  rca2.io.a := adda_reg(31, 16)
  rca2.io.b := addb_reg(31, 16)
  rca2.io.cin := stage1_cout
  stage2_sum := rca2.io.sum
  stage2_cout := rca2.io.cout

  val rca3 = Module(new RCA16)
  rca3.io.a := adda_reg(47, 32)
  rca3.io.b := addb_reg(47, 32)
  rca3.io.cin := stage2_cout
  stage3_sum := rca3.io.sum
  stage3_cout := rca3.io.cout

  val rca4 = Module(new RCA16)
  rca4.io.a := adda_reg(63, 48)
  rca4.io.b := addb_reg(63, 48)
  rca4.io.cin := stage3_cout
  stage4_sum := rca4.io.sum
  final_carry := rca4.io.cout

  // Task 4: Result Aggregation Logic
  val result_reg = Reg(UInt(65.W))
  result_reg := Cat(final_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum)
  io.result := result_reg

  // Task 5: Output Enable Generation
  io.o_en := en_pipeline(3)
}

/*
object dutMain extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
