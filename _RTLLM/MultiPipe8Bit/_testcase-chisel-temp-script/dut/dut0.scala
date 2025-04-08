import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in  = Input(Bool())       // Input enable signal
    val mul_a      = Input(UInt(8.W))   // Multiplicand (8 bits)
    val mul_b      = Input(UInt(8.W))   // Multiplier (8 bits)
    val mul_en_out = Output(Bool())     // Output enable signal
    val mul_out    = Output(UInt(16.W)) // Product output (16 bits)
  })

  // Task 1: Input control logic
  val mul_en_out_reg = RegInit(0.U(5.W)) // 5-bit shift register for enable signal
  mul_en_out_reg := Cat(mul_en_out_reg(3, 0), io.mul_en_in) // Shift in another bit
  val mul_en_out = mul_en_out_reg(4) // MSB of the shift register is the output enable
  io.mul_en_out := mul_en_out

  // Task 2: Input registers for mul_a and mul_b
  val mul_a_reg = RegInit(0.U(8.W)) // 8-bit register for multiplicand
  val mul_b_reg = RegInit(0.U(8.W)) // 8-bit register for multiplier
  when(io.mul_en_in) {
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }

  // Task 3: Generate partial products
  val temp = Wire(Vec(8, UInt(16.W))) // Wires for partial products
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), mul_a_reg << i, 0.U) // Calculate partial products
  }

  // Task 4: Partial sum calculations using pipelining
  // Pipeline registers to store intermediate sums
  val sum1 = RegNext(temp(0) + temp(1))       // First stage sum
  val sum2 = RegNext(temp(2) + temp(3))       // Second stage sum
  val sum3 = RegNext(temp(4) + temp(5))       // Third stage sum
  val sum4 = RegNext(temp(6) + temp(7))       // Fourth stage sum

  val sumA = RegNext(sum1 + sum2)             // Add first two sums
  val sumB = RegNext(sum3 + sum4)             // Add next two sums

  // Task 5: Final product
  val mul_out_reg = RegNext(sumA + sumB)     // Final accumulation of all partial sums
  io.mul_out := Mux(mul_en_out, mul_out_reg, 0.U) // Output product, gated by enable signal

  // Task 6: Output Assignment
  // io.mul_en_out is already assigned above from mul_en_out_reg
  // io.mul_out is assigned above based on enable signal
}

