import chisel3._
import chisel3.util._

// Define the MyFir class
class dut(val length: Int, val bitwidth: Int, val window: (Int, Int) => Seq[Int]) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val out = Output(UInt((bitwidth * 2 + length - 1).W))
  })

  // Calculate the filter coefficients using the provided window function
  val coefficients = window(length, bitwidth).map(_.U(bitwidth.W))

  // Create a delay line to hold the past `length` input samples
  val delayLine = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W))))

  // Shift the input signal through the delay line
  delayLine(0) := io.in
  for (i <- 1 until length) {
    delayLine(i) := delayLine(i - 1)
  }

  // Multiply each delayed sample by its corresponding coefficient
  val mults = Wire(Vec(length, UInt((bitwidth * 2).W)))
  for (i <- 0 until length) {
    mults(i) := delayLine(i) * coefficients(i)
  }

  // Sum all the multiplication results
  val sum = mults.reduce(_ +& _)

  // Assign the sum to the output port
  io.out := sum
}
