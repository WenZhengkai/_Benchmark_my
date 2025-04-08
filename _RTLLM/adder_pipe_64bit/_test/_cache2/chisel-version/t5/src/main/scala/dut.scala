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

  // Define full-adder logic for 16-bit ripple carry adder
  val c = Wire(Vec(17, Bool())) // Internal carry bits
  c(0) := io.cin

  // Sum and carry for each bit
  for (i <- 0 until 16) {
    val a = io.a(i)
    val b = io.b(i)
    io.sum(i) := a ^ b ^ c(i)
    c(i+1) := (a & b) | (a & c(i)) | (b & c(i))
  }

  io.cout := c(16)
}

class dut extends Module {
  val io = IO(new Bundle {
    val i_en  = Input(Bool())
    val adda  = Input(UInt(64.W))
    val addb  = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en  = Output(Bool())
  })

  // Task 1: Input Registering and Enable Pipeline
  val addaReg  = RegEnable(io.adda, 0.U, io.i_en)
  val addbReg  = RegEnable(io.addb, 0.U, io.i_en)
  val enPipeline = RegInit(VecInit(Seq.fill(4)(false.B)))

  enPipeline(0) := io.i_en
  for (i <- 1 until 4) {
    enPipeline(i) := enPipeline(i-1)
  }

  // Task 2: 16-bit Ripple Carry Adder Implementation
  val rcaStage1 = Module(new RCA16)
  val rcaStage2 = Module(new RCA16)
  val rcaStage3 = Module(new RCA16)
  val rcaStage4 = Module(new RCA16)

  // Task 3: Pipeline Stage Implementation
  // Stage 1
  val stage1Sum = Reg(UInt(16.W))
  val stage1Carry = Reg(Bool())

  rcaStage1.io.a := addaReg(15, 0)
  rcaStage1.io.b := addbReg(15, 0)
  rcaStage1.io.cin := false.B
  stage1Sum := rcaStage1.io.sum
  stage1Carry := rcaStage1.io.cout

  // Stage 2
  val stage2Sum = Reg(UInt(16.W))
  val stage2Carry = Reg(Bool())

  rcaStage2.io.a := addaReg(31, 16)
  rcaStage2.io.b := addbReg(31, 16)
  rcaStage2.io.cin := stage1Carry
  stage2Sum := rcaStage2.io.sum
  stage2Carry := rcaStage2.io.cout

  // Stage 3
  val stage3Sum = Reg(UInt(16.W))
  val stage3Carry = Reg(Bool())

  rcaStage3.io.a := addaReg(47, 32)
  rcaStage3.io.b := addbReg(47, 32)
  rcaStage3.io.cin := stage2Carry
  stage3Sum := rcaStage3.io.sum
  stage3Carry := rcaStage3.io.cout

  // Stage 4
  val stage4Sum = Reg(UInt(16.W))
  val finalCarry = Reg(Bool())

  rcaStage4.io.a := addaReg(63, 48)
  rcaStage4.io.b := addbReg(63, 48)
  rcaStage4.io.cin := stage3Carry
  stage4Sum := rcaStage4.io.sum
  finalCarry := rcaStage4.io.cout

  // Task 4: Result Aggregation Logic
  val resultReg = Cat(finalCarry, stage4Sum, stage3Sum, stage2Sum, stage1Sum)
  io.result := resultReg

  // Task 5: Output Enable Generation
  io.o_en := enPipeline(3)
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
