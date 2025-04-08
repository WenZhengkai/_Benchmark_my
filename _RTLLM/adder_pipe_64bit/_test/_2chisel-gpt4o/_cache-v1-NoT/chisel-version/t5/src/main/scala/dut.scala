import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())
    val adda   = Input(UInt(64.W))
    val addb   = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // Task 2: Initialize pipeline stage registers
  val stage1_reg = RegInit(0.U(17.W))
  val stage2_reg = RegInit(0.U(17.W))
  val stage3_reg = RegInit(0.U(17.W))
  val stage4_reg = RegInit(0.U(17.W))

  val en_stage1 = RegInit(false.B)
  val en_stage2 = RegInit(false.B)
  val en_stage3 = RegInit(false.B)
  val en_stage4 = RegInit(false.B)

  // Task 3: First stage - least significant 16 bits
  when(io.i_en) {
    val (sum1, carry1_out) = (io.adda(15, 0) +& io.addb(15, 0)).asTypeOf(UInt(17.W))
    stage1_reg := Cat(carry1_out, sum1(15, 0))
    en_stage1 := true.B
  } .otherwise {
    en_stage1 := false.B
  }

  // Task 4: Second stage - next 16 bits with carry from stage 1
  when(en_stage1) {
    val (sum2, carry2_out) = (io.adda(31, 16) +& io.addb(31, 16) +& stage1_reg(16)).asTypeOf(UInt(17.W))
    stage2_reg := Cat(carry2_out, sum2(15, 0))
    en_stage2 := true.B
  } .otherwise {
    en_stage2 := false.B
  }

  // Task 5: Third stage - next 16 bits with carry from stage 2
  when(en_stage2) {
    val (sum3, carry3_out) = (io.adda(47, 32) +& io.addb(47, 32) +& stage2_reg(16)).asTypeOf(UInt(17.W))
    stage3_reg := Cat(carry3_out, sum3(15, 0))
    en_stage3 := true.B
  } .otherwise {
    en_stage3 := false.B
  }

  // Task 6: Fourth stage - most significant 16 bits with carry from stage 3
  when(en_stage3) {
    val (sum4, carry4_out) = (io.adda(63, 48) +& io.addb(63, 48) +& stage3_reg(16)).asTypeOf(UInt(17.W))
    stage4_reg := Cat(carry4_out, sum4(15, 0))
    en_stage4 := true.B
  } .otherwise {
    en_stage4 := false.B
  }

  // Task 7: Update output enable signal
  io.o_en := en_stage4

  // Task 8: Connect to output ports
  io.result := Cat(stage4_reg(16), stage4_reg(15, 0), stage3_reg(15, 0), stage2_reg(15, 0), stage1_reg(15, 0))
}

