import chisel3._
import chisel3.util._

/**
  * Unsigned 8-bit pipelined multiplier
  *
  * - Inputs sampled when mul_en_in is 1
  * - 5-stage enable pipeline (mul_en_out_reg is 5 bits)
  * - Partial products built from mul_a_reg and bits of mul_b_reg
  * - Partial sums registered, then final sum registered
  * - Output mul_out is valid only when mul_en_out is 1, else 0
  */
class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in  = Input(Bool())
    val mul_a      = Input(UInt(8.W))
    val mul_b      = Input(UInt(8.W))
    val mul_en_out = Output(Bool())
    val mul_out    = Output(UInt(16.W))
  })

  // --------------------------------------------------------------------------
  // Enable pipeline (5-bit shift register), output enable is MSB
  // --------------------------------------------------------------------------
  val mul_en_out_reg = RegInit(0.U(5.W))
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)
  io.mul_en_out := mul_en_out_reg(4)

  // --------------------------------------------------------------------------
  // Input registers (only update when enabled)
  // --------------------------------------------------------------------------
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // --------------------------------------------------------------------------
  // Partial product generation (8 partial products, each 16-bit aligned)
  // temp(i) = (mul_b_reg(i) ? (mul_a_reg << i) : 0)
  // --------------------------------------------------------------------------
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), (mul_a_reg.asUInt << i).asUInt, 0.U(16.W))
  }

  // --------------------------------------------------------------------------
  // Partial sum calculation (registered)
  // Use an adder tree split into 4 registers to model "groups of partial products"
  // --------------------------------------------------------------------------
  val sum = RegInit(VecInit(Seq.fill(4)(0.U(16.W))))

  // These partial sums are computed every cycle; they correspond to the current
  // registered inputs (mul_a_reg/mul_b_reg). Functionally safe because output
  // is gated by mul_en_out.
  sum(0) := temp(0) +& temp(1) // +& keeps carry; width remains 16 here due to assignment
  sum(1) := temp(2) +& temp(3)
  sum(2) := temp(4) +& temp(5)
  sum(3) := temp(6) +& temp(7)

  // --------------------------------------------------------------------------
  // Final product calculation (registered)
  // --------------------------------------------------------------------------
  val mul_out_reg = RegInit(0.U(16.W))
  mul_out_reg := (sum(0) +& sum(1)) +& (sum(2) +& sum(3))

  // --------------------------------------------------------------------------
  // Output assignment (valid only when mul_en_out asserted)
  // --------------------------------------------------------------------------
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W))
}
