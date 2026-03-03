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

  // Input enable pipeline register (5 bits)
  val mul_en_out_reg = RegInit(0.U(5.W))
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)
  
  // Output enable signal from MSB of enable register
  io.mul_en_out := mul_en_out_reg(4)

  // Input registers for multiplicand and multiplier
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Partial Product Generation
  // temp(i) represents the partial product for bit i of multiplier
  val temp = Wire(Vec(8, UInt(16.W)))
  
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), 
                   Cat(0.U(8.W), mul_a_reg) << i, 
                   0.U(16.W))
  }

  // Pipeline Stage 1: Sum first 4 partial products
  val sum0 = RegInit(0.U(16.W))
  val sum1 = RegInit(0.U(16.W))
  
  sum0 := temp(0) + temp(1)
  sum1 := temp(2) + temp(3)

  // Pipeline Stage 2: Sum next 4 partial products
  val sum2 = RegInit(0.U(16.W))
  val sum3 = RegInit(0.U(16.W))
  
  sum2 := temp(4) + temp(5)
  sum3 := temp(6) + temp(7)

  // Pipeline Stage 3: Sum pairs of partial sums
  val sum01 = RegInit(0.U(16.W))
  val sum23 = RegInit(0.U(16.W))
  
  sum01 := sum0 + sum1
  sum23 := sum2 + sum3

  // Pipeline Stage 4: Final sum
  val mul_out_reg = RegInit(0.U(16.W))
  mul_out_reg := sum01 + sum23

  // Output Assignment
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W))
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
