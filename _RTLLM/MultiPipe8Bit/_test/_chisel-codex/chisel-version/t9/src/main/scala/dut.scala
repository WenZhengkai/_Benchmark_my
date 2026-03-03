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

  // 5-cycle valid pipeline
  val mul_en_out_reg = RegInit(0.U(5.W))
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)

  // Input registers (sample only when enabled)
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

  // Pipeline sums
  val sum_s1 = RegInit(VecInit(Seq.fill(4)(0.U(16.W))))
  val sum_s2 = RegInit(VecInit(Seq.fill(2)(0.U(16.W))))
  val mul_out_reg = RegInit(0.U(16.W))

  // Stage 1: reduce 8 partial products -> 4 sums
  when(mul_en_out_reg(0)) {
    sum_s1(0) := (temp(0) +& temp(1))(15, 0)
    sum_s1(1) := (temp(2) +& temp(3))(15, 0)
    sum_s1(2) := (temp(4) +& temp(5))(15, 0)
    sum_s1(3) := (temp(6) +& temp(7))(15, 0)
  }

  // Stage 2: reduce 4 sums -> 2 sums
  when(mul_en_out_reg(1)) {
    sum_s2(0) := (sum_s1(0) +& sum_s1(1))(15, 0)
    sum_s2(1) := (sum_s1(2) +& sum_s1(3))(15, 0)
  }

  // Stage 3: final accumulation
  when(mul_en_out_reg(2)) {
    mul_out_reg := (sum_s2(0) +& sum_s2(1))(15, 0)
  }

  io.mul_en_out := mul_en_out_reg(4)
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W))
}
