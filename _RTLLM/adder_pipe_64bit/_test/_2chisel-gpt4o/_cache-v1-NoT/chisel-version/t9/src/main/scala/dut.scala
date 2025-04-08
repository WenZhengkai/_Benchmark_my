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

  // Pipeline registers to hold partial sums and carry-out
  val sumStage1 = RegInit(0.U(17.W))
  val sumStage2 = RegInit(0.U(17.W))
  val sumStage3 = RegInit(0.U(17.W))
  val sumStage4 = RegInit(0.U(17.W))

  // Registers to hold enable signal for each stage
  val enStage1 = RegInit(false.B)
  val enStage2 = RegInit(false.B)
  val enStage3 = RegInit(false.B)
  val enStage4 = RegInit(false.B)

  // Task 3: First stage (least significant 16 bits)
  when(io.i_en) {
    val add16_0 = io.adda(15, 0) +& io.addb(15, 0)
    sumStage1 := add16_0
    enStage1 := io.i_en
  }

  // Task 4: Second stage
  when(enStage1) {
    val add16_1 = io.adda(31, 16) +& io.addb(31, 16) + sumStage1(16)
    sumStage2 := add16_1
    enStage2 := enStage1
  }

  // Task 5: Third stage
  when(enStage2) {
    val add16_2 = io.adda(47, 32) +& io.addb(47, 32) + sumStage2(16)
    sumStage3 := add16_2
    enStage3 := enStage2
  }

  // Task 6: Fourth stage (most significant bits)
  when(enStage3) {
    val add16_3 = io.adda(63, 48) +& io.addb(63, 48) + sumStage3(16)
    sumStage4 := add16_3
    enStage4 := enStage3
  }

  // Task 7: Update the output enable signal
  io.o_en := enStage4

  // Task 8: Connect final outputs
  io.result := Cat(sumStage4(16), sumStage4(15, 0), sumStage3(15, 0), sumStage2(15, 0), sumStage1(15, 0))

}

