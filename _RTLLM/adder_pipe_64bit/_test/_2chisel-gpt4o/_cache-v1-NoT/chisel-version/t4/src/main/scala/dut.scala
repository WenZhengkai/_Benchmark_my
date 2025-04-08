import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Task 2: Set up basic infrastructure for pipeline stages
  val enReg1 = RegInit(false.B)
  val enReg2 = RegInit(false.B)
  val enReg3 = RegInit(false.B)
  val enReg4 = RegInit(false.B)

  val sumReg1 = Reg(UInt(17.W))
  val sumReg2 = Reg(UInt(17.W))
  val sumReg3 = Reg(UInt(17.W))
  val sumReg4 = Reg(UInt(17.W))

  // Task 3: Implement the first stage of the pipeline (LSB 16 bits)
  when(io.i_en) {
    val addResStage1 = io.adda(15, 0) +& io.addb(15, 0)
    sumReg1 := addResStage1
  }
  enReg1 := io.i_en

  // Task 4: Implement the second stage of the pipeline (Next 16 bits)
  when(enReg1) {
    val addResStage2 = io.adda(31, 16) +& io.addb(31, 16) +& sumReg1(16)
    sumReg2 := addResStage2
  }
  enReg2 := enReg1

  // Task 5: Implement the third stage of the pipeline (Third 16 bits)
  when(enReg2) {
    val addResStage3 = io.adda(47, 32) +& io.addb(47, 32) +& sumReg2(16)
    sumReg3 := addResStage3
  }
  enReg3 := enReg2

  // Task 6: Implement the fourth stage of the pipeline (MSB 16 bits)
  when(enReg3) {
    val addResStage4 = io.adda(63, 48) +& io.addb(63, 48) +& sumReg3(16)
    sumReg4 := addResStage4
  }
  enReg4 := enReg3

  // Task 7: Update the output enable signal (o_en)
  io.o_en := enReg4

  // Task 8: Connect the final pipeline outputs to the module's output ports
  io.result := Cat(sumReg4(16), sumReg4(15, 0), sumReg3(15, 0), sumReg2(15, 0), sumReg1(15, 0))
}

