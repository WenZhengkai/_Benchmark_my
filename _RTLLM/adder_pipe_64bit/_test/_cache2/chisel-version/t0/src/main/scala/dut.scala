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
  val (sums, carries) = (0 until 16).foldLeft((Wire(Vec(16, Bool())), Wire(Vec(16, Bool())))) { case ((s, c), i) =>
    val fullAdderSum = Wire(Bool())
    val fullAdderCout = Wire(Bool())
    if (i == 0) {
      fullAdderSum := io.a(i) ^ io.b(i) ^ io.cin
      fullAdderCout := (io.a(i) & io.b(i)) | (io.a(i) & io.cin) | (io.b(i) & io.cin)
    } else {
      fullAdderSum := io.a(i) ^ io.b(i) ^ c(i - 1)
      fullAdderCout := (io.a(i) & io.b(i)) | (io.a(i) & c(i - 1)) | (io.b(i) & c(i - 1))
    }
    s(i) := fullAdderSum
    c(i) := fullAdderCout
    (s, c)
  }

  io.sum := sums.asUInt()
  io.cout := carries(15)
}

class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Task 1: Input Registering and Enable Pipeline
  val addaReg = RegEnable(io.adda, 0.U(64.W), io.i_en)
  val addbReg = RegEnable(io.addb, 0.U(64.W), io.i_en)
  val enPipeline = RegInit(0.U(4.W))
  enPipeline := enPipeline(2, 0) ## io.i_en

  // Task 3: Pipeline Stage Implementation
  // Stage 1
  val rca1 = Module(new RCA16())
  rca1.io.a := addaReg(15, 0)
  rca1.io.b := addbReg(15, 0)
  rca1.io.cin := 0.U

  val stage1Sum = RegNext(rca1.io.sum)
  val stage1Cout = RegNext(rca1.io.cout)

  // Stage 2
  val rca2 = Module(new RCA16())
  rca2.io.a := addaReg(31, 16)
  rca2.io.b := addbReg(31, 16)
  rca2.io.cin := stage1Cout

  val stage2Sum = RegNext(rca2.io.sum)
  val stage2Cout = RegNext(rca2.io.cout)

  // Stage 3
  val rca3 = Module(new RCA16())
  rca3.io.a := addaReg(47, 32)
  rca3.io.b := addbReg(47, 32)
  rca3.io.cin := stage2Cout

  val stage3Sum = RegNext(rca3.io.sum)
  val stage3Cout = RegNext(rca3.io.cout)

  // Stage 4
  val rca4 = Module(new RCA16())
  rca4.io.a := addaReg(63, 48)
  rca4.io.b := addbReg(63, 48)
  rca4.io.cin := stage3Cout

  val stage4Sum = RegNext(rca4.io.sum)
  val finalCarry = RegNext(rca4.io.cout)

  // Task 4: Result Aggregation Logic
  val resultReg = RegNext(Cat(finalCarry, stage4Sum, stage3Sum, stage2Sum, stage1Sum))
  io.result := resultReg

  // Task 5: Output Enable Generation
  io.o_en := enPipeline(3)
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut())
}
*/
