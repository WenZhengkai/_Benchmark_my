import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in  = Input(Bool())    // Input enable signal
    val mul_a      = Input(UInt(8.W)) // 8-bit multiplicand
    val mul_b      = Input(UInt(8.W)) // 8-bit multiplier
    val mul_en_out = Output(Bool())   // Output enable signal
    val mul_out    = Output(UInt(16.W)) // 16-bit product output
  })

  // Task 1: Input Control Logic
  val mul_en_out_reg = RegInit(0.U(5.W)) // 5-bit shift register for enable signal
  when(io.mul_en_in) {
    mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in) // Shift in the enable signal
  }
  
  val mul_en_out = mul_en_out_reg(4) // Extract the MSB of the shift register as output enable
  io.mul_en_out := mul_en_out

  // Task 2: Input Registers for A and B
  val mul_a_reg = RegInit(0.U(8.W)) // Register to store multiplicand
  val mul_b_reg = RegInit(0.U(8.W)) // Register to store multiplier

  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Task 3: Generate Partial Products
  val temp = Wire(Vec(8, UInt(16.W))) // Wires to store 8 partial products
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U) // Generate partial product
  }

  // Task 4: Implement Partial Sum Calculations
  val sum1 = RegInit(0.U(16.W))
  val sum2 = RegInit(0.U(16.W))
  val sum3 = RegInit(0.U(16.W))
  val sum4 = RegInit(0.U(16.W))

  when(io.mul_en_in) {
    sum1 := temp(0) + temp(1)
    sum2 := temp(2) + temp(3)
    sum3 := temp(4) + temp(5)
    sum4 := temp(6) + temp(7)
  }

  // Task 5: Calculate Final Product
  val mul_out_reg = RegInit(0.U(16.W)) // Register to store the final product
  when(io.mul_en_in) {
    mul_out_reg := sum1 + sum2 + sum3 + sum4
  }

  // Task 6: Output Assignment
  io.mul_out := Mux(mul_en_out, mul_out_reg, 0.U) // Output final product or 0
}

