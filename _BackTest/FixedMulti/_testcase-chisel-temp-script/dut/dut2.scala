import chisel3._
import chisel3.util._

// Define the dut module
class dut extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(32.W))   // First operand
    val b = Input(UInt(32.W))   // Second operand
    val z = Output(UInt(32.W))  // Result
  })

  // Extract mantissa, exponent, and sign from operands a and b
  val a_sign = io.a(31)             // Sign bit of a
  val b_sign = io.b(31)             // Sign bit of b
  val z_sign = RegInit(false.B)     // Result sign

  val a_exponent = io.a(30, 23)     // Exponent of a
  val b_exponent = io.b(30, 23)     // Exponent of b
  val z_exponent = RegInit(0.U(8.W)) // Result exponent

  val a_mantissa = Cat(1.U(1.W), io.a(22, 0)) // Add implicit 1 to mantissa of a
  val b_mantissa = Cat(1.U(1.W), io.b(22, 0)) // Add implicit 1 to mantissa of b
  val product = (a_mantissa.asSInt * b_mantissa.asSInt).asUInt // Intermediate product

  // Cycle counter
  val counter = RegInit(0.U(3.W))

  // Guard, round, and sticky bits for rounding
  val guard_bit = RegInit(false.B)
  val round_bit = RegInit(false.B)
  val sticky_bit = RegInit(false.B)

  // Special cases
  val a_is_zero = a_exponent === 0.U && io.a(22, 0) === 0.U
  val b_is_zero = b_exponent === 0.U && io.b(22, 0) === 0.U
  val a_is_inf  = a_exponent === "b11111111".U && io.a(22, 0) === 0.U
  val b_is_inf  = b_exponent === "b11111111".U && io.b(22, 0) === 0.U
  val a_is_nan  = a_exponent === "b11111111".U && io.a(22, 0) =/= 0.U
  val b_is_nan  = b_exponent === "b11111111".U && io.b(22, 0) =/= 0.U

  // Variables for normalization
  val normalized_mantissa = Reg(UInt(25.W)) // 24 bits + 1 for rounding
  val normalized_exponent = Reg(UInt(8.W)) // 8 bits for exponent

  // FSM to break down the floating-point multiplication process
  when(counter === 0.U) {
    // Initialization and sign calculation
    when(a_is_nan || b_is_nan) {
      z_sign := false.B
      z_exponent := "b11111111".U
      normalized_mantissa := Cat(false.B, "b11111111111111111111111".U)
    }.elsewhen(a_is_inf || b_is_inf) {
      z_sign := a_sign ^ b_sign
      z_exponent := "b11111111".U
      normalized_mantissa := 0.U
    }.elsewhen(a_is_zero || b_is_zero) {
      z_sign := a_sign ^ b_sign
      z_exponent := 0.U
      normalized_mantissa := 0.U
    }.otherwise {
      z_sign := a_sign ^ b_sign   // Combine signs
      
      // Calculate exponent
      z_exponent := a_exponent + b_exponent - 127.U
      val tmp_product = product(47, 0)

      // Check for normalization
      when(tmp_product(47)) {
        normalized_mantissa := tmp_product(47, 24) // Already normalized
        guard_bit := tmp_product(23)
        round_bit := tmp_product(22)
        sticky_bit := tmp_product(21, 0).orR
      }.otherwise {
        normalized_mantissa := tmp_product(46, 23)
        z_exponent := z_exponent - 1.U
        guard_bit := tmp_product(22)
        round_bit := tmp_product(21)
        sticky_bit := tmp_product(20, 0).orR
      }
    }

    counter := counter + 1.U
  }.otherwise {
    // Add rounding
    when(round_bit && (guard_bit || sticky_bit || (normalized_mantissa(0) === 1.U))) {
      normalized_mantissa := normalized_mantissa + 1.U
      when(normalized_mantissa === "hFFFFFF".U) {
        normalized_mantissa := normalized_mantissa >> 1
        z_exponent := z_exponent + 1.U
      }
    }

    counter := 0.U // Reset counter for next calculation
  }

  // Compose the final result
  io.z := Cat(z_sign, z_exponent, normalized_mantissa(22, 0))
}


