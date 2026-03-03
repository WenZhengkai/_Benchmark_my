import chisel3._
import chisel3.util._

/**
  * Unsigned 8-bit pipelined multiplier with input enable and 5-cycle enable pipeline.
  *
  * Module name: dut
  * Inputs :
  *   mul_en_in : enable for sampling inputs / starting an operation
  *   mul_a     : 8-bit multiplicand
  *   mul_b     : 8-bit multiplier
  *
  * Outputs:
  *   mul_en_out: asserted when mul_out is valid (MSB of a 5-bit enable shift-register)
  *   mul_out   : 16-bit product, 0 when mul_en_out=0
  */
class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in  = Input(Bool())
    val mul_a      = Input(UInt(8.W))
    val mul_b      = Input(UInt(8.W))
    val mul_en_out = Output(Bool())
    val mul_out    = Output(UInt(16.W))
  })

  // -----------------------------
  // Input control (5-stage enable)
  // -----------------------------
  val mul_en_out_reg = RegInit(0.U(5.W))
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)
  io.mul_en_out := mul_en_out_reg(4)

  // -----------------------------
  // Input registers (sample only when enabled)
  // -----------------------------
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // -----------------------------
  // Partial product generation (combinational)
  // temp(i) = (mul_b_reg(i) ? (mul_a_reg << i) : 0)
  // -----------------------------
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), (mul_a_reg.asUInt << i).asUInt, 0.U(16.W))
  }

  // -----------------------------
  // Partial sum calculation (pipelined registers)
  // Group the partial products into 4 sums (2 terms each)
  // -----------------------------
  val sum = RegInit(VecInit(Seq.fill(4)(0.U(16.W))))
  when(io.mul_en_in) {
    sum(0) := temp(0) + temp(1)
    sum(1) := temp(2) + temp(3)
    sum(2) := temp(4) + temp(5)
    sum(3) := temp(6) + temp(7)
  }

  // -----------------------------
  // Final product calculation (registered)
  // -----------------------------
  val mul_out_reg = RegInit(0.U(16.W))
  // Register the accumulated sum; allow it to advance continuously (result validity is gated by mul_en_out)
  mul_out_reg := sum(0) + sum(1) + sum(2) + sum(3)

  // -----------------------------
  // Output assignment (valid gated)
  // -----------------------------
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W))
}
