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

  // Create a vector of full adders
  val fullAdders = Array.fill(16)(Module(new FullAdder()).io)

  // Connect the inputs and chain the carry-outs to carry-ins
  fullAdders.zipWithIndex.foreach { case (fa, i) =>
    fa.a := io.a(i)
    fa.b := io.b(i)
    fa.cin := if (i == 0) io.cin else fullAdders(i - 1).cout
  }

  // Connect the outputs
  io.sum := VecInit(fullAdders.map(_.sum)).asUInt
  io.cout := fullAdders.last.cout
}

// Basic full adder implementation
class FullAdder extends Module {
  val io = IO(new Bundle {
    val a    = Input(UInt(1.W))
    val b    = Input(UInt(1.W))
    val cin  = Input(UInt(1.W))
    val sum  = Output(UInt(1.W))
    val cout = Output(UInt(1.W))
  })

  io.sum := io.a ^ io.b ^ io.cin // Sum bit
  io.cout := (io.a & io.b) | (io.b & io.cin) | (io.a & io.cin) // Carry out
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
  when(io.i_en) {
    en_pipeline(0) := true.B
  } .otherwise {
    en_pipeline(0) := en_pipeline(0)
  }
  for (stage <- 1 until 4) {
    en_pipeline(stage) := en_pipeline(stage - 1)
  }

  // Task 2: 16-bit Ripple Carry Adder (RCA) Implementation
  val rca1 = Module(new RCA16())
  val rca2 = Module(new RCA16())
  val rca3 = Module(new RCA16())
  val rca4 = Module(new RCA16())

  rca1.io.a := adda_reg(15, 0)
  rca1.io.b := addb_reg(15, 0)
  rca1.io.cin := 0.U

  rca2.io.a := adda_reg(31, 16)
  rca2.io.b := addb_reg(31, 16)
  rca2.io.cin := rca1.io.cout

  rca3.io.a := adda_reg(47, 32)
  rca3.io.b := addb_reg(47, 32)
  rca3.io.cin := rca2.io.cout

  rca4.io.a := adda_reg(63, 48)
  rca4.io.b := addb_reg(63, 48)
  rca4.io.cin := rca3.io.cout

  // Task 3: Pipeline Stage Implementation
  val stage1_sum = RegNext(rca1.io.sum)
  val stage2_sum = RegNext(rca2.io.sum)
  val stage3_sum = RegNext(rca3.io.sum)
  val stage4_sum = RegNext(rca4.io.sum)

  // Task 4: Result Aggregation Logic
  val final_carry = RegNext(rca4.io.cout)
  val result_reg = RegInit(0.U(65.W))
  result_reg := Cat(final_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum)

  // Connect the result register to the output
  io.result := result_reg

  // Task 5: Output Enable Generation
  io.o_en := en_pipeline(3)
}

/*
object AdderPipeMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), args)
}
*/
