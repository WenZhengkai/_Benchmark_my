import chisel3._
import chisel3.util._

/**
  * Unsigned 8-bit pipelined multiplier with enable pipeline.
  *
  * - mul_en_in is sampled into a 5-bit shift register (mul_en_out_reg).
  * - Inputs mul_a/mul_b are registered only when mul_en_in is high.
  * - Partial products are formed from mul_a_reg and bits of mul_b_reg.
  * - Partial sums are computed and registered (sum regs).
  * - Final product is accumulated into mul_out_reg.
  * - mul_out is driven with mul_out_reg only when mul_en_out is high, else 0.
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
  // Enable pipeline: 5-bit shift register, output enable = MSB
  // --------------------------------------------------------------------------
  val mul_en_out_reg = RegInit(0.U(5.W))
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)
  io.mul_en_out := mul_en_out_reg(4)

  // --------------------------------------------------------------------------
  // Input registers (captured only when enabled)
  // --------------------------------------------------------------------------
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // --------------------------------------------------------------------------
  // Partial product generation (8 partial products, shifted)
  // temp(i) = (mul_b_reg(i) ? (mul_a_reg << i) : 0)
  // --------------------------------------------------------------------------
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    val pp = Mux(mul_b_reg(i), (mul_a_reg.asUInt << i).asUInt, 0.U)
    temp(i) := pp(15, 0)
  }

  // --------------------------------------------------------------------------
  // Partial sum calculation (registered)
  // Group into 4 sums of 2 partial products each for a simple pipeline stage.
  // --------------------------------------------------------------------------
  val sum = RegInit(VecInit(Seq.fill(4)(0.U(16.W))))
  // (Synchronous update every cycle; data is meaningful when enable is in flight)
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
  // Output assignment: valid only when mul_en_out is asserted, else 0
  // --------------------------------------------------------------------------
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
