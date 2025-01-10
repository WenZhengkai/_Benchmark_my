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

  // Pipeline registers and intermediate storage
  val mul_en_out_reg = RegInit(0.U(2.W))
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  
  // Calculate partial products
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), (mul_a_reg << i).asUInt(), 0.U)
  }
  
  // Sum the partial products
  val sum = RegInit(VecInit(Seq.fill(8)(0.U(16.W))))
  sum(0) := temp(0)
  for (i <- 1 until 8) {
    sum(i) := sum(i-1) + temp(i)
  }

  // Final product
  val mul_out_reg = RegInit(0.U(16.W))

  // Clock synchronous operations
  when(io.mul_en_in) {
    mul_en_out_reg := Cat(mul_en_out_reg(0), io.mul_en_in)
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }
  
  mul_out_reg := sum(7)
  io.mul_out := Mux(mul_en_out_reg(1), mul_out_reg, 0.U)
  io.mul_en_out := mul_en_out_reg(1)
}
