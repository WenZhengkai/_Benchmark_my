
import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W)) // 64 bits for sum and 1 bit for carry
    val o_en = Output(Bool())
  })

  // Pipeline registers for inputs, carries and sum parts
  val stage1_a = RegInit(0.U(16.W))
  val stage1_b = RegInit(0.U(16.W))
  val stage1_carry = RegInit(0.U(1.W))

  val stage2_a = RegInit(0.U(16.W))
  val stage2_b = RegInit(0.U(16.W))
  val stage2_carry = RegInit(0.U(1.W))

  val stage3_a = RegInit(0.U(16.W))
  val stage3_b = RegInit(0.U(16.W))
  val stage3_carry = RegInit(0.U(1.W))

  val stage4_a = RegInit(0.U(16.W))
  val stage4_b = RegInit(0.U(16.W))
  val stage4_carry = RegInit(0.U(1.W))

  val stage1_sum = Wire(UInt(17.W))
  val stage2_sum = Wire(UInt(17.W))
  val stage3_sum = Wire(UInt(17.W))
  val stage4_sum = Wire(UInt(17.W))

  // Pipeline registers for synchronizing i_en signal
  val en_r1 = RegNext(io.i_en)
  val en_r2 = RegNext(en_r1)
  val en_r3 = RegNext(en_r2)
  val en_r4 = RegNext(en_r3)

  // Stage 1
  when(io.i_en) {
    stage1_a := io.adda(15, 0)
    stage1_b := io.addb(15, 0)
    stage1_carry := 0.U // Initial carry is 0
  }

  stage1_sum := stage1_a + stage1_b + stage1_carry

  // Stage 2
  when(en_r1) {
    stage2_a := io.adda(31, 16)
    stage2_b := io.addb(31, 16)
    stage2_carry := stage1_sum(16) // Carry out from stage 1
  }

  stage2_sum := stage2_a + stage2_b + stage2_carry

  // Stage 3
  when(en_r2) {
    stage3_a := io.adda(47, 32)
    stage3_b := io.addb(47, 32)
    stage3_carry := stage2_sum(16) // Carry out from stage 2
  }

  stage3_sum := stage3_a + stage3_b + stage3_carry

  // Stage 4
  when(en_r3) {
    stage4_a := io.adda(63, 48)
    stage4_b := io.addb(63, 48)
    stage4_carry := stage3_sum(16) // Carry out from stage 3
  }

  stage4_sum := stage4_a + stage4_b + stage4_carry

  // Output the result
  io.result := Cat(stage4_sum(16), stage4_sum(15, 0), stage3_sum(15, 0), stage2_sum(15, 0), stage1_sum(15, 0))
  io.o_en := en_r4 // Output enable after the last stage
}

