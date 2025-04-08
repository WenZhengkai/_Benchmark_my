import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in  = Input(Bool())         // Input enable signal
    val mul_a      = Input(UInt(8.W))     // 8-bit multiplicand
    val mul_b      = Input(UInt(8.W))     // 8-bit multiplier
    val mul_en_out = Output(Bool())       // Output enable signal
    val mul_out    = Output(UInt(16.W))   // 16-bit product output
  })

  // Task 1: Input enable control logic
  val mul_en_out_reg = RegInit(0.U(5.W)) // 5-bit shift register for enable signal
  when(io.mul_en_in) {
    mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in) // Shift left and insert new enable signal
  } .otherwise {
    mul_en_out_reg := Cat(mul_en_out_reg(3, 0), 0.U(1.W)) // Shift left with zero when input enable is inactive
  }
  val mul_en_out = mul_en_out_reg(4) // MSB of the shift register
  io.mul_en_out := mul_en_out        // Output assignment for mul_en_out

  // Task 2: Input registers
  val mul_a_reg = RegInit(0.U(8.W)) // Register for multiplicand
  val mul_b_reg = RegInit(0.U(8.W)) // Register for multiplier
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a // Latch multiplicand when enable is active
    mul_b_reg := io.mul_b // Latch multiplier when enable is active
  }

  // Task 3: Partial product generation
  val temp = Wire(Vec(8, UInt(16.W))) // Vec to store 8 partial products
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U) // Generate shifted partial products
  }

  // Task 4: Partial sum calculation (using pipelined registers)
  val sum1 = RegInit(0.U(16.W))
  val sum2 = RegInit(0.U(16.W))
  val sum3 = RegInit(0.U(16.W))
  val sum4 = RegInit(0.U(16.W))

  // Stage 1: Add partial products 0 and 1, partial products 2 and 3
  when(io.mul_en_in) {
    sum1 := temp(0) + temp(1)
    sum2 := temp(2) + temp(3)
  }

  // Stage 2: Add partial products 4 and 5, partial products 6 and 7
  when(io.mul_en_in) {
    sum3 := temp(4) + temp(5)
    sum4 := temp(6) + temp(7)
  }

  // Task 5: Accumulate sums to get the final product
  val mul_out_reg = RegInit(0.U(16.W)) // Register for the final product
  when(io.mul_en_in) {
    mul_out_reg := (sum1 + sum2) + (sum3 + sum4) // Final accumulation
  }

  // Task 6: Output assignment
  io.mul_out := Mux(mul_en_out, mul_out_reg, 0.U) // Assign output based on enable signal
}
