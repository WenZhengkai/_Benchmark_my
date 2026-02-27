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

  // Pipeline registers for enable signal (shift register style)
  val mul_en_out_reg = RegInit(VecInit(Seq.fill(5)(false.B)))
  
  // Input registers (Stage 0)
  val mul_a_reg = RegEnable(io.mul_a, 0.U, io.mul_en_in)
  val mul_b_reg = RegEnable(io.mul_b, 0.U, io.mul_en_in)
  
  // Partial product generation (Stage 1)
  val partial_products = Wire(Vec(8, UInt(9.W)))
  for (i <- 0 until 8) {
    partial_products(i) := Mux(mul_b_reg(i), mul_a_reg, 0.U) << i
  }
  
  // First level of addition (Stage 2)
  val sum_stage1_0 = RegNext(partial_products(0) +& partial_products(1))
  val sum_stage1_1 = RegNext(partial_products(2) +& partial_products(3))
  val sum_stage1_2 = RegNext(partial_products(4) +& partial_products(5))
  val sum_stage1_3 = RegNext(partial_products(6) +& partial_products(7))
  
  // Second level of addition (Stage 3)
  val sum_stage2_0 = RegNext(sum_stage1_0 +& sum_stage1_1)
  val sum_stage2_1 = RegNext(sum_stage1_2 +& sum_stage1_3)
  
  // Final addition (Stage 4)
  val mul_out_reg = RegNext(sum_stage2_0 +& sum_stage2_1)
  
  // Pipeline the enable signal through all stages
  when(reset.asBool || !io.mul_en_in) {
    mul_en_out_reg.foreach(_ := false.B)
  }.otherwise {
    mul_en_out_reg(0) := io.mul_en_in
    for (i <- 1 until 5) {
      mul_en_out_reg(i) := mul_en_out_reg(i-1)
    }
  }
  
  // Output assignments
  io.mul_en_out := mul_en_out_reg(4) // Enable signal after all pipeline stages
  io.mul_out    := Mux(io.mul_en_out, mul_out_reg, 0.U)
}
