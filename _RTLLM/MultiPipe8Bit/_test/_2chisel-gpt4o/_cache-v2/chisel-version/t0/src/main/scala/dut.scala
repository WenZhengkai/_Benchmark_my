import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool())       // Input enable signal
    val mul_a = Input(UInt(8.W))       // Input multiplicand (8 bits)
    val mul_b = Input(UInt(8.W))       // Input multiplier (8 bits)
    val mul_en_out = Output(Bool())    // Output enable signal
    val mul_out = Output(UInt(16.W))   // Output product (16 bits)
  })

  // Pipeline registers for enable signal
  val mul_en_out_reg = RegInit(0.U(5.W)) // 5-bit register for enable signal propagation

  // Pipeline registers for inputs
  val mul_a_reg = RegInit(0.U(8.W))    // Register for multiplicand
  val mul_b_reg = RegInit(0.U(8.W))    // Register for multiplier

  // Wires for partial products
  val temp = Wire(Vec(8, UInt(16.W)))  // Wires for partial products (16 bits each)

  // Pipeline registers for partial sums
  val partial_sums = Reg(Vec(8, UInt(16.W))) // Registers for partial sums
  
  // Final product register
  val mul_out_reg = RegInit(0.U(16.W)) // Register for the final product

  // --- Input Control Logic ---
  // Capture mul_en_in in the pipeline register chain
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)

  // Update input registers only when mul_en_in is active
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Derive mul_en_out from the MSB of the pipeline register chain
  io.mul_en_out := mul_en_out_reg(4)

  // --- Partial Product Generation ---
  // Generate partial products by bitwise ANDing multiplicand (mul_a) with each bit of multiplier (mul_b)
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U(16.W))
  }

  // --- Partial Sum Calculation ---
  // Add partial products with pipeline registers to accumulate the sums
  partial_sums(0) := temp(0)
  for (i <- 1 until 8) {
    partial_sums(i) := temp(i) + partial_sums(i - 1)
  }

  // --- Final Product Calculation ---
  // Store final accumulated sum in the product register
  when(io.mul_en_out) {
    mul_out_reg := partial_sums(7)
  }.otherwise {
    mul_out_reg := 0.U
  }

  // --- Output Assignment ---
  // Assign final product to output based on enable signal
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}


