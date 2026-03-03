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

  // 5-bit enable pipeline
  val mul_en_out_reg = RegInit(0.U(5.W))
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)

  // Input registers (update only when input enable is asserted)
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Partial products
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), (mul_a_reg << i).asUInt, 0.U(16.W))
  }

  // Stage 1 partial sums
  val sum = RegInit(VecInit(Seq.fill(4)(0.U(16.W))))
  when(mul_en_out_reg(0)) {
    sum(0) := temp(0) + temp(1)
    sum(1) := temp(2) + temp(3)
    sum(2) := temp(4) + temp(5)
    sum(3) := temp(6) + temp(7)
  }

  // Stage 2 partial sums
  val sum2_a = RegInit(0.U(16.W))
  val sum2_b = RegInit(0.U(16.W))
  when(mul_en_out_reg(1)) {
    sum2_a := sum(0) + sum(1)
    sum2_b := sum(2) + sum(3)
  }

  // Stage 3 final accumulation
  val sum3 = RegInit(0.U(16.W))
  when(mul_en_out_reg(2)) {
    sum3 := sum2_a + sum2_b
  }

  // Stage 4 output register
  val mul_out_reg = RegInit(0.U(16.W))
  when(mul_en_out_reg(3)) {
    mul_out_reg := sum3
  }

  // Outputs
  io.mul_en_out := mul_en_out_reg(4)
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W))
}
