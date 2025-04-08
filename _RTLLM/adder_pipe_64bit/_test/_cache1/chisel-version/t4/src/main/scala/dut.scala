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

  // Ripple carry adder implementation
  val sumWithCarry = Wire(Vec(16, Bool()))
  val carry        = Wire(Vec(17, Bool()))
  carry(0)         := io.cin

  for (i <- 0 until 16) {
    val a_bit = io.a(i)
    val b_bit = io.b(i)
    sumWithCarry(i) := a_bit ^ b_bit ^ carry(i)
    carry(i + 1) := (a_bit & b_bit) | (a_bit & carry(i)) | (b_bit & carry(i))
  }

  io.sum := sumWithCarry.asUInt
  io.cout := carry(16)
}

class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())
    val adda   = Input(UInt(64.W))
    val addb   = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // Registers for pipeline enable signals
  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))
  when (io.i_en) {
    en_pipeline(0) := true.B
  }.otherwise {
    en_pipeline(0) := false.B
  }
  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i - 1)
  }

  // Registers for inputs
  val adda_reg = RegEnable(io.adda, 0.U(64.W), io.i_en)
  val addb_reg = RegEnable(io.addb, 0.U(64.W), io.i_en)

  // Stage 1: Instantiating first RCA16
  val stage1_sum = Reg(UInt(16.W))
  val stage1_cout = Reg(Bool())
  val rca1 = Module(new RCA16)
  rca1.io.a := adda_reg(15, 0)
  rca1.io.b := addb_reg(15, 0)
  rca1.io.cin := false.B
  when(en_pipeline(0)) {
    stage1_sum := rca1.io.sum
    stage1_cout := rca1.io.cout
  }

  // Stage 2: Instantiating second RCA16
  val stage2_sum = Reg(UInt(16.W))
  val stage2_cout = Reg(Bool())
  val rca2 = Module(new RCA16)
  rca2.io.a := adda_reg(31, 16)
  rca2.io.b := addb_reg(31, 16)
  rca2.io.cin := stage1_cout
  when(en_pipeline(1)) {
    stage2_sum := rca2.io.sum
    stage2_cout := rca2.io.cout
  }

  // Stage 3: Instantiating third RCA16
  val stage3_sum = Reg(UInt(16.W))
  val stage3_cout = Reg(Bool())
  val rca3 = Module(new RCA16)
  rca3.io.a := adda_reg(47, 32)
  rca3.io.b := addb_reg(47, 32)
  rca3.io.cin := stage2_cout
  when(en_pipeline(2)) {
    stage3_sum := rca3.io.sum
    stage3_cout := rca3.io.cout
  }

  // Stage 4: Instantiating fourth RCA16
  val stage4_sum = Reg(UInt(16.W))
  val stage4_cout = Reg(Bool())
  val rca4 = Module(new RCA16)
  rca4.io.a := adda_reg(63, 48)
  rca4.io.b := addb_reg(63, 48)
  rca4.io.cin := stage3_cout
  when(en_pipeline(3)) {
    stage4_sum := rca4.io.sum
    stage4_cout := rca4.io.cout
  }

  // Result aggregation
  val result_reg = Reg(UInt(65.W))
  when (en_pipeline(3)) {
    result_reg := Cat(stage4_cout, stage4_sum, stage3_sum, stage2_sum, stage1_sum)
  }
  io.result := result_reg

  // Output enable signal
  io.o_en := en_pipeline(3)
}
