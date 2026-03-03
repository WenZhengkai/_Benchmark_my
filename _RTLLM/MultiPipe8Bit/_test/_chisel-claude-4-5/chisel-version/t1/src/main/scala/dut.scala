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

  // Enable signal pipeline register (5 bits for 5 pipeline stages)
  val mul_en_out_reg = RegInit(0.U(5.W))
  
  // Shift enable signal through pipeline
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)
  
  // Output enable is the MSB of enable register
  io.mul_en_out := mul_en_out_reg(4)

  // Input registers for multiplicand and multiplier
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Partial product generation (8 partial products)
  val temp = Wire(Vec(8, UInt(8.W)))
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg, 0.U(8.W))
  }

  // Pipeline stage 1: Sum first two partial products
  val sum1 = RegInit(0.U(16.W))
  sum1 := Cat(temp(1), 0.U(1.W)) + Cat(0.U(1.W), temp(0))

  // Pipeline stage 2: Add next two partial products
  val sum2 = RegInit(0.U(16.W))
  sum2 := sum1 + (Cat(temp(3), 0.U(3.W)) + Cat(0.U(1.W), temp(2), 0.U(2.W)))

  // Pipeline stage 3: Add next two partial products
  val sum3 = RegInit(0.U(16.W))
  sum3 := sum2 + (Cat(temp(5), 0.U(5.W)) + Cat(0.U(1.W), temp(4), 0.U(4.W)))

  // Pipeline stage 4: Add last two partial products
  val sum4 = RegInit(0.U(16.W))
  sum4 := sum3 + (Cat(temp(7), 0.U(7.W)) + Cat(0.U(1.W), temp(6), 0.U(6.W)))

  // Final product register
  val mul_out_reg = RegInit(0.U(16.W))
  mul_out_reg := sum4

  // Output assignment based on enable signal
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U(16.W))
}

// Generate Verilog
/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
