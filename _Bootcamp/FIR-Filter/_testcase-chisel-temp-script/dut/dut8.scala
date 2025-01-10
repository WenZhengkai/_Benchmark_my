import chisel3._
import chisel3.util._

class dut(length: Int, bitwidth: Int, window: (Int, Int) => Seq[Int]) extends Module {
  // Define the I/O for the FIR filter
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val out = Output(UInt((bitwidth * 2 + length - 1).W))
  })

  // Generate the filter coefficients using the provided windowing function
  val coefficients = window(length, bitwidth).map(_.asUInt(bitwidth.W))

  // Create a delay line to hold the past 'length' samples
  val delayLine = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W))))

  // Shift the delay line to make room for the new input sample
  for (i <- length - 1 to 1 by -1) {
    delayLine(i) := delayLine(i - 1)
  }
  delayLine(0) := io.in

  // Multiply delayed samples with their corresponding coefficients
  // Store the products in the 'mults' sequence
  val mults = Wire(Vec(length, UInt((bitwidth * 2).W)))
  for (i <- 0 until length) {
    mults(i) := delayLine(i) * coefficients(i)
  }

  // Sum all the multiplication results
  val sum = mults.reduce(_ +& _)

  // Assign the summed result to the output
  io.out := sum
}
