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

  val adderChain = (0 until 16).scanLeft((io.cin, Wire(UInt(1.W)))) { case ((c, _), i) =>
    val a_bit = io.a(i)
    val b_bit = io.b(i)
    val sum_bit = a_bit ^ b_bit ^ c
    val carry_out = (a_bit & b_bit) | (a_bit & c) | (b_bit & c)
    sum_bit := adderChain(i)._2
    (carry_out, sum_bit)
  }

  io.sum := adderChain.drop(1).map(_._2).asUInt
  io.cout := adderChain.last._1
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

  // Task 2: 16-bit RCA Implementation (instantiation done in Task 3)

  // Task 3: Pipeline Stage Implementation
  val stage1RCA = Module(new RCA16())
  stage1RCA.io.a := addaReg(15, 0)
  stage1RCA.io.b := addbReg(15, 0)
  stage1RCA.io.cin := 0.U

  val stage1Sum = RegNext(stage1RCA.io.sum)
  val stage1Carry = RegNext(stage1RCA.io.cout)

  val stage2RCA = Module(new RCA16())
  stage2RCA.io.a := addaReg(31, 16)
  stage2RCA.io.b := addbReg(31, 16)
  stage2RCA.io.cin := stage1Carry

  val stage2Sum = RegNext(stage2RCA.io.sum)
  val stage2Carry = RegNext(stage2RCA.io.cout)

  val stage3RCA = Module(new RCA16())
  stage3RCA.io.a := addaReg(47, 32)
  stage3RCA.io.b := addbReg(47, 32)
  stage3RCA.io.cin := stage2Carry

  val stage3Sum = RegNext(stage3RCA.io.sum)
  val stage3Carry = RegNext(stage3RCA.io.cout)

  val stage4RCA = Module(new RCA16())
  stage4RCA.io.a := addaReg(63, 48)
  stage4RCA.io.b := addbReg(63, 48)
  stage4RCA.io.cin := stage3Carry

  val stage4Sum = RegNext(stage4RCA.io.sum)
  val finalCarry = RegNext(stage4RCA.io.cout)

  // Task 4: Result Aggregation Logic
  val resultReg = RegNext(Cat(finalCarry, stage4Sum, stage3Sum, stage2Sum, stage1Sum))

  // Task 5: Output Enable Generation
  io.o_en := enPipeline(3)
  io.result := resultReg
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
