import chisel3._
import chisel3.util._

/**
  * Unsigned 8-bit pipelined multiplier
  *
  * - Input enable:  mul_en_in
  * - Output enable: mul_en_out (MSB of a 5-bit shift register)
  * - Output data:   mul_out (valid when mul_en_out=1, else 0)
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
  // Enable pipeline (5-bit shift register); output enable is the MSB
  // --------------------------------------------------------------------------
  val mul_en_out_reg = RegInit(0.U(5.W))
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)
  io.mul_en_out := mul_en_out_reg(4)

  // --------------------------------------------------------------------------
  // Input registers (updated only when mul_en_in is asserted)
  // --------------------------------------------------------------------------
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))

  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // --------------------------------------------------------------------------
  // Partial product generation (combinational from registered inputs)
  // temp(i) corresponds to (mul_a_reg << i) if mul_b_reg(i)=1 else 0
  // --------------------------------------------------------------------------
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    val shifted = (mul_a_reg.asUInt << i).asUInt
    temp(i) := Mux(mul_b_reg(i), shifted(15, 0), 0.U(16.W))
  }

  // --------------------------------------------------------------------------
  // Partial sum calculation (pipelined registers)
  // Group partial products into 4 sums (pairs), then sum those, then final sum.
  // Total datapath latency aligned with mul_en_out_reg MSB.
  // --------------------------------------------------------------------------
  val sum0 = RegInit(0.U(16.W)) // temp0 + temp1
  val sum1 = RegInit(0.U(16.W)) // temp2 + temp3
  val sum2 = RegInit(0.U(16.W)) // temp4 + temp5
  val sum3 = RegInit(0.U(16.W)) // temp6 + temp7

  // stage 1: pairwise sums
  when(mul_en_out_reg(0)) {
    sum0 := temp(0) + temp(1)
    sum1 := temp(2) + temp(3)
    sum2 := temp(4) + temp(5)
    sum3 := temp(6) + temp(7)
  }.otherwise {
    sum0 := 0.U; sum1 := 0.U; sum2 := 0.U; sum3 := 0.U
  }

  // stage 2: sum pairs of sums
  val sum01 = RegInit(0.U(16.W))
  val sum23 = RegInit(0.U(16.W))
  when(mul_en_out_reg(1)) {
    sum01 := sum0 + sum1
    sum23 := sum2 + sum3
  }.otherwise {
    sum01 := 0.U
    sum23 := 0.U
  }

  // stage 3: final product register
  val mul_out_reg = RegInit(0.U(16.W))
  when(mul_en_out_reg(2)) {
    mul_out_reg := sum01 + sum23
  }.otherwise {
    mul_out_reg := 0.U
  }

  // --------------------------------------------------------------------------
  // Output assignment: drive product only when output enable is valid
  // --------------------------------------------------------------------------
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W))
}
