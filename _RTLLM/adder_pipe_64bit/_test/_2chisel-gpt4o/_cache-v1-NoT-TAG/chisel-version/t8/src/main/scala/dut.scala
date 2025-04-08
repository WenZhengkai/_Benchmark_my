import chisel3._
import chisel3.util._

/** 16-bit Ripple Carry Adder Module */
class RCA16 extends Module {
  val io = IO(new Bundle {
    val a    = Input(UInt(16.W))
    val b    = Input(UInt(16.W))
    val cin  = Input(Bool())
    val sum  = Output(UInt(16.W))
    val cout = Output(Bool())
  })

  // Ripple carry logic using full adders
  val sum  = Wire(Vec(16, Bool()))
  val carry = Wire(Vec(17, Bool()))
  carry(0) := io.cin

  for (i <- 0 until 16) {
    val a_bit = io.a(i)
    val b_bit = io.b(i)
    sum(i)    := a_bit ^ b_bit ^ carry(i)
    carry(i + 1) := (a_bit & b_bit) | (a_bit & carry(i)) | (b_bit & carry(i))
  }

  io.sum := sum.asUInt()
  io.cout := carry(16)
}

/** 64-bit Pipelined Ripple Carry Adder Module */
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
    en_pipeline(i) := en_pipeline(i - 1)
  }

  // Task 2: Instantiate Ripple Carry Adders for each pipeline stage
  val stage1 = Module(new RCA16())
  val stage2 = Module(new RCA16())
  val stage3 = Module(new RCA16())
  val stage4 = Module(new RCA16())

  // Task 3: Pipeline Stage Implementation
  // Stage 1
  val stage1_sum = RegInit(0.U(16.W))
  val stage1_cout = RegInit(false.B)
  stage1.io.a := adda_reg(15, 0)
  stage1.io.b := addb_reg(15, 0)
  stage1.io.cin := false.B
  when(en_pipeline(0)) {
    stage1_sum := stage1.io.sum
    stage1_cout := stage1.io.cout
  }

  // Stage 2
  val stage2_sum = RegInit(0.U(16.W))
  val stage2_cout = RegInit(false.B)
  stage2.io.a := adda_reg(31, 16)
  stage2.io.b := addb_reg(31, 16)
  stage2.io.cin := stage1_cout
  when(en_pipeline(1)) {
    stage2_sum := stage2.io.sum
    stage2_cout := stage2.io.cout
  }

  // Stage 3
  val stage3_sum = RegInit(0.U(16.W))
  val stage3_cout = RegInit(false.B)
  stage3.io.a := adda_reg(47, 32)
  stage3.io.b := addb_reg(47, 32)
  stage3.io.cin := stage2_cout
  when(en_pipeline(2)) {
    stage3_sum := stage3.io.sum
    stage3_cout := stage3.io.cout
  }

  // Stage 4
  val stage4_sum = RegInit(0.U(16.W))
  val stage4_cout = RegInit(false.B)
  stage4.io.a := adda_reg(63, 48)
  stage4.io.b := addb_reg(63, 48)
  stage4.io.cin := stage3_cout
  when(en_pipeline(3)) {
    stage4_sum := stage4.io.sum
    stage4_cout := stage4.io.cout
  }

  // Task 4: Result Aggregation Logic
  val result_reg = RegInit(0.U(65.W))
  when(en_pipeline(3)) {
    result_reg := Cat(stage4_cout, stage4_sum, stage3_sum, stage2_sum, stage1_sum)
  }

  // Task 5: Output Enable Generation
  io.result := result_reg
  io.o_en := en_pipeline(3)
}

