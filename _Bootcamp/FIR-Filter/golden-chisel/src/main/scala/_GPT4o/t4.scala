package t4

import chisel3._
import chisel3.util._
import scala.math.{abs, round, cos, Pi, pow}

class MyFir(length: Int, bitwidth: Int, window: (Int, Int) => Seq[Int]) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W)) // Input signal (bitwidth bits wide)
    val out = Output(UInt((bitwidth * 2 + length - 1).W)) // Filtered output
  })

  // Step 1: Generate coefficients using the provided window function
  val coeffs = window(length, bitwidth).map(c => c.U(bitwidth.W))

  // Step 2: Create a delay line for the input samples
  val delayLine = RegInit(VecInit(Seq.fill(length)(0.U(bitwidth.W))))
  delayLine(0) := io.in
  for (i <- 1 until length) {
    delayLine(i) := delayLine(i - 1)
  }

  // Step 3: Perform multiplication for each delayed sample and coefficient
  val mults = Wire(Vec(length, UInt((bitwidth * 2).W)))
  for (i <- 0 until length) {
    mults(i) := delayLine(i) * coeffs(i)
  }

  // Step 4: Sum all the multiplication results
  val sum = mults.reduce(_ +& _) // Use +& for proper bitwidth handling during summation

  // Step 5: Connect the sum to the output
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