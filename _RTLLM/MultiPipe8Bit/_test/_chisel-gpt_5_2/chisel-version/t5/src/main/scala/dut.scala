// SPDX-License-Identifier: Unlicense
import chisel3._
import chisel3.util._

/**
  * Unsigned 8-bit pipelined multiplier with input enable and output valid.
  *
  * Pipeline:
  * - mul_en_in is shifted through a 5-bit register (mul_en_out_reg).
  * - Inputs mul_a/mul_b are captured when mul_en_in is high.
  * - Partial products are generated from captured inputs.
  * - Partial sums are registered.
  * - Final sum is registered to mul_out_reg.
  * - mul_out is only driven with mul_out_reg when mul_en_out is high, else 0.
  */
class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in  = Input(Bool())
    val mul_a      = Input(UInt(8.W))
    val mul_b      = Input(UInt(8.W))
    val mul_en_out = Output(Bool())
    val mul_out    = Output(UInt(16.W))
  })

  // ------------------------------------------------------------
  // Input enable pipeline (5-bit shift register)
  // ------------------------------------------------------------
  val mul_en_out_reg = RegInit(0.U(5.W))
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)
  io.mul_en_out := mul_en_out_reg(4)

  // ------------------------------------------------------------
  // Input registers (updated only when mul_en_in is active)
  // ------------------------------------------------------------
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))

  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // ------------------------------------------------------------
  // Partial product generation (combinational from registered inputs)
  // temp(i) corresponds to (mul_a_reg & {8{mul_b_reg(i)}}) << i
  // ------------------------------------------------------------
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    val pp8  = Mux(mul_b_reg(i), mul_a_reg, 0.U(8.W)) // 8-bit partial
    temp(i) := (pp8.asUInt << i).asUInt               // align into 16-bit
  }

  // ------------------------------------------------------------
  // Partial sum calculation (registered)
  // Grouping into 4 registers for a simple pipelined structure
  // ------------------------------------------------------------
  val sum = RegInit(VecInit(Seq.fill(4)(0.U(16.W))))

  // Register the grouped partial sums every cycle.
  // (No explicit enable; validity is tracked by mul_en_out_reg.)
  sum(0) := temp(0) + temp(1)
  sum(1) := temp(2) + temp(3)
  sum(2) := temp(4) + temp(5)
  sum(3) := temp(6) + temp(7)

  // ------------------------------------------------------------
  // Final product calculation (registered)
  // ------------------------------------------------------------
  val mul_out_reg = RegInit(0.U(16.W))
  mul_out_reg := (sum(0) + sum(1)) + (sum(2) + sum(3))

  // ------------------------------------------------------------
  // Output assignment
  // ------------------------------------------------------------
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}
