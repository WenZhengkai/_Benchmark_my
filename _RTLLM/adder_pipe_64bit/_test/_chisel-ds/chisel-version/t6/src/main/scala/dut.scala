import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool()) // Enable signal for addition operation
    val adda = Input(UInt(64.W)) // 64-bit input operand A
    val addb = Input(UInt(64.W)) // 64-bit input operand B
    val result = Output(UInt(65.W)) // 65-bit output sum
    val o_en = Output(Bool()) // Output enable signal
  })

  // Pipeline registers
  val stage1_adda = RegInit(0.U(16.W))
  val stage1_addb = RegInit(0.U(16.W))
  val stage1_carry = RegInit(0.U(1.W))
  val stage1_en = RegInit(false.B)

  val stage2_adda = RegInit(0.U(16.W))
  val stage2_addb = RegInit(0.U(16.W))
  val stage2_carry = RegInit(0.U(1.W))
  val stage2_en = RegInit(false.B)

  val stage3_adda = RegInit(0.U(16.W))
  val stage3_addb = RegInit(0.U(16.W))
  val stage3_carry = RegInit(0.U(1.W))
  val stage3_en = RegInit(false.B)

  val stage4_adda = RegInit(0.U(16.W))
  val stage4_addb = RegInit(0.U(16.W))
  val stage4_carry = RegInit(0.U(1.W))
  val stage4_en = RegInit(false.B)

  // Pipeline logic
  when(io.i_en) {
    // Stage 1: Operands A[15:0] and B[15:0]
    stage1_adda := io.adda(15, 0)
    stage1_addb := io.addb(15, 0)
    stage1_carry := 0.U
    stage1_en := true.B

    // Stage 2: Operands A[31:16] and B[31:16]
    stage2_adda := io.adda(31, 16)
    stage2_addb := io.addb(31, 16)
    stage2_carry := (stage1_adda +& stage1_addb)(16)
    stage2_en := stage1_en

    // Stage 3: Operands A[47:32] and B[47:32]
    stage3_adda := io.adda(47, 32)
    stage3_addb := io.addb(47, 32)
    stage3_carry := (stage2_adda +& stage2_addb +& stage2_carry)(16)
    stage3_en := stage2_en

    // Stage 4: Operands A[63:48] and B[63:48]
    stage4_adda := io.adda(63, 48)
    stage4_addb := io.addb(63, 48)
    stage4_carry := (stage3_adda +& stage3_addb +& stage3_carry)(16)
    stage4_en := stage3_en
  }.otherwise {
    // Clear pipeline registers when i_en is low
    stage1_en := false.B
    stage2_en := false.B
    stage3_en := false.B
    stage4_en := false.B
  }

  // Calculate the final result
  val sum1 = stage1_adda + stage1_addb
  val sum2 = stage2_adda + stage2_addb + stage2_carry
  val sum3 = stage3_adda + stage3_addb + stage3_carry
  val sum4 = stage4_adda + stage4_addb + stage4_carry

  // Concatenate the results to form the 65-bit output
  io.result := Cat(sum4(15, 0), sum3(15, 0), sum2(15, 0), sum1(15, 0))

  // Output enable signal
  io.o_en := stage4_en
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
