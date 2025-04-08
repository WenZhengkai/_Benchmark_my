// Import required Chisel packages
import chisel3._
import chisel3.util._

// Define the dut module
class dut extends Module {
  val io = IO(new Bundle {
    // Define input ports
    val mul_en_in = Input(Bool())           // Input enable signal
    val mul_a = Input(UInt(8.W))           // 8-bit multiplicand
    val mul_b = Input(UInt(8.W))           // 8-bit multiplier

    // Define output ports
    val mul_en_out = Output(Bool())        // Output enable signal
    val mul_out = Output(UInt(16.W))       // 16-bit product output
  })

  // Internal pipeline registers
  val mul_en_pipeline = RegInit(0.U(5.W))  // 5-bit pipeline register for mul_en
  val mul_a_reg = Reg(UInt(8.W))
  val mul_b_reg = Reg(UInt(8.W))

  // Partial products and summation registers
  val partial_products = Wire(Vec(8, UInt(16.W)))
  val partial_sums = Reg(Vec(4, UInt(16.W)))

  // Final output register
  val mul_out_reg = RegInit(0.U(16.W))

  // Pipeline enable logic
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Shift pipeline register for mul_en signal
  mul_en_pipeline := Cat(mul_en_pipeline(3, 0), io.mul_en_in)

  // Partial product generation
  for (i <- 0 until 8) {
    partial_products(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U(16.W))
  }

  // Partial sum computation
  partial_sums(0) := partial_products(0) + partial_products(1)
  partial_sums(1) := partial_products(2) + partial_products(3)
  partial_sums(2) := partial_products(4) + partial_products(5)
  partial_sums(3) := partial_products(6) + partial_products(7)

  // Final product calculation
  mul_out_reg := partial_sums(0) + partial_sums(1) + partial_sums(2) + partial_sums(3)

  // Output assignments
  io.mul_out := Mux(mul_en_pipeline(4), mul_out_reg, 0.U)
  io.mul_en_out := mul_en_pipeline(4)
}

