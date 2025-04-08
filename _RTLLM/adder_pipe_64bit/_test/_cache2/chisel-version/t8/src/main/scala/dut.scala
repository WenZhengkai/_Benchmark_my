import chisel3._
import chisel3.util._

class RCA16 extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(16.W))
    val b = Input(UInt(16.W))
    val cin = Input(Bool())
    val sum = Output(UInt(16.W))
    val cout = Output(Bool())
  })

  // Helper function for full adder
  def fullAdder(a: Bool, b: Bool, cin: Bool): (Bool, Bool) = {
    val sum = a ^ b ^ cin
    val cout = (a & b) | (b & cin) | (a & cin)
    (sum, cout)
  }

  // Initialize sum and carry
  val sum = Wire(Vec(16, Bool()))
  val carry = Wire(Vec(16, Bool()))
  carry(0) := io.cin

  // Generate ripple carry adder logic
  for (i <- 0 until 16) {
    val (s, c) = fullAdder(io.a(i), io.b(i), carry(i))
    sum(i) := s
    if (i < 15) carry(i + 1) := c
  }

  // Output assignments
  io.sum := sum.asUInt
  io.cout := carry(15)
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
  val adda_reg = RegEnable(io.adda, 0.U(64.W), io.i_en)
  val addb_reg = RegEnable(io.addb, 0.U(64.W), io.i_en)
  
  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))
  en_pipeline(0) := io.i_en
  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i - 1)
  }

  // Task 3: Pipeline Stage Implementation
  // Storing Stage-wise sum and carry
  val stage1_sum = Reg(UInt(16.W))
  val stage1_carry = Reg(Bool())
  val stage2_sum = Reg(UInt(16.W))
  val stage2_carry = Reg(Bool())
  val stage3_sum = Reg(UInt(16.W))
  val stage3_carry = Reg(Bool())
  val stage4_sum = Reg(UInt(16.W))
  val stage4_carry = Reg(Bool())

  // Task 2 and Task 3: Implementing 16-bit RCA stages
  val rca1 = Module(new RCA16)
  rca1.io.a := adda_reg(15, 0)
  rca1.io.b := addb_reg(15, 0)
  rca1.io.cin := false.B
  stage1_sum := rca1.io.sum
  stage1_carry := rca1.io.cout

  val rca2 = Module(new RCA16)
  rca2.io.a := adda_reg(31, 16)
  rca2.io.b := addb_reg(31, 16)
  rca2.io.cin := stage1_carry
  stage2_sum := rca2.io.sum
  stage2_carry := rca2.io.cout

  val rca3 = Module(new RCA16)
  rca3.io.a := adda_reg(47, 32)
  rca3.io.b := addb_reg(47, 32)
  rca3.io.cin := stage2_carry
  stage3_sum := rca3.io.sum
  stage3_carry := rca3.io.cout

  val rca4 = Module(new RCA16)
  rca4.io.a := adda_reg(63, 48)
  rca4.io.b := addb_reg(63, 48)
  rca4.io.cin := stage3_carry
  stage4_sum := rca4.io.sum
  stage4_carry := rca4.io.cout

  // Task 4: Result Aggregation Logic
  val result_reg = Reg(UInt(65.W))
  result_reg := Cat(stage4_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum)
  io.result := result_reg

  // Task 5: Output Enable Generation
  io.o_en := en_pipeline(3)
}
