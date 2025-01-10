import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool())
    val mul_a = Input(UInt(8.W))
    val mul_b = Input(UInt(8.W))
    val mul_en_out = Output(Bool())
    val mul_out = Output(UInt(16.W))
  })

  // Enable and input registers
  val mul_en_out_reg = RegInit(0.U(1.W))
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))

  when(io.mul_en_in) {
    mul_en_out_reg := 1.U  // Enabled signal when input is enabled
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }.otherwise {
    mul_en_out_reg := 0.U  // Disabled when input is not enabled
  }

  // Define partial product wires
  val partialProducts = Wire(Vec(8, UInt(16.W)))

  for (i <- 0 until 8) {
    partialProducts(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U(16.W))
  }

  // Partial sums calculation
  val sum = Wire(Vec(4, UInt(16.W)))

  sum(0) := partialProducts(0) + partialProducts(1)
  sum(1) := partialProducts(2) + partialProducts(3)
  sum(2) := partialProducts(4) + partialProducts(5)
  sum(3) := partialProducts(6) + partialProducts(7)

  // Second level of summation
  val sum2 = Wire(Vec(2, UInt(16.W)))

  sum2(0) := sum(0) + sum(1)
  sum2(1) := sum(2) + sum(3)

  // Final product calculation
  val mul_out_reg = RegInit(0.U(16.W))

  mul_out_reg := sum2(0) + sum2(1)

  // Output assignment
  io.mul_en_out := mul_en_out_reg
  io.mul_out := Mux(mul_en_out_reg === 1.U, mul_out_reg, 0.U)
}


