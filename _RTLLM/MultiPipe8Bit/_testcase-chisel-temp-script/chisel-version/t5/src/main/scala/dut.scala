import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool()) // Input enable signal
    val mul_a = Input(UInt(8.W)) // Multiplicand (8-bit)
    val mul_b = Input(UInt(8.W)) // Multiplier (8-bit)
    val mul_en_out = Output(Bool()) // Output enable signal
    val mul_out = Output(UInt(16.W)) // Product (16-bit)
  })

  // Task 1: Implement the input control logic
  val mul_en_out_reg = RegInit(0.U(5.W)) // 5-bit shift register for enable signal
  when(io.mul_en_in) {
    mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in) // Shift and insert new enable signal
  } .otherwise {
    mul_en_out_reg := Cat(mul_en_out_reg(3, 0), 0.U(1.W)) // Shift in 0 if not enabled
  }
  val mul_en_out = mul_en_out_reg(4) // Most significant bit drives output enable signal

  // Task 2: Implement input registers to store `mul_a` and `mul_b`
  val mul_a_reg = RegInit(0.U(8.W)) // Register for multiplicand
  val mul_b_reg = RegInit(0.U(8.W)) // Register for multiplier
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a // Capture multiplicand when enabled
    mul_b_reg := io.mul_b // Capture multiplier when enabled
  }

  // Task 3: Generate partial products
  val temp = Wire(Vec(8, UInt(16.W))) // Partial products (8 wires, 16-bit wide each)
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U) // If bit i in mul_b_reg is 1, perform bitwise AND and shift
  }

  // Task 4: Implement partial sum calculations
  val sum1 = RegNext(temp(0) + temp(1)) // First level of summation: Add first 2 partial products
  val sum2 = RegNext(temp(2) + temp(3)) // Second level for next 2 partial products
  val sum3 = RegNext(temp(4) + temp(5)) // Third level for next 2 partial products
  val sum4 = RegNext(temp(6) + temp(7)) // Fourth level for next 2 partial products

  // Task 5: Calculate the final product
  val sum5 = RegNext(sum1 + sum2) // Combine first two sums
  val sum6 = RegNext(sum3 + sum4) // Combine last two sums
  val mul_out_reg = RegNext(sum5 + sum6) // Final sum

  // Task 6: Implement the output assignment
  io.mul_en_out := mul_en_out // Set output enable signal
  io.mul_out := Mux(mul_en_out, mul_out_reg, 0.U) // Output the product if enabled, else 0
}

