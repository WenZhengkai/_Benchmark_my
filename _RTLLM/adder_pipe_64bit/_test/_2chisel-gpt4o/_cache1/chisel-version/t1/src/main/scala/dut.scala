
import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en  = Input(Bool())
    val adda  = Input(UInt(64.W))
    val addb  = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en  = Output(Bool())
  })

  // Pipeline registers
  val stage0_sum = RegInit(0.U(17.W))
  val stage1_sum = RegInit(0.U(17.W))
  val stage2_sum = RegInit(0.U(17.W))
  val stage3_sum = RegInit(0.U(17.W))
  
  val stage0_en = RegInit(false.B)
  val stage1_en = RegInit(false.B)
  val stage2_en = RegInit(false.B)
  val stage3_en = RegInit(false.B)
  
  // Combinational adder logic for each stage
  val (sum0, carry0) = (io.adda(15,0) +& io.addb(15,0))
  val (sum1, carry1) = (io.adda(31,16) +& io.addb(31,16) + carry0)
  val (sum2, carry2) = (io.adda(47,32) +& io.addb(47,32) + carry1)
  val (sum3, carry3) = (io.adda(63,48) +& io.addb(63,48) + carry2)
  
  when(io.i_en) {
    // Move data through pipeline stages
    stage0_sum := sum0
    stage0_en := io.i_en

    stage1_sum := sum1
    stage1_en := stage0_en

    stage2_sum := sum2
    stage2_en := stage1_en

    stage3_sum := sum3
    stage3_en := stage2_en
  }

  // Concatenate pipeline outputs with carries
  io.result := Cat(carry3, stage3_sum, stage2_sum(15,0), stage1_sum(15,0), stage0_sum(15,0))
  io.o_en := stage3_en
}
