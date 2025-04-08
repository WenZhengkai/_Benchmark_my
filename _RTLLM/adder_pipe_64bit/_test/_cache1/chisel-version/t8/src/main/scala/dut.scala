import chisel3._
import chisel3.util._

// Task 2: 16-bit Ripple Carry Adder (RCA) implementation
class RCA16 extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(16.W))
    val b = Input(UInt(16.W))
    val cin = Input(UInt(1.W))
    val sum = Output(UInt(16.W))
    val cout = Output(UInt(1.W))
  })

  // Ripple carry addition
  val (sum, carryOut) = (0 until 16).foldLeft((Wire(Vec(16, Bool())), io.cin)) {
    case ((sumVec, carryIn), i) =>
      val fullAdder = Module(new FullAdder)
      fullAdder.io.a := io.a(i)
      fullAdder.io.b := io.b(i)
      fullAdder.io.cin := carryIn

      sumVec(i) := fullAdder.io.sum
      (sumVec, fullAdder.io.cout)
  }

  io.sum := sum.asUInt
  io.cout := carryOut
}

class FullAdder extends Module {
  val io = IO(new Bundle {
    val a = Input(Bool())
    val b = Input(Bool())
    val cin = Input(Bool())
    val sum = Output(Bool())
    val cout = Output(Bool())
  })

  io.sum := io.a ^ io.b ^ io.cin
  io.cout := (io.a & io.b) | (io.b & io.cin) | (io.a & io.cin)
}

// Task 1, 3, 4, and 5: Pipeline stage and final 64-bit adder
class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Registers for input operands and the enable signal
  val addaReg = RegEnable(io.adda, 0.U(64.W), io.i_en)
  val addbReg = RegEnable(io.addb, 0.U(64.W), io.i_en)
  val enPipeline = RegInit(VecInit(Seq.fill(4)(false.B)))

  enPipeline(0) := io.i_en
  for (i <- 1 until 4) {
    enPipeline(i) := enPipeline(i - 1)
  }

  // Task 3: 16-bit slices and adder instantiation
  val rca1 = Module(new RCA16)
  rca1.io.a := addaReg(15, 0)
  rca1.io.b := addbReg(15, 0)
  rca1.io.cin := 0.U
  val stage1Sum = RegNext(rca1.io.sum)
  val stage1Cout = RegNext(rca1.io.cout)

  val rca2 = Module(new RCA16)
  rca2.io.a := addaReg(31, 16)
  rca2.io.b := addbReg(31, 16)
  rca2.io.cin := stage1Cout
  val stage2Sum = RegNext(rca2.io.sum)
  val stage2Cout = RegNext(rca2.io.cout)

  val rca3 = Module(new RCA16)
  rca3.io.a := addaReg(47, 32)
  rca3.io.b := addbReg(47, 32)
  rca3.io.cin := stage2Cout
  val stage3Sum = RegNext(rca3.io.sum)
  val stage3Cout = RegNext(rca3.io.cout)

  val rca4 = Module(new RCA16)
  rca4.io.a := addaReg(63, 48)
  rca4.io.b := addbReg(63, 48)
  rca4.io.cin := stage3Cout
  val stage4Sum = RegNext(rca4.io.sum)
  val stage4Cout = RegNext(rca4.io.cout)

  // Task 4: Result concatenation logic
  val resultReg = RegNext(Cat(stage4Cout, stage4Sum, stage3Sum, stage2Sum, stage1Sum))
  io.result := resultReg

  // Task 5: Output enable signal
  io.o_en := enPipeline(3)
}

// Generate the Verilog
/*
object dutDriver extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
