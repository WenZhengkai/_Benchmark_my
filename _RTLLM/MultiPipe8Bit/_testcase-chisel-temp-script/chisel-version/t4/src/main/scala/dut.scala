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

  // 5-bit enable pipeline; output valid comes from MSB
  val mul_en_out_reg = RegInit(0.U(5.W))
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in.asUInt)
  io.mul_en_out := mul_en_out_reg(4)

  // Input registers (update only when input enable is active)
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

  // Pipeline partial sums
  val sum_stage1 = RegInit(VecInit(Seq.fill(4)(0.U(16.W))))
  when(mul_en_out_reg(0)) {
    sum_stage1(0) := temp(0) + temp(1)
    sum_stage1(1) := temp(2) + temp(3)
    sum_stage1(2) := temp(4) + temp(5)
    sum_stage1(3) := temp(6) + temp(7)
  }

  val sum_stage2 = RegInit(VecInit(Seq.fill(2)(0.U(16.W))))
  when(mul_en_out_reg(1)) {
    sum_stage2(0) := sum_stage1(0) + sum_stage1(1)
    sum_stage2(1) := sum_stage1(2) + sum_stage1(3)
  }

  val sum_stage3 = RegInit(0.U(16.W))
  when(mul_en_out_reg(2)) {
    sum_stage3 := sum_stage2(0) + sum_stage2(1)
  }

  // Final product register
  val mul_out_reg = RegInit(0.U(16.W))
  when(mul_en_out_reg(3)) {
    mul_out_reg := sum_stage3
  }

  // Output assignment
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W))
}
