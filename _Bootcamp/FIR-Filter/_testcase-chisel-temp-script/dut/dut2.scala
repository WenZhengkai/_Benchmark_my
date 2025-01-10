import chisel3._
import chisel3.util._

class dut(length: Int, bitwidth: Int, window: (Int, Int) => Seq[Int]) extends Module {
  val io = IO(new Bundle {
    val in  = Input(UInt(bitwidth.W))
    val out = Output(UInt((bitwidth * 2 + length - 1).W))
  })

  // Generate FIR filter coefficients using the window function
  val coefficients = window(length, bitwidth)

  // Initialize a shift register to operate as the delay line
  val delayLine = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W))))

  // Shift the input signal through the delay line
  for (i <- length - 1 to 1 by -1) {
    delayLine(i) := delayLine(i - 1)
  }
  delayLine(0) := io.in

  // Multiply delayed samples by their corresponding coefficients
  val mults = Wire(Vec(length, UInt((bitwidth * 2).W)))
  for (i <- 0 until length) {
    mults(i) := delayLine(i) * coefficients(i).U
  }

  // Sum all multiplied results
  val sum = mults.reduce(_ +& _)

  // Connect the summed result to the output, adjusting for potential bit growth
  io.out := sum
}

