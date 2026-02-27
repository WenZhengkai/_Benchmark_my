import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(32.W))  // First operand
    val b = Input(UInt(32.W))  // Second operand
    val z = Output(UInt(32.W)) // Result
  })

  // Extract the components of the first input
  val a_sign = io.a(31)
  val a_exponent = io.a(30, 23)
  val a_mantissa = io.a(22, 0)

  // Extract the components of the second input
  val b_sign = io.b(31)
  val b_exponent = io.b(30, 23)
  val b_mantissa = io.b(22, 0)

  // Internal registers and wires
  val z_sign = RegInit(0.U(1.W))
  val z_exponent = RegInit(0.U(8.W))
  val z_mantissa = RegInit(0.U(23.W))
  val product = RegInit(0.U(50.W)) // More bits for intermediate multiplication
  val guard_bit = RegInit(0.U(1.W))
  val round_bit = RegInit(0.U(1.W))
  val sticky = RegInit(0.U(1.W))

  val normalizedMantissaA = Cat(1.U(1.W), a_mantissa) // Add the hidden bit (1) in normalized mode
  val normalizedMantissaB = Cat(1.U(1.W), b_mantissa) // Add the hidden bit (1) in normalized mode

  // Multiply the mantissas
  val rawProduct = normalizedMantissaA * normalizedMantissaB

  // Add exponents and adjust the bias (subtract 127, the IEEE-754 bias for single precision)
  val rawExponent = a_exponent.zext +& b_exponent.zext - 127.S

  // Sign calculation: XOR the signs of both inputs
  z_sign := a_sign ^ b_sign

  // Clock Counter for State Control (Finite-State Machine handling)
  val counter = RegInit(0.U(3.W))
  switch(counter) {
    is(0.U) { // First cycle: Read and process operands
      product := rawProduct
      z_exponent := Mux(rawExponent < 0.S, 0.U, rawExponent.asUInt) // Handle exponent underflow
      counter := 1.U
    }
    is(1.U) { // Second cycle: Normalize and round results
      when(product(47)) { // Check for normalization if the most significant bit is set
        z_mantissa := product(46, 24) // Capture the top 23 bits
        guard_bit := product(23)
        round_bit := product(22)
        sticky := product(21, 0).orR // Set sticky if any lower bits are set
      }.otherwise {
        z_mantissa := product(45, 23) // Capture the top 23 bits
        guard_bit := product(22)
        round_bit := product(21)
        sticky := product(20, 0).orR // Set sticky if any lower bits are set
        z_exponent := z_exponent - 1.U // Adjust the exponent
      }

      // Rounding logic
      when(guard_bit && (round_bit || sticky || z_mantissa(0))) { // Round up if needed
        z_mantissa := z_mantissa + 1.U
        when(z_mantissa === "hFFFFFF".U) { // Handle mantissa overflow
          z_mantissa := z_mantissa >> 1
          z_exponent := z_exponent + 1.U
        }
      }

      counter := 2.U
    }
    is(2.U) { // Handle special cases: NaN, infinity, zero
      when(a_exponent === "hFF".U || b_exponent === "hFF".U) { // NaN or Inf
        when(a_mantissa.orR || b_mantissa.orR) { // NaN
          z_exponent := "hFF".U
          z_mantissa := 1.U // NaN payload
          z_sign := 0.U
        }.otherwise { // Infinity
          z_exponent := "hFF".U
          z_mantissa := 0.U
        }
      }.elsewhen(a_exponent === 0.U || b_exponent === 0.U) { // Zero detection
        z_exponent := 0.U
        z_mantissa := 0.U
        z_sign := a_sign ^ b_sign
      }

      counter := 0.U // Reset the counter
    }
  }

  // Assemble output into IEEE 754 format
  io.z := Cat(z_sign, z_exponent, z_mantissa)
}

