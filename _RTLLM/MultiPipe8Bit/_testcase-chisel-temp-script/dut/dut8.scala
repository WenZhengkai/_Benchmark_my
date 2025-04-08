import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool())
    val mul_a     = Input(UInt(8.W))
    val mul_b     = Input(UInt(8.W))
    val mul_en_out = Output(Bool())
    val mul_out   = Output(UInt(16.W))
  })

  // Task 1: Input control logic
  val mul_en_out_reg = RegInit(0.U(5.W)) // 5-bit shift register
  when(io.mul_en_in) {
    mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in) // Shift in enable signal
  }
  io.mul_en_out := mul_en_out_reg(4) // MSB of the shift register drives mul_en_out

  // Task 2: Input registers for mul_a and mul_b
  val mul_a_reg = RegInit(0.U(8.W)) // 8-bit register for multiplicand
  val mul_b_reg = RegInit(0.U(8.W)) // 8-bit register for multiplier
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Task 3: Generate partial products
  val temp = Wire(Vec(8, UInt(16.W))) // Array of partial product wires
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U) // Compute partial products
  }

  // Task 4: Partial sums
  val sum_1 = RegInit(0.U(16.W)) // Intermediate sum 1
  val sum_2 = RegInit(0.U(16.W)) // Intermediate sum 2
  val sum_3 = RegInit(0.U(16.W)) // Intermediate sum 3
  val sum_4 = RegInit(0.U(16.W)) // Intermediate sum 4

  when(io.mul_en_in) {
    sum_1 := temp(0) + temp(1)
    sum_2 := temp(2) + temp(3)
    sum_3 := temp(4) + temp(5)
    sum_4 := temp(6) + temp(7)
  }

  // Task 5: Final product
  val mul_out_reg = RegInit(0.U(16.W)) // 16-bit register for final product
  when(io.mul_en_in) {
    mul_out_reg := sum_1 + sum_2 + sum_3 + sum_4 // Accumulate all partial sums
  }

  // Task 6: Output assignment
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U) // Output product or 0 based on enable signal
}

