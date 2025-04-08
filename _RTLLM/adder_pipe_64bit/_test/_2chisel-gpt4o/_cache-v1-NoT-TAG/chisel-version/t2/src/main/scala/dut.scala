import chisel3._
import chisel3.util._

class RCA16 extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(16.W)) // 16-bit input A
    val b = Input(UInt(16.W)) // 16-bit input B
    val cin = Input(Bool())   // Carry-in (1-bit)
    val sum = Output(UInt(16.W)) // 16-bit sum
    val cout = Output(Bool())    // Carry-out (1-bit)
  })

  // Ripple Carry Adder Logic
  val carries = Wire(Vec(16, Bool()))
  val sum_bits = Wire(Vec(16, Bool()))

  for (i <- 0 until 16) {
    val a_bit = io.a(i)
    val b_bit = io.b(i)
    val cin_bit = if (i == 0) io.cin else carries(i - 1)

    // Full adder logic
    sum_bits(i) := a_bit ^ b_bit ^ cin_bit
    carries(i) := (a_bit & b_bit) | (b_bit & cin_bit) | (a_bit & cin_bit)
  }

  io.sum := sum_bits.asUInt // Combine sum bits into UInt
  io.cout := carries(15)    // The last carry bit is the carry-out
}

class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())       // Enable signal for addition
    val adda = Input(UInt(64.W))   // Input operand A
    val addb = Input(UInt(64.W))   // Input operand B
    val result = Output(UInt(65.W))// 65-bit output: sum of adda and addb
    val o_en = Output(Bool())      // Output enable signal
  })

  // Task 1: Input Registering and Enable Pipeline
  val adda_reg = RegEnable(io.adda, 0.U, io.i_en) // Register for adda
  val addb_reg = RegEnable(io.addb, 0.U, io.i_en) // Register for addb

  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B))) // Enable pipeline
  when(io.i_en) {
    en_pipeline(0) := true.B // Shift in enable signal
  }.otherwise {
    en_pipeline(0) := false.B
  }
  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i - 1) // Shift pipeline
  }

  // Task 2: Implementing 16-bit Ripple Carry Adder logic
  val rca1 = Module(new RCA16())
  val rca2 = Module(new RCA16())
  val rca3 = Module(new RCA16())
  val rca4 = Module(new RCA16())

  // Task 3: Pipeline Stage Implementation
  val stage1_sum = Reg(UInt(16.W))
  val stage1_carry = Reg(Bool())
  rca1.io.a := adda_reg(15, 0)
  rca1.io.b := addb_reg(15, 0)
  rca1.io.cin := 0.B
  stage1_sum := rca1.io.sum
  stage1_carry := rca1.io.cout

  val stage2_sum = Reg(UInt(16.W))
  val stage2_carry = Reg(Bool())
  rca2.io.a := adda_reg(31, 16)
  rca2.io.b := addb_reg(31, 16)
  rca2.io.cin := stage1_carry
  stage2_sum := rca2.io.sum
  stage2_carry := rca2.io.cout

  val stage3_sum = Reg(UInt(16.W))
  val stage3_carry = Reg(Bool())
  rca3.io.a := adda_reg(47, 32)
  rca3.io.b := addb_reg(47, 32)
  rca3.io.cin := stage2_carry
  stage3_sum := rca3.io.sum
  stage3_carry := rca3.io.cout

  val stage4_sum = Reg(UInt(16.W))
  val stage4_carry = Reg(Bool())
  rca4.io.a := adda_reg(63, 48)
  rca4.io.b := addb_reg(63, 48)
  rca4.io.cin := stage3_carry
  stage4_sum := rca4.io.sum
  stage4_carry := rca4.io.cout

  // Task 4: Combine partial sums and final carry
  val result_reg = Reg(UInt(65.W))
  result_reg := Cat(stage4_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum)
  io.result := result_reg

  // Task 5: Output Enable
  io.o_en := en_pipeline(3) // Output enable synchronized with 4th stage
}
