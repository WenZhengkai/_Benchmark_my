import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en  = Input(Bool())
    val adda  = Input(UInt(64.W))
    val addb  = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // Task 2: Set up pipeline stage registers
  val stage1_reg = RegInit(0.U(17.W)) // 16 bits plus 1 carry
  val stage2_reg = RegInit(0.U(17.W))
  val stage3_reg = RegInit(0.U(17.W))
  val stage4_reg = RegInit(0.U(17.W))
  val en_piped = RegInit(false.B, init=false.B)

  // Task 3: First stage (least significant 16 bits)
  when(io.i_en) {
    val sum1 = io.adda(15, 0) + io.addb(15, 0)
    stage1_reg := Cat(sum1(16), sum1) // sum1(16) is the carry-out
  }

  // Task 4: Second stage
  val sum2 = Wire(UInt(17.W))
  sum2 := stage1_reg + io.adda(31, 16) + io.addb(31, 16)
  stage2_reg := sum2

  // Task 5: Third stage
  val sum3 = Wire(UInt(17.W))
  sum3 := stage2_reg + io.adda(47, 32) + io.addb(47, 32)
  stage3_reg := sum3

  // Task 6: Fourth stage (most significant bits)
  val sum4 = Wire(UInt(17.W))
  sum4 := stage3_reg + io.adda(63, 48) + io.addb(63, 48)
  stage4_reg := sum4

  // Task 7: Update output enable
  en_piped := io.i_en

  // Task 8: Connect outputs
  io.result := Cat(stage4_reg(16), stage4_reg(15, 0), stage3_reg(15, 0), stage2_reg(15, 0), stage1_reg(15, 0))
  io.o_en := en_piped
}

