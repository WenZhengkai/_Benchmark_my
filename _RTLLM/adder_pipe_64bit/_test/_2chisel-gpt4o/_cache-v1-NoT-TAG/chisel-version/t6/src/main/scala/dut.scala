import chisel3._
import chisel3.util._

// 16-bit Ripple Carry Adder (RCA16)
class RCA16 extends Module {
  val io = IO(new Bundle {
    val a    = Input(UInt(16.W))
    val b    = Input(UInt(16.W))
    val cin  = Input(Bool())
    val sum  = Output(UInt(16.W))
    val cout = Output(Bool())
  })

  // Internal logic for the ripple carry adder
  val fullAdders = Seq.fill(16)(Module(new FullAdder()))
  val carries = Wire(Vec(16, Bool()))
  
  for (i <- 0 until 16) {
    fullAdders(i).io.a := io.a(i)
    fullAdders(i).io.b := io.b(i)
    fullAdders(i).io.cin := if (i == 0) io.cin else carries(i - 1)
    carries(i) := fullAdders(i).io.cout
  }

  io.sum := fullAdders.map(_.io.sum).reverse.reduce(Cat(_, _))
  io.cout := carries(15)
}

// Full Adder module
class FullAdder extends Module {
  val io = IO(new Bundle {
    val a    = Input(Bool())
    val b    = Input(Bool())
    val cin  = Input(Bool())
    val sum  = Output(Bool())
    val cout = Output(Bool())
  })
  io.sum := io.a ^ io.b ^ io.cin
  io.cout := (io.a & io.b) | (io.b & io.cin) | (io.a & io.cin)
}

// 64-bit Pipeline Ripple Carry Adder
class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())
    val adda   = Input(UInt(64.W))
    val addb   = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // Task 1: Input registering and enable pipeline
  val adda_reg = RegEnable(io.adda, 0.U, io.i_en)
  val addb_reg = RegEnable(io.addb, 0.U, io.i_en)
  
  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))
  en_pipeline(0) := io.i_en
  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i - 1)
  }

  // Task 2: 16-bit Ripple Carry Adder Instances
  val rca16_1 = Module(new RCA16())
  val rca16_2 = Module(new RCA16())
  val rca16_3 = Module(new RCA16())
  val rca16_4 = Module(new RCA16())

  // Task 3: Pipeline stage implementation
  // Stage 1: Bits [15:0]
  val stage1_sum = RegEnable(rca16_1.io.sum, 0.U(16.W), en_pipeline(0))
  val stage1_carry = RegEnable(rca16_1.io.cout, false.B, en_pipeline(0))
  rca16_1.io.a := adda_reg(15, 0)
  rca16_1.io.b := addb_reg(15, 0)
  rca16_1.io.cin := false.B

  // Stage 2: Bits [31:16]
  val stage2_sum = RegEnable(rca16_2.io.sum, 0.U(16.W), en_pipeline(1))
  val stage2_carry = RegEnable(rca16_2.io.cout, false.B, en_pipeline(1))
  rca16_2.io.a := adda_reg(31, 16)
  rca16_2.io.b := addb_reg(31, 16)
  rca16_2.io.cin := stage1_carry

  // Stage 3: Bits [47:32]
  val stage3_sum = RegEnable(rca16_3.io.sum, 0.U(16.W), en_pipeline(2))
  val stage3_carry = RegEnable(rca16_3.io.cout, false.B, en_pipeline(2))
  rca16_3.io.a := adda_reg(47, 32)
  rca16_3.io.b := addb_reg(47, 32)
  rca16_3.io.cin := stage2_carry

  // Stage 4: Bits [63:48]
  val stage4_sum = RegEnable(rca16_4.io.sum, 0.U(16.W), en_pipeline(3))
  val stage4_carry = RegEnable(rca16_4.io.cout, false.B, en_pipeline(3))
  rca16_4.io.a := adda_reg(63, 48)
  rca16_4.io.b := addb_reg(63, 48)
  rca16_4.io.cin := stage3_carry

  // Task 4: Result aggregation logic
  val result_reg = Reg(UInt(65.W))
  result_reg := Cat(stage4_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum)
  io.result := result_reg

  // Task 5: Output enable generation
  io.o_en := en_pipeline(3)
}

