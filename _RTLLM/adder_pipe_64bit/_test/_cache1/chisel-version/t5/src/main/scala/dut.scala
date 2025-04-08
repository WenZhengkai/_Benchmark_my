import chisel3._
import chisel3.util._

// Define a 16-bit Ripple Carry Adder module
class RCA16 extends Module {
  val io = IO(new Bundle {
    val a    = Input(UInt(16.W))
    val b    = Input(UInt(16.W))
    val cin  = Input(Bool())
    val sum  = Output(UInt(16.W))
    val cout = Output(Bool())
  })

  // Full adder logic using chaining
  val gens = for (i <- 0 until 16) yield {
    val adder = Module(new FullAdder)
    adder
  }
  
  // Connect the full adders
  for (i <- 0 until 16) {
    gens(i).io.a := io.a(i)
    gens(i).io.b := io.b(i)
    if (i == 0)
      gens(i).io.cin := io.cin
    else
      gens(i).io.cin := gens(i-1).io.cout

    io.sum(i) := gens(i).io.sum
  }
  
  io.cout := gens(15).io.cout
}

// Basic Full Adder definition
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

// Define the main dut module
class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())
    val adda   = Input(UInt(64.W))
    val addb   = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // Create registers to capture inputs
  val adda_reg = RegEnable(io.adda, 0.U, io.i_en)
  val addb_reg = RegEnable(io.addb, 0.U, io.i_en)

  // 4-stage enable pipeline
  val en_pipeline = RegInit(0.U(4.W))
  en_pipeline := Cat(en_pipeline(2,0), io.i_en)

  // Pipeline stage 1
  val rca0 = Module(new RCA16)
  rca0.io.a := adda_reg(15, 0)
  rca0.io.b := addb_reg(15, 0)
  rca0.io.cin := false.B
  val stage1_sum = RegNext(rca0.io.sum)
  val stage1_cout = RegNext(rca0.io.cout)

  // Pipeline stage 2
  val rca1 = Module(new RCA16)
  rca1.io.a := adda_reg(31, 16)
  rca1.io.b := addb_reg(31, 16)
  rca1.io.cin := stage1_cout
  val stage2_sum = RegNext(rca1.io.sum)
  val stage2_cout = RegNext(rca1.io.cout)

  // Pipeline stage 3
  val rca2 = Module(new RCA16)
  rca2.io.a := adda_reg(47, 32)
  rca2.io.b := addb_reg(47, 32)
  rca2.io.cin := stage2_cout
  val stage3_sum = RegNext(rca2.io.sum)
  val stage3_cout = RegNext(rca2.io.cout)

  // Pipeline stage 4
  val rca3 = Module(new RCA16)
  rca3.io.a := adda_reg(63, 48)
  rca3.io.b := addb_reg(63, 48)
  rca3.io.cin := stage3_cout
  val stage4_sum = RegNext(rca3.io.sum)
  val final_carry = RegNext(rca3.io.cout)

  // Result aggregation
  val result_reg = RegNext(Cat(final_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum))
  io.result := result_reg

  // Output enable synchronizing
  io.o_en := en_pipeline(3)
}

// Create the top-level object to generate the Verilog code
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, args)
}
*/
