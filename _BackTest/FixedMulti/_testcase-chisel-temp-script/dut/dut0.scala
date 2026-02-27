import chisel3._
import chisel3.util._

class FloatMultiIO extends Bundle {
  val a = Input(UInt(32.W))  // First operand (IEEE 754 format)
  val b = Input(UInt(32.W))  // Second operand (IEEE 754 format)
  val z = Output(UInt(32.W)) // Result (IEEE 754 format)
}

class dut extends Module {
  val io = IO(new FloatMultiIO)

  // Internal registers and wires
  val counter = RegInit(0.U(3.W))
  val a_sign = Wire(Bool())
  val b_sign = Wire(Bool())
  val z_sign = RegInit(false.B)
  val a_exponent = Wire(UInt(8.W))
  val b_exponent = Wire(UInt(8.W))
  val z_exponent = RegInit(0.U(8.W))
  val a_mantissa = Wire(UInt(24.W))
  val b_mantissa = Wire(UInt(24.W))
  val z_mantissa = RegInit(0.U(24.W))
  val product = RegInit(0.U(50.W))
  val guard_bit = RegInit(false.B)
  val round_bit = RegInit(false.B)
  val sticky = RegInit(false.B)

  // Extract sign, exponent, and mantissa from inputs
  a_sign := io.a(31)
  b_sign := io.b(31)
  a_exponent := io.a(30, 23)
  b_exponent := io.b(30, 23)
  a_mantissa := Cat(1.U(1.W), io.a(22, 0))  // Add implicit leading 1 for normalized numbers
  b_mantissa := Cat(1.U(1.W), io.b(22, 0))  // Add implicit leading 1 for normalized numbers

  // State machine
  switch(counter) {
    is(0.U) {
      // Reset and Initialization
      z_sign := a_sign ^ b_sign           // Sign of the result
      z_exponent := a_exponent +& b_exponent - 127.U  // Add exponents and subtract bias
      product := a_mantissa * b_mantissa // Multiply mantissas
      counter := 1.U
    }
    is(1.U) {
      // Handle normalization
      when(product(47)) { // Result is already normalized
        z_mantissa := product(47, 24)   // Take top 24 bits
        guard_bit := product(23)       // Guard bit
        round_bit := product(22)       // Round bit
        sticky := product(21, 0).orR() // Sticky bit
      }.otherwise { // Normalize (shift left by 1)
        z_mantissa := product(46, 23)
        guard_bit := product(22)
        round_bit := product(21)
        sticky := product(20, 0).orR()
        z_exponent := z_exponent - 1.U // Adjust exponent
      }
      counter := 2.U
    }
    is(2.U) {
      // Rounding logic
      when(guard_bit && (round_bit || sticky || z_mantissa(0))) { // Round up
        z_mantissa := z_mantissa + 1.U
        when(z_mantissa === "hffffff".U) { // Handle mantissa overflow
          z_exponent := z_exponent + 1.U
        }
      }
      counter := 3.U
    }
    is(3.U) {
      // Generate final result and handle special cases
      when(z_exponent >= 255.U) { // Overflow
        io.z := Cat(z_sign, "b11111111".U(8.W), 0.U(23.W)) // Infinity
      }.elsewhen(z_exponent === 0.U && z_mantissa === 0.U) { // Underflow
        io.z := Cat(z_sign, 0.U(31.W)) // Zero
      }.elsewhen(z_exponent === 0.U) { // Denormalized
        io.z := Cat(z_sign, "b00000000".U(8.W), z_mantissa(22, 0))
      }.otherwise { // Normalized result
        io.z := Cat(z_sign, z_exponent, z_mantissa(22, 0))
      }
      counter := 0.U
    }
  }
}


