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

  // Pipeline registers for the enable signal (5 stages)
  val mul_en_out_reg = RegInit(VecInit(Seq.fill(5)(false.B)))
  
  // Update the pipeline registers for enable signal
  mul_en_out_reg(0) := io.mul_en_in
  for (i <- 0 until 4) {
    mul_en_out_reg(i + 1) := mul_en_out_reg(i)
  }
  
  // Connect output enable to the last stage of the pipeline
  io.mul_en_out := mul_en_out_reg(4)
  
  // Input registers
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }
  
  // Pipeline stage 1: Generate partial products
  val partial_products = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    partial_products(i) := Mux(mul_b_reg(i), (mul_a_reg << i).asUInt, 0.U)
  }
  
  // Pipeline stage 2: First level addition
  val sum1 = RegInit(VecInit(Seq.fill(4)(0.U(16.W))))
  sum1(0) := partial_products(0) + partial_products(1)
  sum1(1) := partial_products(2) + partial_products(3)
  sum1(2) := partial_products(4) + partial_products(5)
  sum1(3) := partial_products(6) + partial_products(7)
  
  // Pipeline stage 3: Second level addition
  val sum2 = RegInit(VecInit(Seq.fill(2)(0.U(16.W))))
  sum2(0) := sum1(0) + sum1(1)
  sum2(1) := sum1(2) + sum1(3)
  
  // Pipeline stage 4: Final addition
  val mul_out_reg = RegInit(0.U(16.W))
  mul_out_reg := sum2(0) + sum2(1)
  
  // Output assignment
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}
