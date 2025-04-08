import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool())        // Input enable signal
    val mul_a = Input(UInt(8.W))        // Input multiplicand
    val mul_b = Input(UInt(8.W))        // Input multiplier
    val mul_en_out = Output(Bool())     // Output enable signal
    val mul_out = Output(UInt(16.W))    // Product output
  })

  // Registers for input enable signal pipelining
  val mul_en_out_reg = RegInit(0.U(5.W)) // 5-bit register for staging enable signal
  
  // Registers to store multiplicand and multiplier
  val mul_a_reg = RegEnable(io.mul_a, 0.U, io.mul_en_in)
  val mul_b_reg = RegEnable(io.mul_b, 0.U, io.mul_en_in)

  // Pipeline registers for partial sums
  val sum = Reg(Vec(8, UInt(16.W))) // 8 stages of intermediate sums (partial products)

  // Logic to update `mul_en_out_reg`
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in)

  // Partial product generation and accumulation in pipeline
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U) // Compute partial product
    sum(i) := RegNext(if (i == 0) temp(i) else sum(i - 1) + temp(i)) // Accumulate sums
  }

  // Final product obtained from the last stage of the pipeline
  val mul_out_reg = RegNext(sum(7)) // Final sum (product)

  // Assign outputs
  io.mul_en_out := mul_en_out_reg(4) // Most significant bit of mul_en_out_reg
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U) // Output product if enable is high

}

