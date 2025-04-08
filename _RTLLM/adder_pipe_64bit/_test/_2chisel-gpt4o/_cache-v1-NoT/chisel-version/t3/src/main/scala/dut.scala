import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en    = Input(Bool())
    val adda    = Input(UInt(64.W))
    val addb    = Input(UInt(64.W))
    val result  = Output(UInt(65.W))
    val o_en    = Output(Bool())
  })

  // Task 2: Pipeline stage registers
  // Register to synchronize input enable signal
  val enReg1 = RegInit(false.B)
  val enReg2 = RegInit(false.B)
  val enReg3 = RegInit(false.B)
  val enReg4 = RegInit(false.B)

  // Registers for partial sums and carry-out
  val sumStage1 = RegInit(0.U(17.W))
  val sumStage2 = RegInit(0.U(17.W))
  val sumStage3 = RegInit(0.U(17.W))
  val sumStage4 = RegInit(0.U(17.W))

  // Task 3: First stage of the pipeline (least significant 16 bits)
  when (io.i_en) {
    val addLsb = io.adda(15, 0) +& io.addb(15, 0)
    sumStage1 := addLsb
    enReg1 := io.i_en
  } .otherwise {
    enReg1 := false.B
  }

  // Task 4: Second stage of the pipeline
  when (enReg1) {
    val addNext = io.adda(31, 16) +& io.addb(31, 16) + sumStage1(16)
    sumStage2 := addNext
    enReg2 := enReg1
  } .otherwise {
    enReg2 := false.B
  }

  // Task 5: Third stage of the pipeline
  when (enReg2) {
    val addNext = io.adda(47, 32) +& io.addb(47, 32) + sumStage2(16)
    sumStage3 := addNext
    enReg3 := enReg2
  } .otherwise {
    enReg3 := false.B
  }

  // Task 6: Fourth stage of the pipeline (most significant bits)
  when (enReg3) {
    val addMsb = io.adda(63, 48) +& io.addb(63, 48) + sumStage3(16)
    sumStage4 := addMsb
    enReg4 := enReg3
  } .otherwise {
    enReg4 := false.B
  }

  // Task 7 & 8: Output result and enable signal
  io.result := Cat(sumStage4(16), sumStage4(15, 0), sumStage3(15, 0), sumStage2(15, 0), sumStage1(15, 0))
  io.o_en := enReg4
}

