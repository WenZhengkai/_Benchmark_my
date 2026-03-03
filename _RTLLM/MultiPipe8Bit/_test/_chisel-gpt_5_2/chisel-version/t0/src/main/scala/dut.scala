// Unsigned 8-bit pipelined multiplier (shift/add partial products)
// Module name: dut
//
// Ports:
//   mul_en_in  : input enable
//   mul_a      : 8-bit multiplicand
//   mul_b      : 8-bit multiplier
//   mul_en_out : output enable (delayed)
//   mul_out    : 16-bit product (valid when mul_en_out=1)
//
// Pipeline behavior:
//   - mul_en_in is shifted through a 5-bit register; mul_en_out is MSB.
//   - inputs are captured only when mul_en_in is high.
//   - partial products are generated combinationally from captured inputs.
//   - four partial sums are registered (1 pipeline stage).
//   - final product is registered (next pipeline stage).
//   - output is gated to 0 when mul_en_out is low.

import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in  = Input(Bool())
    val mul_a      = Input(UInt(8.W))
    val mul_b      = Input(UInt(8.W))
    val mul_en_out = Output(Bool())
    val mul_out    = Output(UInt(16.W))
  })

  // ----------------------------
  // Input enable pipeline (5-bit shift register)
  // ----------------------------
  val mul_en_out_reg = RegInit(0.U(5.W))
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)
  io.mul_en_out := mul_en_out_reg(4)

  // ----------------------------
  // Input registers (updated only when enabled)
  // ----------------------------
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // ----------------------------
  // Partial product generation (combinational)
  // temp(i) corresponds to (mul_a_reg << i) masked by mul_b_reg(i)
  // ----------------------------
  val a16 = mul_a_reg.asUInt
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    val pp = (a16 << i).asUInt // widened via assignment to 16.W
    temp(i) := Mux(mul_b_reg(i), pp, 0.U(16.W))
  }

  // ----------------------------
  // Partial sum calculation (registered)
  // Group partial products to reduce adder depth per stage
  // ----------------------------
  val sum = RegInit(VecInit(Seq.fill(4)(0.U(16.W))))
  // Optionally only update when operation is "in flight" (useful for power);
  // keep simple: update every cycle from current regs.
  sum(0) := temp(0) + temp(1)
  sum(1) := temp(2) + temp(3)
  sum(2) := temp(4) + temp(5)
  sum(3) := temp(6) + temp(7)

  // ----------------------------
  // Final product calculation (registered)
  // ----------------------------
  val mul_out_reg = RegInit(0.U(16.W))
  mul_out_reg := (sum(0) + sum(1)) + (sum(2) + sum(3))

  // ----------------------------
  // Output assignment (gate output by enable)
  // ----------------------------
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W))
}

// Optional: emit Verilog
/*
object dutGen extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, args)
}
*/
