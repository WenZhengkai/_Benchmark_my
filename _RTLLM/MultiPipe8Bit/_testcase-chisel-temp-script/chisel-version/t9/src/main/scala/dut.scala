import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool())          // Input enable signal
    val mul_a = Input(UInt(8.W))          // 8-bit multiplicand
    val mul_b = Input(UInt(8.W))          // 8-bit multiplier
    val mul_en_out = Output(Bool())       // Output enable signal
    val mul_out = Output(UInt(16.W))      // 16-bit product output
  })

  // Task 1: Input enable logic with a shift register
  val mul_en_out_reg = RegInit(0.U(5.W))  // 5-bit shift register
  when(io.mul_en_in) {
    mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in) // Shift left and sample enable signal
  }.otherwise {
    mul_en_out_reg := Cat(mul_en_out_reg(3, 0), 0.U(1.W))     // Shift left with 0 if not enabled
  }
  io.mul_en_out := mul_en_out_reg(4) // MSB of shift register is the output enable signal

  // Task 2: Input registers for mul_a and mul_b
  val mul_a_reg = RegInit(0.U(8.W))
  val mul_b_reg = RegInit(0.U(8.W))
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Task 3: Generate partial products
  val temp = Wire(Vec(8, UInt(16.W))) // Create 8 partial products, each 16 bits wide
  for (i <- 0 until 8) {
    temp(i) := (mul_a_reg & Fill(8, mul_b_reg(i))) << i // AND with each bit of mul_b_reg and shift left
  }

  // Task 4: Partial sum calculations
  val sum1 = RegInit(0.U(16.W))
  val sum2 = RegInit(0.U(16.W))
  val sum3 = RegInit(0.U(16.W))
  val sum4 = RegInit(0.U(16.W))
  
  when(io.mul_en_in) {
    sum1 := temp(0) + temp(1)
    sum2 := temp(2) + temp(3)
    sum3 := temp(4) + temp(5)
    sum4 := temp(6) + temp(7)
  }

  // Task 5: Final product calculation
  val mul_out_reg = RegInit(0.U(16.W))
  when(io.mul_en_in) {
    mul_out_reg := sum1 + sum2 + sum3 + sum4 // Accumulate all partial sums
  }

  // Task 6: Output assignment
  io.mul_out := Mux(io.mul_en_out, mul_out_reg, 0.U) // Assign output based on enable signal
}

