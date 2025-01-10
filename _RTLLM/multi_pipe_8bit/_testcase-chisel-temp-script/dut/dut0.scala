import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool())
    val mul_a = Input(UInt(8.W))
    val mul_b = Input(UInt(8.W))
    val mul_en_out = Output(Bool())
    val mul_out = Output(UInt(16.W))
  })

  // Input Control
  val mul_en_out_reg = RegInit(false.B)
  when (io.mul_en_in) {
    mul_en_out_reg := true.B
  } .otherwise {
    mul_en_out_reg := false.B
  }

  // Input Registers
  val mul_a_reg = RegEnable(io.mul_a, 0.U, io.mul_en_in)
  val mul_b_reg = RegEnable(io.mul_b, 0.U, io.mul_en_in)

  // Partial Product Generation
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U(16.W))
  }

  // Partial Sum Calculation
  val sum = RegInit(VecInit(Seq.fill(7)(0.U(16.W))))
  for (i <- 0 until 7) {
    sum(i) := temp(i) + Mux(i == 0, 0.U, sum(i-1))
  }

  // Final Product Calculation
  val mul_out_reg = Reg(UInt(16.W))
  when (mul_en_out_reg) {
    mul_out_reg := sum(6) + temp(7)
  } .otherwise {
    mul_out_reg := 0.U
  }

  // Output Assignment
  io.mul_en_out := mul_en_out_reg
  io.mul_out := mul_out_reg
}
