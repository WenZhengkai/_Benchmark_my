// package multiplier

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
  
  // Pipeline registers for input enable signal
  val mul_en_out_reg = RegInit(VecInit(Seq.fill(5)(false.B)))
  
  // Input registers for operands
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  
  // Update input registers when input enable signal is active
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }
  
  // Shift enable signal through pipeline registers
  mul_en_out_reg(0) := io.mul_en_in
  for (i <- 1 until 5) {
    mul_en_out_reg(i) := mul_en_out_reg(i-1)
  }
  
  // Generate partial products
  val temp = Wire(Vec(8, UInt(8.W)))
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg, 0.U)
  }
  
  // First stage: Compute partial sums from partial products
  val sum1 = RegInit(0.U(10.W))
  val sum2 = RegInit(0.U(10.W))
  val sum3 = RegInit(0.U(10.W))
  val sum4 = RegInit(0.U(10.W))
  
  sum1 := temp(0) + (temp(1) << 1)
  sum2 := (temp(2) << 2) + (temp(3) << 3)
  sum3 := (temp(4) << 4) + (temp(5) << 5)
  sum4 := (temp(6) << 6) + (temp(7) << 7)
  
  // Second stage: Combine partial sums
  val sum_a = RegInit(0.U(12.W))
  val sum_b = RegInit(0.U(12.W))
  
  sum_a := sum1 + sum2
  sum_b := sum3 + sum4
  
  // Final stage: Compute the final product
  val mul_out_reg = RegInit(0.U(16.W))
  mul_out_reg := sum_a + sum_b
  
  // Connect output ports
  io.mul_en_out := mul_en_out_reg(4)
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}
