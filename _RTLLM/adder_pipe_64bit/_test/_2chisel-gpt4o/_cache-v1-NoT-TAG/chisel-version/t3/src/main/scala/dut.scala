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

  // Ripple Carry Logic
  val fullAdders = Array.fill(16)(Module(new FullAdder).io)
  
  for (i <- 0 until 16) {
    if (i == 0) {
      fullAdders(i).a := io.a(0)
      fullAdders(i).b := io.b(0)
      fullAdders(i).cin := io.cin
    } else {
      fullAdders(i).a := io.a(i)
      fullAdders(i).b := io.b(i)
      fullAdders(i).cin := fullAdders(i-1).cout
    }
  }
  
  io.sum := Cat(fullAdders.map(_.sum).reverse)
  io.cout := fullAdders.last.cout
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
    val i_en   = Input(Bool())
    val adda   = Input(UInt(64.W))
    val addb   = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // Task 1: Input Registering and Enable Pipeline
  val adda_reg = RegEnable(io.adda, 0.U(64.W), io.i_en)
  val addb_reg = RegEnable(io.addb, 0.U(64.W), io.i_en)
  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))
  en_pipeline(0) := io.i_en
  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i - 1)
  }

  // Task 2: Instantiate 16-bit RCAs
  val rca1 = Module(new RCA16)
  val rca2 = Module(new RCA16)
  val rca3 = Module(new RCA16)
  val rca4 = Module(new RCA16)

  // Task 3: Pipeline Stage Implementation
  val stage1_sum = Reg(UInt(16.W))
  val stage1_cout = Reg(Bool())
  val stage2_sum = Reg(UInt(16.W))
  val stage2_cout = Reg(Bool())
  val stage3_sum = Reg(UInt(16.W))
  val stage3_cout = Reg(Bool())
  val stage4_sum = Reg(UInt(16.W))
  val stage4_cout = Reg(Bool())

  // Stage 1
  rca1.io.a := adda_reg(15, 0)
  rca1.io.b := addb_reg(15, 0)
  rca1.io.cin := false.B
  stage1_sum := rca1.io.sum
  stage1_cout := rca1.io.cout

  // Stage 2
  rca2.io.a := adda_reg(31, 16)
  rca2.io.b := addb_reg(31, 16)
  rca2.io.cin := stage1_cout
  stage2_sum := rca2.io.sum
  stage2_cout := rca2.io.cout

  // Stage 3
  rca3.io.a := adda_reg(47, 32)
  rca3.io.b := addb_reg(47, 32)
  rca3.io.cin := stage2_cout
  stage3_sum := rca3.io.sum
  stage3_cout := rca3.io.cout

  // Stage 4
  rca4.io.a := adda_reg(63, 48)
  rca4.io.b := addb_reg(63, 48)
  rca4.io.cin := stage3_cout
  stage4_sum := rca4.io.sum
  stage4_cout := rca4.io.cout

  // Task 4: Result Aggregation Logic
  val result_reg = Reg(UInt(65.W))
  result_reg := Cat(stage4_cout, stage4_sum, stage3_sum, stage2_sum, stage1_sum)
  io.result := result_reg

  // Task 5: Output Enable Generation
  io.o_en := en_pipeline(3)
}

