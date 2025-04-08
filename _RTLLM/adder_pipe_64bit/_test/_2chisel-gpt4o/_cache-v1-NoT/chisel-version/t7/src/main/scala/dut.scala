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

  // Pipeline registers for each stage
  val stage1Sum = RegInit(0.U(17.W))
  val stage2Sum = RegInit(0.U(17.W))
  val stage3Sum = RegInit(0.U(17.W))
  val stage4Sum = RegInit(0.U(16.W))

  // Enable registers for each stage
  val stage1En = RegInit(false.B)
  val stage2En = RegInit(false.B)
  val stage3En = RegInit(false.B)
  val stage4En = RegInit(false.B)

  // Perform the first stage of the pipeline
  when(io.i_en) {
    val (sum1, carry1) = (io.adda(15, 0) +& io.addb(15, 0)).asUInt
    stage1Sum := Cat(carry1, sum1)
    stage1En := io.i_en
  }.otherwise {
    stage1En := false.B
  }

  // Perform the second stage of the pipeline
  when(stage1En) {
    val (sum2, carry2) = (io.adda(31, 16) +& io.addb(31, 16) + stage1Sum(16)).asUInt
    stage2Sum := Cat(carry2, sum2)
    stage2En := stage1En
  }.otherwise {
    stage2En := false.B
  }

  // Perform the third stage of the pipeline
  when(stage2En) {
    val (sum3, carry3) = (io.adda(47, 32) +& io.addb(47, 32) + stage2Sum(16)).asUInt
    stage3Sum := Cat(carry3, sum3)
    stage3En := stage2En
  }.otherwise {
    stage3En := false.B
  }

  // Perform the fourth stage of the pipeline
  when(stage3En) {
    val (sum4, carry4) = (io.adda(63, 48) +& io.addb(63, 48) + stage3Sum(16)).asUInt
    stage4Sum := sum4
    stage4En := stage3En
  }.otherwise {
    stage4En := false.B
  }

  // Output the result and the enable signal
  io.result := Cat(stage4Sum, stage3Sum(15,0), stage2Sum(15,0), stage1Sum(15,0))
  io.o_en := stage4En
}

