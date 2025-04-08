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

  // Ripple Carry Logic using Chisel for-loop
  val sumWithCarry = Wire(Vec(16, Bool()))
  val carry = Wire(Vec(17, Bool()))

  carry(0) := io.cin // Initial carry is the input carry

  for (i <- 0 until 16) {
    val fullAdderSum = io.a(i) ^ io.b(i) ^ carry(i)
    val fullAdderCarry = (io.a(i) & io.b(i)) | (carry(i) & (io.a(i) ^ io.b(i)))

    sumWithCarry(i) := fullAdderSum
    carry(i + 1) := fullAdderCarry
  }

  io.sum := sumWithCarry.asUInt
  io.cout := carry(16)
}

class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())
    val adda   = Input(UInt(64.W))
    val addb   = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // --------------------------------------------
  // Task 1: Input Registering and Enable Pipeline
  // --------------------------------------------
  // Input operand registers
  val addaReg = RegEnable(io.adda, 0.U, io.i_en)
  val addbReg = RegEnable(io.addb, 0.U, io.i_en)

  // Enable pipeline: 4-stage shift register
  val enPipeline = RegInit(VecInit(Seq.fill(4)(false.B)))
  when(io.i_en) {
    enPipeline(0) := true.B
  }.otherwise {
    enPipeline(0) := false.B
  }

  for (i <- 1 until 4) {
    enPipeline(i) := enPipeline(i - 1)
  }

  // --------------------------------------------
  // Task 2: Ripple Carry Adder (RCA16) Module
  // --------------------------------------------
  val rca16_1 = Module(new RCA16())
  val rca16_2 = Module(new RCA16())
  val rca16_3 = Module(new RCA16())
  val rca16_4 = Module(new RCA16())

  // --------------------------------------------
  // Task 3: Pipeline Stage Implementation
  // --------------------------------------------
  // Stage 1: Lower 16 bits
  rca16_1.io.a := addaReg(15, 0)
  rca16_1.io.b := addbReg(15, 0)
  rca16_1.io.cin := false.B

  val sumStage1 = RegNext(rca16_1.io.sum)
  val carryStage1 = RegNext(rca16_1.io.cout)
  val enStage1 = RegNext(enPipeline(0))

  // Stage 2: Bits 16-31
  rca16_2.io.a := addaReg(31, 16)
  rca16_2.io.b := addbReg(31, 16)
  rca16_2.io.cin := carryStage1

  val sumStage2 = RegNext(rca16_2.io.sum)
  val carryStage2 = RegNext(rca16_2.io.cout)
  val enStage2 = RegNext(enStage1)

  // Stage 3: Bits 32-47
  rca16_3.io.a := addaReg(47, 32)
  rca16_3.io.b := addbReg(47, 32)
  rca16_3.io.cin := carryStage2

  val sumStage3 = RegNext(rca16_3.io.sum)
  val carryStage3 = RegNext(rca16_3.io.cout)
  val enStage3 = RegNext(enStage2)

  // Stage 4: Upper 16 bits
  rca16_4.io.a := addaReg(63, 48)
  rca16_4.io.b := addbReg(63, 48)
  rca16_4.io.cin := carryStage3

  val sumStage4 = RegNext(rca16_4.io.sum)
  val carryStage4 = RegNext(rca16_4.io.cout)
  val enStage4 = RegNext(enStage3)

  // --------------------------------------------
  // Task 4: Result Aggregation Logic
  // --------------------------------------------
  val resultReg = RegNext(Cat(carryStage4, sumStage4, sumStage3, sumStage2, sumStage1))

  io.result := resultReg

  // --------------------------------------------
  // Task 5: Output Enable Generation
  // --------------------------------------------
  io.o_en := enPipeline(3)
}


