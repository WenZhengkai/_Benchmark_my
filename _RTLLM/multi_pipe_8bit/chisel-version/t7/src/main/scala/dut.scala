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

  // Registers to store inputs
  val mul_en_reg = RegInit(false.B)
  val mul_a_reg = Reg(UInt(8.W))
  val mul_b_reg = Reg(UInt(8.W))

  // Register to store the result
  val mul_out_reg = RegInit(0.U(16.W))

  // Store the enable signal, multiplying inputs only when enabled
  when(io.mul_en_in) {
    mul_en_reg := true.B
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }.otherwise {
    mul_en_reg := false.B
  }

  // For partial product generation (using a Vec for temp storage)
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U(16.W))
  }

  // Sequential addition to calculate final product
  val partial_sum_reg = Reg(Vec(8, UInt(16.W)))
  partial_sum_reg(0) := temp(0)

  for (i <- 1 until 8) {
    partial_sum_reg(i) := partial_sum_reg(i - 1) + temp(i)
  }

  // Assign the final result to the output registers
  when(mul_en_reg) {
    mul_out_reg := partial_sum_reg(7)
  }

  // Output assignments
  io.mul_en_out := mul_en_reg
  io.mul_out := Mux(mul_en_reg, mul_out_reg, 0.U)
}

