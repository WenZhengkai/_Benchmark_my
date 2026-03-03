import chisel3._
import chisel3.util._

/**
  * Unsigned 8-bit pipelined multiplier with input enable and pipelined output enable.
  *
  * - mul_en_in gates input sampling (mul_a/mul_b) and pipeline computation
  * - mul_en_out is the MSB of a 5-bit shift register of mul_en_in (5-cycle latency)
  * - mul_out is valid only when mul_en_out is high; otherwise 0
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
  // Enable pipeline (5-bit shift register), output enable is MSB
  // ---------------------------------------------------------------------------
  val mul_en_out_reg = RegInit(0.U(5.W))
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)
  io.mul_en_out := mul_en_out_reg(4)

  // ---------------------------------------------------------------------------
  // Input registers (sample only when mul_en_in is asserted)
  // ---------------------------------------------------------------------------
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))

  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // ---------------------------------------------------------------------------
  // Partial product generation (combinational from registered inputs)
  // temp(i) = (mul_a_reg << i) when mul_b_reg(i) else 0
  // ---------------------------------------------------------------------------
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    val shifted = (mul_a_reg.asUInt << i).asUInt // up to 15 bits, keep as UInt
    temp(i) := Mux(mul_b_reg(i), shifted(15, 0), 0.U(16.W))
  }

  // ---------------------------------------------------------------------------
  // Partial sum pipeline registers
  // Stage 1: sum pairs of partial products (4 regs)
  // Stage 2: sum pairs of stage1 results (2 regs)
  // Stage 3: sum stage2 results (1 reg)
  // Stage 4: register final result (mul_out_reg)
  //
  // All updated only when mul_en_in is asserted (acts as clock enable).
  // ---------------------------------------------------------------------------
  val sum1 = RegInit(VecInit(Seq.fill(4)(0.U(16.W))))
  val sum2 = RegInit(VecInit(Seq.fill(2)(0.U(16.W))))
  val sum3 = RegInit(0.U(16.W))
  val mul_out_reg = RegInit(0.U(16.W))

  when(io.mul_en_in) {
    // stage 1
    sum1(0) := temp(0) + temp(1)
    sum1(1) := temp(2) + temp(3)
    sum1(2) := temp(4) + temp(5)
    sum1(3) := temp(6) + temp(7)

    // stage 2
    sum2(0) := sum1(0) + sum1(1)
    sum2(1) := sum1(2) + sum1(3)

    // stage 3
    sum3 := sum2(0) + sum2(1)

    // stage 4 (final)
    mul_out_reg := sum3
  }

  // ---------------------------------------------------------------------------
  // Output assignment: valid only when mul_en_out asserted
  // ---------------------------------------------------------------------------
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W))
}
