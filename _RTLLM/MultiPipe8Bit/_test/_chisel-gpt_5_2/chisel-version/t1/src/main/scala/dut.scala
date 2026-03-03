// SPDX-License-Identifier: Unlicense
import chisel3._
import chisel3.util._

/**
  * Unsigned 8-bit pipelined multiplier
  *
  * - Inputs sampled only when mul_en_in is high
  * - mul_en_out is the MSB of a 5-bit enable shift register (5-cycle latency)
  * - Partial products are formed from registered inputs, then accumulated through
  *   a small adder pipeline into mul_out_reg
  * - mul_out is driven with mul_out_reg when mul_en_out is high, else 0
  */
class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in  = Input(Bool())
    val mul_a      = Input(UInt(8.W))
    val mul_b      = Input(UInt(8.W))

    val mul_en_out = Output(Bool())
    val mul_out    = Output(UInt(16.W))
  })

  // ---------------------------------------------------------------------------
  // Enable pipeline (5-bit shift register); output enable is MSB
  // ---------------------------------------------------------------------------
  val mul_en_out_reg = RegInit(0.U(5.W))
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)
  io.mul_en_out  := mul_en_out_reg(4)

  // ---------------------------------------------------------------------------
  // Input registers (updated only when enabled)
  // ---------------------------------------------------------------------------
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // ---------------------------------------------------------------------------
  // Partial product generation (combinational from registered inputs)
  // temp(i) = (mul_b_reg(i) ? mul_a_reg : 0) << i
  // ---------------------------------------------------------------------------
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    val pp8 = Mux(mul_b_reg(i), mul_a_reg, 0.U(8.W))
    temp(i) := (pp8.asUInt << i).asUInt()(15, 0)
  }

  // ---------------------------------------------------------------------------
  // Partial sums pipeline (register groups of partial products)
  // sum0 = temp0 + temp1
  // sum1 = temp2 + temp3
  // sum2 = temp4 + temp5
  // sum3 = temp6 + temp7
  // ---------------------------------------------------------------------------
  val sum = RegInit(VecInit(Seq.fill(4)(0.U(16.W))))
  sum(0) := temp(0) +& temp(1)
  sum(1) := temp(2) +& temp(3)
  sum(2) := temp(4) +& temp(5)
  sum(3) := temp(6) +& temp(7)

  // ---------------------------------------------------------------------------
  // Final accumulation (registered)
  // ---------------------------------------------------------------------------
  val mul_out_reg = RegInit(0.U(16.W))
  mul_out_reg := (sum(0) +& sum(1)) +& (sum(2) +& sum(3))

  // ---------------------------------------------------------------------------
  // Output assignment (only valid when mul_en_out is asserted)
  // ---------------------------------------------------------------------------
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W))
}
