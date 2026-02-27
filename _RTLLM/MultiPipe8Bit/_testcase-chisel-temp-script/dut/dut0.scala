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

  // Pipeline registers for enable signal (5-stage pipeline)
  val mul_en_out_reg = RegInit(VecInit(Seq.fill(5)(false.B)))
  
  // Shift the enable signal through the pipeline
  mul_en_out_reg(0) := io.mul_en_in
  for (i <- 1 until 5) {
    mul_en_out_reg(i) := mul_en_out_reg(i-1)
  }
  
  // Output enable signal is the last stage of the pipeline
  io.mul_en_out := mul_en_out_reg(4)

  // Input registers
  val mul_a_reg = RegEnable(io.mul_a, 0.U(8.W), io.mul_en_in)
  val mul_b_reg = RegEnable(io.mul_b, 0.U(8.W), io.mul_en_in)

  // Generate partial products based on multiplier bits
  val partial_products = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    // When the corresponding bit of multiplier is 1, take the shifted multiplicand, otherwise 0
    partial_products(i) := Mux(mul_b_reg(i), (mul_a_reg << i).asUInt, 0.U)
  }

  // Pipeline stage 1: Sum first group of partial products
  val sum1 = RegNext(partial_products(0) + partial_products(1))
  val sum2 = RegNext(partial_products(2) + partial_products(3))
  val sum3 = RegNext(partial_products(4) + partial_products(5))
  val sum4 = RegNext(partial_products(6) + partial_products(7))

  // Pipeline stage 2: Sum second group of partial products
  val sum5 = RegNext(sum1 + sum2)
  val sum6 = RegNext(sum3 + sum4)

  // Pipeline stage 3: Final sum
  val mul_out_reg = RegNext(sum5 + sum6)

  // Output product based on enable signal
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}
