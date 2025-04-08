import chisel3._
import chisel3.util._

class RCA16 extends Module {
  val io = IO(new Bundle {
    val a    = Input(UInt(16.W))
    val b    = Input(UInt(16.W))
    val cin  = Input(UInt(1.W))
    val sum  = Output(UInt(16.W))
    val cout = Output(UInt(1.W))
  })

  val fullAdders = Array.fill(16)(Module(new FullAdder()))
  val sumBits = Wire(Vec(16, Bool()))
  val coutBits = Wire(Vec(16, Bool()))
  
  sumBits(0) := fullAdders(0).io.sum
  coutBits(0) := fullAdders(0).io.cout
  
  fullAdders(0).io.a := io.a(0)
  fullAdders(0).io.b := io.b(0)
  fullAdders(0).io.cin := io.cin

  for (i <- 1 until 16) {
    fullAdders(i).io.a := io.a(i)
    fullAdders(i).io.b := io.b(i)
    fullAdders(i).io.cin := coutBits(i-1)
    sumBits(i) := fullAdders(i).io.sum
    coutBits(i) := fullAdders(i).io.cout
  }

  io.sum := sumBits.asUInt()
  io.cout := coutBits(15)
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

  // Task 1: Input Registering and Enable Pipeline
  val adda_reg = RegEnable(io.adda, 0.U, io.i_en)
  val addb_reg = RegEnable(io.addb, 0.U, io.i_en)
  
  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))
  en_pipeline(0) := io.i_en
  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i-1)
  }

  // Pipeline stages
  val stage1 = Module(new RCA16)
  stage1.io.a := adda_reg(15, 0)
  stage1.io.b := addb_reg(15, 0)
  stage1.io.cin := 0.U
  val stage1_sum = RegEnable(stage1.io.sum, 0.U, en_pipeline(0))
  val stage1_cout = RegEnable(stage1.io.cout, 0.U, en_pipeline(0))
  
  val stage2 = Module(new RCA16)
  stage2.io.a := adda_reg(31, 16)
  stage2.io.b := addb_reg(31, 16)
  stage2.io.cin := stage1_cout
  val stage2_sum = RegEnable(stage2.io.sum, 0.U, en_pipeline(1))
  val stage2_cout = RegEnable(stage2.io.cout, 0.U, en_pipeline(1))
  
  val stage3 = Module(new RCA16)
  stage3.io.a := adda_reg(47, 32)
  stage3.io.b := addb_reg(47, 32)
  stage3.io.cin := stage2_cout
  val stage3_sum = RegEnable(stage3.io.sum, 0.U, en_pipeline(2))
  val stage3_cout = RegEnable(stage3.io.cout, 0.U, en_pipeline(2))
  
  val stage4 = Module(new RCA16)
  stage4.io.a := adda_reg(63, 48)
  stage4.io.b := addb_reg(63, 48)
  stage4.io.cin := stage3_cout
  val stage4_sum = RegEnable(stage4.io.sum, 0.U, en_pipeline(3))
  val final_carry = RegEnable(stage4.io.cout, 0.U, en_pipeline(3))

  // Task 4: Result Aggregation Logic
  val result_reg = RegInit(0.U(65.W))
  result_reg := Cat(final_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum)
  io.result := result_reg

  // Task 5: Output Enable Generation
  io.o_en := en_pipeline(3)
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
