import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Input ports
    val mul_en_in = Input(Bool())
    val mul_a = Input(UInt(8.W))
    val mul_b = Input(UInt(8.W))
    
    // Output ports
    val mul_en_out = Output(Bool())
    val mul_out = Output(UInt(16.W))
  })
  
  // Pipeline registers for enable signal (5 stages)
  val mul_en_out_reg = RegInit(VecInit(Seq.fill(5)(false.B)))
  
  // Shift the enable signal through the pipeline
  mul_en_out_reg(0) := io.mul_en_in
  for (i <- 1 until 5) {
    mul_en_out_reg(i) := mul_en_out_reg(i-1)
  }
  
  // The output enable signal is the last stage of the pipeline
  io.mul_en_out := mul_en_out_reg(4)
  
  // Input registers for operands
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  
  // Update input registers when enabled
  when (io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }
  
  // Generate partial products
  val pp = Wire(Vec(8, UInt(8.W)))
  for (i <- 0 until 8) {
    pp(i) := Mux(mul_b_reg(i), mul_a_reg, 0.U) << i.U
  }
  
  // Stage 1: Combine partial products into 4 intermediate sums
  val sum1_reg = RegInit(VecInit(Seq.fill(4)(0.U(16.W))))
  when (mul_en_out_reg(0)) {
    sum1_reg(0) := pp(0) +& pp(1)
    sum1_reg(1) := pp(2) +& pp(3)
    sum1_reg(2) := pp(4) +& pp(5)
    sum1_reg(3) := pp(6) +& pp(7)
  }
  
  // Stage 2: Combine the 4 intermediate sums into 2
  val sum2_reg = RegInit(VecInit(Seq.fill(2)(0.U(16.W))))
  when (mul_en_out_reg(1)) {
    sum2_reg(0) := sum1_reg(0) +& sum1_reg(1)
    sum2_reg(1) := sum1_reg(2) +& sum1_reg(3)
  }
  
  // Stage 3: Final addition to get the product
  val mul_out_reg = RegInit(0.U(16.W))
  when (mul_en_out_reg(2)) {
    mul_out_reg := sum2_reg(0) +& sum2_reg(1)
  }
  
  // Assign output product
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}
