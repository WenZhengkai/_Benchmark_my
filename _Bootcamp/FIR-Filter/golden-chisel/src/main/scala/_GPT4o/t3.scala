package t3
import chisel3._
import chisel3.util._
import scala.math.{abs, round, cos, Pi, pow}

class MyFir(length: Int, bitwidth: Int, window: (Int, Int) => Seq[Int]) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W)) // Input signal
    val out = Output(UInt((bitwidth * 2 + length - 1).W)) // Filtered output
  })

  // Generate coefficients using the window function
  val coefficients = window(length, bitwidth).map(_.U)

  // Create a delay line to store the last `length` input samples
  val delayLine = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W))))

  // Shift the input through the delay line
  delayLine(0) := io.in
  for (i <- 1 until length) {
    delayLine(i) := delayLine(i - 1)
  }

  // Multiply each delayed sample by its corresponding coefficient
  val mults = Wire(Vec(length, UInt((2 * bitwidth).W)))
  for (i <- 0 until length) {
    mults(i) := delayLine(i) * coefficients(i)
  }

  // Sum all the multiplier outputs
  val sum = mults.reduce(_ +& _)

  // Connect the result to the output
  io.out := sum
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