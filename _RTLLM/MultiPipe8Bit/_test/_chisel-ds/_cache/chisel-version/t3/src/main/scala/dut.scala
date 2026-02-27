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

  // Pipeline stages
  val mul_en_out_reg = RegInit(0.U(5.W))
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  val temp = Wire(Vec(8, UInt(16.W)))
  val sum = Reg(Vec(4, UInt(16.W)))
  val mul_out_reg = RegInit(0.U(16.W))

  // Input Control
  when(io.mul_en_in) {
    mul_en_out_reg := Cat(mul_en_out_reg(3, 0), 1.U(1.W))
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }.otherwise {
    mul_en_out_reg := Cat(mul_en_out_reg(3, 0), 0.U(1.W))
  }

  // Output enable signal
  io.mul_en_out := mul_en_out_reg(4)

  // Partial Product Generation
  for (i <- 0 until 8) {
    temp(i) := Mux(io.mul_b(i), mul_a_reg << i, 0.U(16.W))
  }

  // Partial Sum Calculation (Pipeline Stage 1)
  sum(0) := temp(0) + temp(1)
  sum(1) := temp(2) + temp(3)
  sum(2) := temp(4) + temp(5)
  sum(3) := temp(6) + temp(7)

  // Final Product Calculation (Pipeline Stage 2)
  mul_out_reg := sum(0) + sum(1) + sum(2) + sum(3)

  // Output Assignment
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W))
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
