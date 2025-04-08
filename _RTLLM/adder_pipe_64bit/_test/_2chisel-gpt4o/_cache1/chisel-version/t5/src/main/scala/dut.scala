
import chisel3._
import chisel3.util._

// Define a module for a 16-bit ripple carry adder
class RippleCarryAdder16 extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(16.W))
    val b = Input(UInt(16.W))
    val cin = Input(UInt(1.W))
    val sum = Output(UInt(16.W))
    val cout = Output(UInt(1.W))
  })

  // Generate the sum and carry out using a simple addition
  val result = io.a +& io.b + io.cin
  io.sum := result(15, 0)       // Lower 16 bits
  io.cout := result(16)         // Carry out bit
}

// Define the main module for the 64-bit pipelined ripple carry adder
class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Registers for pipelining
  val enReg = RegNext(io.i_en, init = false.B)
  val stage1Sum = Reg(UInt(16.W))
  val stage1Cout = Reg(UInt(1.W))
  val stage2Sum = Reg(UInt(16.W))
  val stage2Cout = Reg(UInt(1.W))
  val stage3Sum = Reg(UInt(16.W))
  val stage3Cout = Reg(UInt(1.W))
  val stage4Sum = Reg(UInt(16.W))
  val stage4Cout = Reg(UInt(1.W))

  // Stage 1
  val adder1 = Module(new RippleCarryAdder16)
  adder1.io.a := io.adda(15, 0)
  adder1.io.b := io.addb(15, 0)
  adder1.io.cin := 0.U
  when(io.i_en) {
    stage1Sum := adder1.io.sum
    stage1Cout := adder1.io.cout
  }

  // Stage 2
  val adder2 = Module(new RippleCarryAdder16)
  adder2.io.a := io.adda(31, 16)
  adder2.io.b := io.addb(31, 16)
  adder2.io.cin := stage1Cout
  when(RegNext(io.i_en, init = false.B)) {
    stage2Sum := adder2.io.sum
    stage2Cout := adder2.io.cout
  }

  // Stage 3
  val adder3 = Module(new RippleCarryAdder16)
  adder3.io.a := io.adda(47, 32)
  adder3.io.b := io.addb(47, 32)
  adder3.io.cin := stage2Cout
  when(RegNext(RegNext(io.i_en, init = false.B), init = false.B)) {
    stage3Sum := adder3.io.sum
    stage3Cout := adder3.io.cout
  }

  // Stage 4
  val adder4 = Module(new RippleCarryAdder16)
  adder4.io.a := io.adda(63, 48)
  adder4.io.b := io.addb(63, 48)
  adder4.io.cin := stage3Cout
  when(RegNext(RegNext(RegNext(io.i_en, init = false.B), init = false.B), init = false.B)) {
    stage4Sum := adder4.io.sum
    stage4Cout := adder4.io.cout
  }

  // Compose the result
  io.result := Cat(stage4Cout, stage4Sum, stage3Sum, stage2Sum, stage1Sum)
  io.o_en := RegNext(RegNext(RegNext(enReg, init = false.B), init = false.B), init = false.B)
}
