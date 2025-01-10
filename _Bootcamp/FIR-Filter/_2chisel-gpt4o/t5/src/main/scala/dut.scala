
import chisel3._
import chisel3.util._

// Define the MyFir module with parameters for length, bitwidth, and window function.
class dut(val length: Int, val bitwidth: Int, window: (Int, Int) => Seq[Int]) extends Module {
  // Define the input/output interface.
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val out = Output(UInt((bitwidth * 2 + length - 1).W))
  })

  // Generate the filter coefficients using the provided window function.
  val coefficients = window(length, bitwidth).map(_.U(bitwidth.W))
  
  // Create a Vec of delay registers to store past input samples.
  val delayLine = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W))))

  // Shift the input signal through the delay line.
  for (i <- (length - 1) to 1 by -1) {
    delayLine(i) := delayLine(i - 1)
  }
  delayLine(0) := io.in

  // Multiply each delayed sample by its corresponding coefficient.
  val mults = for (i <- 0 until length) yield {
    delayLine(i) * coefficients(i)
  }

  // Sum all the multiplier outputs to compute the final filter output.
  val sum = mults.reduce(_ +& _)

  // Connect the computed sum to the output port.
  io.out := sum
}
