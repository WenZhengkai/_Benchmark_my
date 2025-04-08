import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in  = Input(Bool())   // Input enable signal
    val mul_a      = Input(UInt(8.W)) // Input operand: multiplicand (8 bits)
    val mul_b      = Input(UInt(8.W)) // Input operand: multiplier (8 bits)
    val mul_en_out = Output(Bool())  // Output enable signal
    val mul_out    = Output(UInt(16.W)) // Output: Product (16 bits)
  })

  // Define pipeline registers
  val mul_en_out_reg = RegInit(0.U(5.W))       // 5-stage pipeline for enable signal
  val mul_a_reg      = RegInit(0.U(8.W))       // Register for multiplicand
  val mul_b_reg      = RegInit(0.U(8.W))       // Register for multiplier

  // Partial products
  val temp = Wire(Vec(8, UInt(16.W)))          // Array of 8 partial products
  for (i <- 0 until 8) {
    temp(i) := Mux(io.mul_b(i), io.mul_a << i, 0.U(16.W)) // Shift and mask
  }

  // Sum up partial products in a pipelined manner
  val sum1 = RegInit(0.U(16.W))
  val sum2 = RegInit(0.U(16.W))
  val sum3 = RegInit(0.U(16.W))
  val sum4 = RegInit(0.U(16.W))

  // First stage of addition
  sum1 := temp(0) + temp(1)
  sum2 := temp(2) + temp(3)

  // Second stage of addition
  val partial_sum1 = RegInit(0.U(16.W))
  val partial_sum2 = RegInit(0.U(16.W))
  partial_sum1 := sum1 + sum2

  sum3 := temp(4) + temp(5)
  sum4 := temp(6) + temp(7)

  // Third stage of addition
  val final_sum = RegInit(0.U(16.W))
  final_sum := partial_sum1 + (sum3 + sum4)

  // Pipeline register updates
  when(io.mul_en_in) {
    mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in) // Shift in new enable bit
    mul_a_reg      := io.mul_a
    mul_b_reg      := io.mul_b
  }.otherwise {
    mul_en_out_reg := Cat(mul_en_out_reg(3, 0), 0.U) // Shift in 0 when disabled
  }

  // Assign output values
  io.mul_en_out := mul_en_out_reg(4)           // Output enable is the MSB of the register
  io.mul_out    := Mux(io.mul_en_out, final_sum, 0.U) // Output 0 if enable is not set
}

