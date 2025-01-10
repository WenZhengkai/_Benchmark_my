
import chisel3._
import chisel3.util._

class dut(length: Int, bitwidth: Int, window: (Int, Int) => Seq[Int]) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val out = Output(UInt((bitwidth * 2 + length - 1).W))
  })

  // Generate filter coefficients using the provided window function
  val coefficients = window(length, bitwidth).map(_.U)

  // Create a delay line to store the past input samples
  val delayLine = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W))))
  
  // Shift the input signal through the delay line
  for (i <- (length - 1) to 1 by -1) {
    delayLine(i) := delayLine(i - 1)
  }
  delayLine(0) := io.in

  // Multiply each delayed sample by its corresponding coefficient
  val mults = VecInit(Seq.tabulate(length)(i => delayLine(i) * coefficients(i)))

  // Sum all the multiplier outputs to compute the final filter output
  val sumResult = mults.reduce(_ +& _)

  // Assign the computed sum (filtered signal) to the output port
  io.out := sumResult
}
