import chisel3._
import chisel3.util._

// Define a Full Adder component
class FullAdder extends Module {
  val io = IO(new Bundle {
    val a = Input(Bool())
    val b = Input(Bool())
    val cin = Input(Bool())
    val sum = Output(Bool())
    val cout = Output(Bool())
  })

  val sum = io.a ^ io.b ^ io.cin
  val cout = (io.a & io.b) | (io.a & io.cin) | (io.b & io.cin)

  io.sum := sum
  io.cout := cout
}

// Define a 16-bit Ripple Carry Adder
class RCA16 extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(16.W))
    val b = Input(UInt(16.W))
    val cin = Input(Bool())
    val sum = Output(UInt(16.W))
    val cout = Output(Bool())
  })

  val carry = Wire(Vec(17, Bool()))
  carry(0) := io.cin

  val sum = Wire(Vec(16, Bool()))

  for (i <- 0 until 16) {
    val fa = Module(new FullAdder)
    fa.io.a := io.a(i)
    fa.io.b := io.b(i)
    fa.io.cin := carry(i)
    sum(i) := fa.io.sum
    carry(i + 1) := fa.io.cout
  }

  io.sum := sum.asUInt
  io.cout := carry(16)
}

// 64-bit Ripple Carry Adder with Pipeline
class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Task 1: Input Registering and Enable Pipeline
  val addaReg = RegEnable(io.adda, 0.U, io.i_en)
  val addbReg = RegEnable(io.addb, 0.U, io.i_en)

  val enPipeline = RegInit(VecInit(Seq.fill(4)(false.B)))
  when(io.i_en) {
    enPipeline(0) := true.B
  }.otherwise {
    enPipeline(0) := false.B
  }
  for (i <- 1 until 4) {
    enPipeline(i) := enPipeline(i - 1)
  }

  // Task 3: Pipeline Stage Implementation (using RCA16)
  val stage1 = Module(new RCA16)
  stage1.io.a := addaReg(15, 0)
  stage1.io.b := addbReg(15, 0)
  stage1.io.cin := false.B

  val stage1SumReg = RegEnable(stage1.io.sum, 0.U, enPipeline(0))
  val carry1Reg = RegEnable(stage1.io.cout, false.B, enPipeline(0))

  val stage2 = Module(new RCA16)
  stage2.io.a := addaReg(31, 16)
  stage2.io.b := addbReg(31, 16)
  stage2.io.cin := carry1Reg

  val stage2SumReg = RegEnable(stage2.io.sum, 0.U, enPipeline(1))
  val carry2Reg = RegEnable(stage2.io.cout, false.B, enPipeline(1))

  val stage3 = Module(new RCA16)
  stage3.io.a := addaReg(47, 32)
  stage3.io.b := addbReg(47, 32)
  stage3.io.cin := carry2Reg

  val stage3SumReg = RegEnable(stage3.io.sum, 0.U, enPipeline(2))
  val carry3Reg = RegEnable(stage3.io.cout, false.B, enPipeline(2))

  val stage4 = Module(new RCA16)
  stage4.io.a := addaReg(63, 48)
  stage4.io.b := addbReg(63, 48)
  stage4.io.cin := carry3Reg

  val stage4SumReg = RegEnable(stage4.io.sum, 0.U, enPipeline(3))
  val finalCarryReg = RegEnable(stage4.io.cout, false.B, enPipeline(3))

  // Task 4: Result Aggregation Logic
  val resultReg = RegNext(Cat(finalCarryReg, stage4SumReg, stage3SumReg, stage2SumReg, stage1SumReg), 0.U)

  io.result := resultReg

  // Task 5: Output Enable Generation
  io.o_en := RegNext(enPipeline(3), false.B)
}

/*
object dutDriver extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
