import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool())      // Input enable signal
    val mul_a = Input(UInt(8.W))      // 8-bit multiplicand
    val mul_b = Input(UInt(8.W))      // 8-bit multiplier
    val mul_en_out = Output(Bool())   // Output enable signal
    val mul_out = Output(UInt(16.W))  // 16-bit product output
  })

  // Task 1: Input control logic
  // A 5-bit shift register to store the enable signal across clock cycles
  val mul_en_out_reg = RegInit(0.U(5.W))
  when(io.mul_en_in) {
    mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in) // Shift enable signal
  } .otherwise {
    mul_en_out_reg := Cat(mul_en_out_reg(3, 0), 0.U) // Shift 0 if enable isn't active
  }

  // The most significant bit (MSB) of `mul_en_out_reg` determines `mul_en_out`
  val mul_en_out = mul_en_out_reg(4)
  io.mul_en_out := mul_en_out

  // Task 2: Input registers for storing `mul_a` and `mul_b`
  val mul_a_reg = RegInit(0.U(8.W)) // 8-bit register for multiplicand
  val mul_b_reg = RegInit(0.U(8.W)) // 8-bit register for multiplier

  when(io.mul_en_in) {
    mul_a_reg := io.mul_a // Update multiplicand when enable is active
    mul_b_reg := io.mul_b // Update multiplier when enable is active
  }

  // Task 3: Generate partial products
  val partial_products = Wire(Vec(8, UInt(16.W))) // Partial products array

  for (i <- 0 until 8) {
    partial_products(i) := mul_a_reg.asUInt & Fill(16, mul_b_reg(i)) // AND operation
  }

  // Task 4: Partial sum calculations
  val sum1 = RegInit(0.U(16.W)) // Intermediate sum register 1
  val sum2 = RegInit(0.U(16.W)) // Intermediate sum register 2
  val sum3 = RegInit(0.U(16.W)) // Intermediate sum register 3

  when(io.mul_en_in) {
    sum1 := partial_products(0) + (partial_products(1) << 1)
    sum2 := (partial_products(2) << 2) + (partial_products(3) << 3)
    sum3 := (partial_products(4) << 4) + (partial_products(5) << 5) +
            (partial_products(6) << 6) + (partial_products(7) << 7)
  }

  // Task 5: Calculate the final product
  val mul_out_reg = RegInit(0.U(16.W)) // Final product register
  when(io.mul_en_in) {
    mul_out_reg := sum1 + sum2 + sum3 // Accumulated sum
  }

  // Task 6: Output assignment
  when(mul_en_out) {
    io.mul_out := mul_out_reg // Assign final product to output
  } .otherwise {
    io.mul_out := 0.U // Assign 0 if output enable is not active
  }
}


