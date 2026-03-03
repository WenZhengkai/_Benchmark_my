// package dut

import chisel3._
import chisel3.util._

/**
  * Unsigned 8-bit pipelined multiplier with input enable and output enable.
  *
  * Pipeline:
  *  - mul_en_in is shifted through a 5-bit register; mul_en_out is its MSB.
  *  - mul_a/mul_b are captured when mul_en_in is high.
  *  - Partial products are formed from captured inputs, grouped, summed into pipeline regs,
  *    and finally accumulated into mul_out_reg.
  *  - mul_out is valid only when mul_en_out is asserted; otherwise 0.
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
  // Input enable pipeline (5-bit shift register)
  // --------------------------------------------------------------------------
  val mul_en_out_reg = RegInit(0.U(5.W))
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)
  io.mul_en_out := mul_en_out_reg(4)

  // --------------------------------------------------------------------------
  // Input registers (updated only when mul_en_in is active)
  // --------------------------------------------------------------------------
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // --------------------------------------------------------------------------
  // Partial product generation (combinational from registered inputs)
  // temp(i) = (mul_b_reg(i) ? (mul_a_reg << i) : 0)
  // --------------------------------------------------------------------------
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    val shifted = (mul_a_reg.asUInt << i).asUInt
    temp(i) := Mux(mul_b_reg(i), shifted(15, 0), 0.U(16.W))
  }

  // --------------------------------------------------------------------------
  // Partial sum calculation (pipeline registers)
  // Group partial products and register intermediate sums.
  // --------------------------------------------------------------------------
  val sum = RegInit(VecInit(Seq.fill(4)(0.U(16.W))))

  // Register the grouped sums every cycle; functional validity is tracked by mul_en_out_reg
  sum(0) := temp(0) +& temp(1)
  sum(1) := temp(2) +& temp(3)
  sum(2) := temp(4) +& temp(5)
  sum(3) := temp(6) +& temp(7)

  // --------------------------------------------------------------------------
  // Final product calculation (registered)
  // --------------------------------------------------------------------------
  val mul_out_reg = RegInit(0.U(16.W))
  mul_out_reg := (sum(0) +& sum(1)) +& (sum(2) +& sum(3))

  // --------------------------------------------------------------------------
  // Output assignment
  // --------------------------------------------------------------------------
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W))
}
