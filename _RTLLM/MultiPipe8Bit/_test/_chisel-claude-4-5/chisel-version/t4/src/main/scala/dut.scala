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

  // Input enable signal pipeline (5-bit shift register)
  val mul_en_out_reg = RegInit(0.U(5.W))
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)
  io.mul_en_out := mul_en_out_reg(4)

  // Input registers
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Partial product generation (8 partial products for 8-bit multiplier)
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), Cat(0.U(8.W), mul_a_reg) << i, 0.U(16.W))
  }

  // Pipeline stage 1: Add first 2 partial products
  val sum0 = RegInit(0.U(16.W))
  sum0 := temp(0) + temp(1)

  // Pipeline stage 2: Add next 2 partial products
  val sum1 = RegInit(0.U(16.W))
  sum1 := temp(2) + temp(3)

  // Pipeline stage 3: Add next 2 partial products
  val sum2 = RegInit(0.U(16.W))
  sum2 := temp(4) + temp(5)

  // Pipeline stage 4: Add last 2 partial products
  val sum3 = RegInit(0.U(16.W))
  sum3 := temp(6) + temp(7)

  // Pipeline stage 5: Add all partial sums to get final result
  val sum4 = RegInit(0.U(16.W))
  sum4 := sum0 + sum1

  val sum5 = RegInit(0.U(16.W))
  sum5 := sum2 + sum3

  val mul_out_reg = RegInit(0.U(16.W))
  mul_out_reg := sum4 + sum5

  // Output assignment
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W))
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
