import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(32.W))      // First operand in IEEE 754 format
    val b = Input(UInt(32.W))      // Second operand in IEEE 754 format
    val z = Output(UInt(32.W))     // Result of multiplication in IEEE 754 format
  })

  // Internal signals
  val a_sign     = Wire(Bool())
  val b_sign     = Wire(Bool())
  val z_sign     = Wire(Bool())
  val a_exponent = Wire(SInt(10.W))
  val b_exponent = Wire(SInt(10.W))
  val z_exponent = RegInit(0.S(10.W))
  val a_mantissa = Wire(UInt(24.W))
  val b_mantissa = Wire(UInt(24.W))
  val z_mantissa = RegInit(0.U(24.W))
  val product    = RegInit(0.U(50.W))
  val guard_bit  = RegInit(false.B)
  val round_bit  = RegInit(false.B)
  val sticky     = RegInit(false.B)
  val counter    = RegInit(0.U(3.W)) // Cycle counter

  // Parse input operands (IEEE-754 format)
  a_sign     := io.a(31)
  b_sign     := io.b(31)
  a_exponent := Cat(0.U(1.W), io.a(30, 23)).asSInt - 127.S // Unbias exponent
  b_exponent := Cat(0.U(1.W), io.b(30, 23)).asSInt - 127.S
  a_mantissa := Cat(1.U(1.W), io.a(22, 0))                 // Add implicit 1 for normalized numbers
  b_mantissa := Cat(1.U(1.W), io.b(22, 0))

  // Control state machine
  switch(counter) {
    is(0.U) { // Initialization and special cases handling
      when(io.a(30, 23) === "b11111111".U || io.b(30, 23) === "b11111111".U) {
        // Handle NaN or infinity
        when(io.a(22, 0) =/= 0.U || io.b(22, 0) =/= 0.U) { // NaN case
          io.z := "b0111111111000000000000000000000".U // NaN
        }.otherwise { // Infinity case
          io.z := Cat(a_sign ^ b_sign, "b11111111".U, 0.U(23.W)) // Infinity
        }
      }.otherwise {
        // No special cases, ready for multiplication
        counter := 1.U
      }
    }
    is(1.U) { // Mantissa multiplication
      product := a_mantissa * b_mantissa
      z_sign := a_sign ^ b_sign
      z_exponent := a_exponent + b_exponent
      counter := 2.U
    }
    is(2.U) { // Normalization
      when(product(47)) { // If the result is already normalized
        z_mantissa := product(46, 23)
        guard_bit := product(22)
        round_bit := product(21)
        sticky := product(20, 0).orR
        z_exponent := z_exponent + 1.S
      }.otherwise {
        z_mantissa := product(45, 22)
        guard_bit := product(21)
        round_bit := product(20)
        sticky := product(19, 0).orR
      }
      counter := 3.U
    }
    is(3.U) { // Rounding
      when(guard_bit && (round_bit || sticky || z_mantissa(0).asBool)) {
        z_mantissa := z_mantissa + 1.U
        when(z_mantissa === "b11111111111111111111111".U) { // Overflow in mantissa
          z_exponent := z_exponent + 1.S
        }
      }
      counter := 4.U
    }
    is(4.U) { // Output formatting
      when(z_exponent > 127.S) { // Overflow
        io.z := Cat(z_sign, "b11111111".U, 0.U(23.W)) // Infinity
      }.elsewhen(z_exponent < -126.S) { // Underflow
        io.z := Cat(z_sign, 0.U(8.W), 0.U(23.W)) // Zero
      }.otherwise {
        io.z := Cat(z_sign, (z_exponent + 127.S)(7, 0), z_mantissa(22, 0))
      }
      counter := 0.U // Reset counter
    }
  }
}
