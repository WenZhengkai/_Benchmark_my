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
  
  // Shift enable signal through the pipeline
  mul_en_out_reg(0) := io.mul_en_in
  for (i <- 1 until 5) {
    mul_en_out_reg(i) := mul_en_out_reg(i-1)
  }
  
  // Connect output enable signal to the last stage register
  io.mul_en_out := mul_en_out_reg(4)

  // Input registers
  val mul_a_reg = RegEnable(io.mul_a, 0.U(8.W), io.mul_en_in)
  val mul_b_reg = RegEnable(io.mul_b, 0.U(8.W), io.mul_en_in)

  // Stage 1: Generate partial products
  val partial_products = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    when (mul_b_reg(i)) {
      partial_products(i) := (mul_a_reg << i).pad(16)
    } .otherwise {
      partial_products(i) := 0.U(16.W)
    }
  }

  // Stage 2: First level reduction (from 8 to 4 partial products)
  val sum_level1 = Reg(Vec(4, UInt(16.W)))
  sum_level1(0) := partial_products(0) + partial_products(1)
  sum_level1(1) := partial_products(2) + partial_products(3)
  sum_level1(2) := partial_products(4) + partial_products(5)
  sum_level1(3) := partial_products(6) + partial_products(7)

  // Stage 3: Second level reduction (from 4 to 2 partial products)
  val sum_level2 = Reg(Vec(2, UInt(16.W)))
  sum_level2(0) := sum_level1(0) + sum_level1(1)
  sum_level2(1) := sum_level1(2) + sum_level1(3)

  // Stage 4: Final sum
  val mul_out_reg = RegNext(sum_level2(0) + sum_level2(1), 0.U(16.W))

  // Connect output
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W))
}
