import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())         // Enable signal for addition operation
    val adda = Input(UInt(64.W))     // 64-bit input operand A
    val addb = Input(UInt(64.W))     // 64-bit input operand B
    val result = Output(UInt(65.W))  // 65-bit output representing the sum of adda and addb
    val o_en = Output(Bool())        // Output enable signal
  })

  // Pipeline registers
  val stage1_en = RegInit(false.B)
  val stage2_en = RegInit(false.B)
  val stage3_en = RegInit(false.B)
  val stage4_en = RegInit(false.B)

  val stage1_a = RegInit(0.U(16.W))
  val stage1_b = RegInit(0.U(16.W))
  val stage1_carry = RegInit(false.B)

  val stage2_a = RegInit(0.U(16.W))
  val stage2_b = RegInit(0.U(16.W))
  val stage2_carry = RegInit(false.B)

  val stage3_a = RegInit(0.U(16.W))
  val stage3_b = RegInit(0.U(16.W))
  val stage3_carry = RegInit(false.B)

  val stage4_a = RegInit(0.U(16.W))
  val stage4_b = RegInit(0.U(16.W))
  val stage4_carry = RegInit(false.B)

  // Pipeline stages
  when(io.i_en) {
    // Stage 1: Operands A[15:0] and B[15:0]
    stage1_en := true.B
    stage1_a := io.adda(15, 0)
    stage1_b := io.addb(15, 0)
    stage1_carry := false.B
  }.otherwise {
    stage1_en := false.B
  }

  when(stage1_en) {
    // Stage 2: Operands A[31:16] and B[31:16]
    stage2_en := true.B
    stage2_a := io.adda(31, 16)
    stage2_b := io.addb(31, 16)
    stage2_carry := (stage1_a + stage1_b)(16)
  }.otherwise {
    stage2_en := false.B
  }

  when(stage2_en) {
    // Stage 3: Operands A[47:32] and B[47:32]
    stage3_en := true.B
    stage3_a := io.adda(47, 32)
    stage3_b := io.addb(47, 32)
    stage3_carry := (stage2_a + stage2_b + stage2_carry)(16)
  }.otherwise {
    stage3_en := false.B
  }

  when(stage3_en) {
    // Stage 4: Operands A[63:48] and B[63:48]
    stage4_en := true.B
    stage4_a := io.adda(63, 48)
    stage4_b := io.addb(63, 48)
    stage4_carry := (stage3_a + stage3_b + stage3_carry)(16)
  }.otherwise {
    stage4_en := false.B
  }

  // Calculate the final result
  val sum1 = stage1_a + stage1_b
  val sum2 = stage2_a + stage2_b + stage2_carry
  val sum3 = stage3_a + stage3_b + stage3_carry
  val sum4 = stage4_a + stage4_b + stage4_carry

  val result = Cat(sum4(15, 0), sum3(15, 0), sum2(15, 0), sum1(15, 0))

  // Output the result and enable signal
  io.result := result
  io.o_en := stage4_en
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
