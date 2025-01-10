import chisel3._
import chisel3.util._

class dut(length: Int, bitwidth: Int, window: (Int, Int) => Seq[Int]) extends Module {
  val io = IO(new Bundle {
    val in  = Input(UInt(bitwidth.W))
    val out = Output(UInt((bitwidth * 2 + length - 1).W))
  })

  // Generate the filter coefficients using the provided window function
  val coefficients = window(length, bitwidth).map(_.U(bitwidth.W))

  // Create a delay line (shift register) for the input samples
  val delays = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W))))

  // Update the delay line with the current input
  for (i <- length - 1 to 1 by -1) {
    delays(i) := delays(i - 1)
  }
  delays(0) := io.in

  // Perform multiplications between delayed samples and coefficients
  val mults = (0 until length).map { i =>
    delays(i) * coefficients(i)
  }

  // Sum the products of the multiplications
  val result = mults.reduce(_ +& _)

  // Connect the final output to the computed sum
  io.out := result
}
