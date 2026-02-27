import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Input ports
    val mul_en_in = Input(Bool())
    val mul_a     = Input(UInt(8.W))
    val mul_b     = Input(UInt(8.W))
    
    // Output ports
    val mul_en_out = Output(Bool())
    val mul_out    = Output(UInt(16.W))
  })

  // Pipeline registers for enable signal
  val mul_en_out_reg = RegInit(0.U(2.W))
  when(reset.asBool === 1.B) {
    mul_en_out_reg := 0.U
  }.otherwise {
    mul_en_out_reg := Cat(mul_en_out_reg(0), io.mul_en_in)
  }
  io.mul_en_out := mul_en_out_reg(1)

  // Input registers (Stage 1)
  val mul_a_reg = RegEnable(io.mul_a, 0.U(8.W), io.mul_en_in)
  val mul_b_reg = RegEnable(io.mul_b, 0.U(8.W), io.mul_en_in)
  val stage1_en = RegNext(io.mul_en_in, false.B)

  // Partial product generation (Stage 2)
  val partial_products = Wire(Vec(8, UInt(9.W)))
  for (i <- 0 until 8) {
    partial_products(i) := Mux(mul_b_reg(i), Cat(0.U(1.W), mul_a_reg) << i, 0.U(9.W))
  }
  val stage2_en = RegNext(stage1_en, false.B)

  // First level of addition (Stage 3)
  val sum0 = RegEnable(partial_products(0) + partial_products(1), 0.U(10.W), stage1_en)
  val sum1 = RegEnable(partial_products(2) + partial_products(3), 0.U(10.W), stage1_en)
  val sum2 = RegEnable(partial_products(4) + partial_products(5), 0.U(10.W), stage1_en)
  val sum3 = RegEnable(partial_products(6) + partial_products(7), 0.U(10.W), stage1_en)
  val stage3_en = RegNext(stage2_en, false.B)

  // Second level of addition (Stage 4)
  val sum4 = RegEnable(sum0 + sum1, 0.U(11.W), stage2_en)
  val sum5 = RegEnable(sum2 + sum3, 0.U(11.W), stage2_en)
  val stage4_en = RegNext(stage3_en, false.B)

  // Final addition (Stage 5)
  val mul_out_reg = RegEnable(sum4 + sum5, 0.U(16.W), stage3_en)
  val stage5_en = RegNext(stage4_en, false.B)

  // Output assignment
  io.mul_out := Mux(stage5_en, mul_out_reg, 0.U(16.W))
}