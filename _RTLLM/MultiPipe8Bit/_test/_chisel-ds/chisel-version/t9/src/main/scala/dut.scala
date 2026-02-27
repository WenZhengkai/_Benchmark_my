import chisel3._
import chisel3.util._

class PipelinedMultiplier extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool()) // Input enable signal
    val mul_a     = Input(UInt(8.W)) // 8-bit multiplicand
    val mul_b     = Input(UInt(8.W)) // 8-bit multiplier
    val mul_en_out = Output(Bool()) // Output enable signal
    val mul_out   = Output(UInt(16.W)) // 16-bit product output
  })

  // Pipeline registers
  val mul_en_out_reg = RegInit(VecInit(Seq.fill(5)(false.B))) // 5-stage pipeline for enable signal
  val mul_a_reg = RegInit(0.U(8.W)) // Register for multiplicand
  val mul_b_reg = RegInit(0.U(8.W)) // Register for multiplier
  val partial_sums = RegInit(VecInit(Seq.fill(4)(0.U(16.W)))) // Registers for partial sums
  val mul_out_reg = RegInit(0.U(16.W)) // Register for final product

  // Input Control
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Pipeline the enable signal
  mul_en_out_reg(0) := io.mul_en_in
  for (i <- 1 until 5) {
    mul_en_out_reg(i) := mul_en_out_reg(i - 1)
  }

  // Partial Product Generation
  val partial_products = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    partial_products(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U)
  }

  // Partial Sum Calculation (4 stages)
  partial_sums(0) := partial_products(0) + partial_products(1)
  partial_sums(1) := partial_products(2) + partial_products(3)
  partial_sums(2) := partial_products(4) + partial_products(5)
  partial_sums(3) := partial_products(6) + partial_products(7)

  // Final Product Calculation
  mul_out_reg := partial_sums(0) + partial_sums(1) + partial_sums(2) + partial_sums(3)

  // Output Assignment
  io.mul_en_out := mul_en_out_reg(4)
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}

// Generate Verilog
/*
object PipelinedMultiplier extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new PipelinedMultiplier)
}
*/
