
import chisel3._
import chisel3.util._

class dut(val length: Int, val bitwidth: Int, val window: (Int, Int) => Seq[Int]) extends Module {
  val io = IO(new Bundle {
    val in  = Input(UInt(bitwidth.W))
    val out = Output(UInt((bitwidth * 2 + log2Ceil(length)).W))
  })

  // Generate the filter coefficients using the window function
  val coefficients = window(length, bitwidth).map(_.U)

  // Create a delay line for the past input samples
  val delayLine = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W))))

  // Shift the input through the delay line
  delayLine := VecInit(io.in +: delayLine.init)

  // Multiply each sample in the delay line with its corresponding coefficient
  val mults = (delayLine zip coefficients).map { case (sample, coeff) =>
    sample * coeff
  }

  // Sum all the multiplication results
  val sum = mults.reduce(_ +& _)

  // Connect the result to the output
  io.out := sum
}
