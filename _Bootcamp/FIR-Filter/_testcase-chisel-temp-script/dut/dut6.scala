import chisel3._
import chisel3.util._

class dut(length: Int, bitwidth: Int, window: (Int, Int) => Seq[Int]) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val out = Output(UInt((bitwidth * 2 + length - 1).W))
  })

  // Generate coefficients using the window function
  val coefficients = window(length, bitwidth).map(c => c.U(bitwidth.W))

  // Create a delay line for the FIR filter
  val delayLine = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W))))

  // Shift the input through the delay line
  for (i <- length - 1 to 1 by -1) {
    delayLine(i) := delayLine(i - 1)
  }
  delayLine(0) := io.in

  // Perform multiplication of delayed samples with coefficients
  val mults = coefficients.zip(delayLine).map { case (coef, sample) =>
    coef * sample
  }

  // Sum the products to get the filter output
  val sum = mults.reduce(_ +& _)

  // Connect the sum to the output
  io.out := sum
}
