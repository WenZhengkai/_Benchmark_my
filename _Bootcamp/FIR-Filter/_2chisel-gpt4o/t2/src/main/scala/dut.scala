
import chisel3._
import chisel3.util._

class dut(length: Int, bitwidth: Int, window: (Int, Int) => Seq[Int]) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val out = Output(UInt((bitwidth * 2 + length - 1).W))
  })

  // Generate filter coefficients using the provided windowing function
  val coeffs: Seq[UInt] = window(length, bitwidth).map(c => c.U(bitwidth.W))

  // Create a delay line to store the past `length` input samples
  val delayLine = Reg(Vec(length, UInt(bitwidth.W)))

  // Shift the new input into the delay line
  for (i <- length - 1 to 1 by -1) {
    delayLine(i) := delayLine(i - 1)
  }
  delayLine(0) := io.in

  // Perform the multiplications
  val mults = Wire(Vec(length, UInt((2 * bitwidth).W)))
  for (i <- 0 until length) {
    mults(i) := delayLine(i) * coeffs(i)
  }

  // Sum up all multiplier outputs
  val sum = mults.reduce(_ +& _)

  // Connect the sum to the output
  io.out := sum
}
