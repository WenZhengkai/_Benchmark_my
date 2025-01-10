
import chisel3._
import chisel3.util._

class dut(length: Int, bitwidth: Int, window: (Int, Int) => Seq[Int]) extends Module {
  require(length > 0, "Filter length must be positive")
  require(bitwidth > 0, "Bitwidth must be positive")

  val io = IO(new Bundle {
    val in  = Input(UInt(bitwidth.W))
    val out = Output(UInt((bitwidth * 2 + length - 1).W))
  })

  // Generate filter coefficients using the provided window function
  val coeffs = window(length, bitwidth).map(c => c.U((bitwidth.W)))

  // Create a delay line for input samples
  val taps = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W))))

  // Shift the input sample through the delay line
  for (i <- length - 1 to 1 by -1) {
    taps(i) := taps(i - 1)
  }
  taps(0) := io.in

  // Multiply each tap by its corresponding coefficient
  val mults = for (i <- 0 until length) yield {
    taps(i) * coeffs(i)
  }

  // Sum all the multiplier outputs to create the filter output
  val sum = mults.reduce(_ +& _)

  // Connect the sum to the output, ensuring correct width
  io.out := sum
}
