package t2
import chisel3._
import chisel3.util._
import scala.math.{abs, round, cos, Pi, pow}

/** MyFir: A parameterized FIR filter in Chisel
  *
  * @param length   Number of taps (coefficients) in the FIR filter
  * @param bitwidth Bitwidth of the input data and coefficients
  * @param window   Function to generate scaled filter coefficients
  */
class MyFir(length: Int, bitwidth: Int, window: (Int, Int) => Seq[Int]) extends Module {
  val io = IO(new Bundle {
    val in  = Input(UInt(bitwidth.W)) // Input signal
    val out = Output(UInt((bitwidth * 2 + length - 1).W)) // Filtered output
  })

  // 1. Coefficient Calculation
  val coeffs = window(length, bitwidth).map(c => c.U(bitwidth.W)) // Generate coefficients as UInts

  // 2. Delay Line Creation
  val delayLine = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W)))) // Initialize delay line with zeros

  // Update delay line: shift the inputs through the delay registers
  for (i <- length - 1 to 1 by -1) {
    delayLine(i) := delayLine(i - 1)
  }
  delayLine(0) := io.in // Load the new input into the first register

  // 3. Multiplication
  val mults = coeffs.zip(delayLine).map { case (c, d) => c * d } // Multiply coefficients with delayed samples

  // 4. Summation
  val sum = mults.reduce(_ +& _) // Sum the multiplier outputs

  // 5. Output Connection
  io.out := sum // Assign the sum to the output
}

object AddMain extends App {
// simple triangular window
val TriangularWindow: (Int, Int) => Seq[Int] = (length, bitwidth) => {
  val raw_coeffs = (0 until length).map( (x:Int) => 1-abs((x.toDouble-(length-1)/2.0)/((length-1)/2.0)) )
  val scaled_coeffs = raw_coeffs.map( (x: Double) => round(x * pow(2, bitwidth)).toInt)
  scaled_coeffs
}

// Hamming window
val HammingWindow: (Int, Int) => Seq[Int] = (length, bitwidth) => {
  val raw_coeffs = (0 until length).map( (x: Int) => 0.54 - 0.46*cos(2*Pi*x/(length-1)))
  val scaled_coeffs = raw_coeffs.map( (x: Double) => round(x * pow(2, bitwidth)).toInt)
  scaled_coeffs
}

  println("Generating the adder hardware")
  emitVerilog(new MyFir(7, 12, TriangularWindow), Array("--target-dir", "generated/TriangularWindow"))
  emitVerilog(new MyFir(7, 12, HammingWindow), Array("--target-dir", "generated/HammingWindow"))
}