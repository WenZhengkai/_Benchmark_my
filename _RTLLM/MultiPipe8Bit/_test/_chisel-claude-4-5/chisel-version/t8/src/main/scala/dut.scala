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

  // Enable signal pipeline register (5 bits for 5 pipeline stages)
  val mul_en_out_reg = RegInit(0.U(5.W))
  
  // Input registers
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  
  // Partial product wires (8 partial products, each up to 16 bits)
  val temp = Wire(Vec(8, UInt(16.W)))
  
  // Partial sum registers (4 pipeline stages)
  val sum0 = RegInit(0.U(16.W))
  val sum1 = RegInit(0.U(16.W))
  val sum2 = RegInit(0.U(16.W))
  val sum3 = RegInit(0.U(16.W))
  
  // Final product register
  val mul_out_reg = RegInit(0.U(16.W))

  // Update enable pipeline register
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)
  
  // Output enable signal from MSB of enable register
  io.mul_en_out := mul_en_out_reg(4)

  // Update input registers when enable is active
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Stage 1: Partial Product Generation
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U)
  }

  // Stage 2: First level of addition (sum pairs of partial products)
  sum0 := temp(0) + temp(1)
  sum1 := temp(2) + temp(3)
  
  // Stage 3: Second level of addition
  sum2 := temp(4) + temp(5)
  sum3 := temp(6) + temp(7)
  
  // Stage 4: Third level of addition (combine first two pairs)
  val sum01 = RegInit(0.U(16.W))
  sum01 := sum0 + sum1
  
  // Stage 5: Fourth level of addition (combine last two pairs)
  val sum23 = RegInit(0.U(16.W))
  sum23 := sum2 + sum3
  
  // Stage 6: Final addition
  mul_out_reg := sum01 + sum23

  // Output assignment
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U)
}

// Test harness (optional, for verification)
/*
object dutMain extends App {
  println("Generating Verilog for unsigned 8-bit pipelined multiplier...")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
