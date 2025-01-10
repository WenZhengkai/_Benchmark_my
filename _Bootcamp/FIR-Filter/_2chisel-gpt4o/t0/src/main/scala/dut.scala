
import chisel3._
import chisel3.util._

class dut(val length: Int, val bitwidth: Int, window: (Int, Int) => Seq[Int]) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val out = Output(UInt((bitwidth * 2 + length - 1).W))
  })

  // Generate the filter coefficients using the provided window function
  val coefficients: Seq[UInt] = window(length, bitwidth).map(coef => coef.U(bitwidth.W))

  // Create a delay line for the input samples
  val delayLine = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W))))
  
  // Shift the input through the delay line
  for (i <- length - 1 to 1 by -1) {
    delayLine(i) := delayLine(i - 1)
  }
  delayLine(0) := io.in

  // Compute the multiplier outputs
  val mults = for (i <- 0 until length) yield {
    delayLine(i) * coefficients(i)
  }

  // Sum up the multiplier outputs
  val sum = mults.reduce(_ +& _)

  // Connect the sum to the output
  io.out := sum
}
