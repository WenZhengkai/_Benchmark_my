
import chisel3._
import chisel3.util._

class dut(length: Int, bitwidth: Int, window: (Int, Int) => Seq[Int]) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val out = Output(UInt((bitwidth * 2 + length - 1).W))
  })

  // Generate filter coefficients using the provided window function
  val coeffs = window(length, bitwidth).map(_.U(bitwidth.W))

  // Define the delay line to hold past input samples
  val delayLine = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W))))

  // Shift the input through the delay line
  for (i <- length - 1 to 1 by -1) {
    delayLine(i) := delayLine(i - 1)
  }
  delayLine(0) := io.in

  // Compute the products of each delayed sample and its corresponding coefficient
  val mults = for (i <- 0 until length) yield {
    delayLine(i) * coeffs(i)
  }

  // Sum all the products to get the final output
  val result = mults.reduce(_ +& _)

  // Connect the result to the output
  io.out := result
}
