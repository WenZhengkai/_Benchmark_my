import chisel3._
import chisel3.util._

class RCA16 extends Module {
  val io = IO(new Bundle {
    val a    = Input(UInt(16.W))  // 16-bit operand A
    val b    = Input(UInt(16.W))  // 16-bit operand B
    val cin  = Input(Bool())      // Carry-in
    val sum  = Output(UInt(16.W)) // 16-bit sum output
    val cout = Output(Bool())     // Carry-out
  })

  // Full adder ripple carry logic
  val sums    = Wire(Vec(16, Bool()))
  val carries = Wire(Vec(17, Bool()))

  carries(0) := io.cin
  for (i <- 0 until 16) {
    val a_bit = io.a(i)
    val b_bit = io.b(i)
    sums(i) := a_bit ^ b_bit ^ carries(i) // Sum = A ^ B ^ Cin
    carries(i + 1) := (a_bit & b_bit) | (a_bit & carries(i)) | (b_bit & carries(i)) // Carry = Majority(A, B, Cin)
  }

  io.sum := sums.asUInt
  io.cout := carries(16) // Final carry-out
}

class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())          // Enable signal for operation
    val adda   = Input(UInt(64.W))      // 64-bit input operand A
    val addb   = Input(UInt(64.W))      // 64-bit input operand B
    val result = Output(UInt(65.W))     // 65-bit sum output
    val o_en   = Output(Bool())         // Output enable signal
  })

  // Task 1: Input Registering and Enable Pipeline
  val adda_reg = RegEnable(io.adda, 0.U(64.W), io.i_en) // Register operand A
  val addb_reg = RegEnable(io.addb, 0.U(64.W), io.i_en) // Register operand B

  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B))) // 4-stage enable pipeline
  en_pipeline(0) := io.i_en
  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i - 1) // Shift enable signals
  }

  // Task 2: 16-bit Ripple Carry Adder (RCA) Implementation
  val stage1 = Module(new RCA16)
  val stage2 = Module(new RCA16)
  val stage3 = Module(new RCA16)
  val stage4 = Module(new RCA16)

  // Task 3: Pipeline Stage Implementation
  // Stage 1
  stage1.io.a    := adda_reg(15, 0) // 16 LSB of operand A
  stage1.io.b    := addb_reg(15, 0) // 16 LSB of operand B
  stage1.io.cin  := false.B         // No carry-in for the first stage
  val stage1_sum = RegNext(stage1.io.sum) // Register the partial sum
  val stage1_cout = RegNext(stage1.io.cout) // Register the carry-out

  // Stage 2
  stage2.io.a    := adda_reg(31, 16) // Next 16 bits of operand A
  stage2.io.b    := addb_reg(31, 16) // Next 16 bits of operand B
  stage2.io.cin  := stage1_cout      // Carry-in from stage 1
  val stage2_sum = RegNext(stage2.io.sum) // Register partial sum
  val stage2_cout = RegNext(stage2.io.cout) // Register carry-out

  // Stage 3
  stage3.io.a    := adda_reg(47, 32) // Next 16 bits of operand A
  stage3.io.b    := addb_reg(47, 32) // Next 16 bits of operand B
  stage3.io.cin  := stage2_cout      // Carry-in from stage 2
  val stage3_sum = RegNext(stage3.io.sum) // Register partial sum
  val stage3_cout = RegNext(stage3.io.cout) // Register carry-out

  // Stage 4
  stage4.io.a    := adda_reg(63, 48) // MSB 16 bits of operand A
  stage4.io.b    := addb_reg(63, 48) // MSB 16 bits of operand B
  stage4.io.cin  := stage3_cout      // Carry-in from stage 3
  val stage4_sum = RegNext(stage4.io.sum) // Register partial sum
  val stage4_cout = RegNext(stage4.io.cout) // Register carry-out

  // Task 4: Result Aggregation Logic
  val result_reg = RegNext(Cat(stage4_cout, stage4_sum, stage3_sum, stage2_sum, stage1_sum)) // Combine all into 65-bit result
  io.result := result_reg // Connect to output

  // Task 5: Output Enable Generation
  io.o_en := RegNext(en_pipeline(3)) // Connect last stage of enable pipeline
}


