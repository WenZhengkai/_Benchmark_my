// package mult

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
  
  // Pipeline registers for enable signal
  val mul_en_out_reg = RegInit(0.U(5.W))
  
  // Register the enable signal through the pipeline
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)
  
  // Connect output enable to the MSB of the enable register
  io.mul_en_out := mul_en_out_reg(4)
  
  // Input registers
  val mul_a_reg = RegEnable(io.mul_a, 0.U(8.W), io.mul_en_in)
  val mul_b_reg = RegEnable(io.mul_b, 0.U(8.W), io.mul_en_in)
  
  // Generate partial products
  val temp = Wire(Vec(8, UInt(8.W)))
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg, 0.U)
  }
  
  // Pipeline stage 1: calculate partial sums for first 4 partial products
  val sum_1 = RegInit(0.U(16.W))
  when(mul_en_out_reg(0)) {
    sum_1 := temp(0) +
             (temp(1) << 1) +
             (temp(2) << 2) +
             (temp(3) << 3)
  }
  
  // Pipeline stage 2: calculate partial sums for last 4 partial products
  val sum_2 = RegInit(0.U(16.W))
  when(mul_en_out_reg(1)) {
    sum_2 := (temp(4) << 4) +
             (temp(5) << 5) +
             (temp(6) << 6) +
             (temp(7) << 7)
  }
  
  // Pipeline stage 3: sum up all partial sums
  val mul_out_reg = RegInit(0.U(16.W))
  when(mul_en_out_reg(2)) {
    mul_out_reg := sum_1 + sum_2
  }
  
  // Output assignment
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}
