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

  // Full Adder Logic
  val (s, c) = (Wire(Vec(16, Bool())), Wire(Vec(16, Bool())))

  for (i <- 0 until 16) {
    val ai = io.a(i).asBool
    val bi = io.b(i).asBool
    val c_in = if (i == 0) io.cin else c(i - 1)
    s(i) := ai ^ bi ^ c_in
    c(i) := (ai & bi) | (ai & c_in) | (bi & c_in)
  }

  io.sum := s.asUInt
  io.cout := c(15)
}

class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Input Registering and Enable Pipeline
  val adda_reg = RegEnable(io.adda, 0.U, io.i_en)
  val addb_reg = RegEnable(io.addb, 0.U, io.i_en)
  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))
  en_pipeline(0) := io.i_en
  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i - 1)
  }

  // 16-bit Ripple Carry Adders and Pipeline Stages
  val rca_stage1 = Module(new RCA16)
  val rca_stage2 = Module(new RCA16)
  val rca_stage3 = Module(new RCA16)
  val rca_stage4 = Module(new RCA16)

  rca_stage1.io.a := adda_reg(15, 0)
  rca_stage1.io.b := addb_reg(15, 0)
  rca_stage1.io.cin := 0.U

  val stage1_sum_reg = RegNext(rca_stage1.io.sum)
  val stage1_cout_reg = RegNext(rca_stage1.io.cout)

  rca_stage2.io.a := adda_reg(31, 16)
  rca_stage2.io.b := addb_reg(31, 16)
  rca_stage2.io.cin := stage1_cout_reg

  val stage2_sum_reg = RegNext(rca_stage2.io.sum)
  val stage2_cout_reg = RegNext(rca_stage2.io.cout)

  rca_stage3.io.a := adda_reg(47, 32)
  rca_stage3.io.b := addb_reg(47, 32)
  rca_stage3.io.cin := stage2_cout_reg

  val stage3_sum_reg = RegNext(rca_stage3.io.sum)
  val stage3_cout_reg = RegNext(rca_stage3.io.cout)

  rca_stage4.io.a := adda_reg(63, 48)
  rca_stage4.io.b := addb_reg(63, 48)
  rca_stage4.io.cin := stage3_cout_reg

  val stage4_sum_reg = RegNext(rca_stage4.io.sum)
  val final_carry = RegNext(rca_stage4.io.cout)

  // Result Aggregation Logic
  val result_reg = RegNext(Cat(final_carry, stage4_sum_reg, stage3_sum_reg, stage2_sum_reg, stage1_sum_reg))
  io.result := result_reg

  // Output Enable Generation
  io.o_en := en_pipeline(3)
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), args)
}
*/
