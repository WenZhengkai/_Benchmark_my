import chisel3._
import chisel3.util._
// get some math functions
import scala.math.{abs, round, cos, Pi, pow}


// our FIR has parameterized window length, IO bitwidth, and windowing function
class MyFir(length: Int, bitwidth: Int, window: (Int, Int) => Seq[Int]) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val out = Output(UInt((bitwidth*2+length-1).W)) // expect bit growth, conservative but lazy
  })

  // calculate the coefficients using the provided window function, mapping to UInts
  val coeffs = window(length, bitwidth).map(_.U)
  
  // create an array holding the output of the delays
  // note: we avoid using a Vec here since we don't need dynamic indexing
  val delays = Seq.fill(length)(Wire(UInt(bitwidth.W))).scan(io.in)( (prev: UInt, next: UInt) => {
    next := RegNext(prev)
    next
  })
  
  // multiply, putting result in "mults"
  val mults = delays.zip(coeffs).map{ case(delay: UInt, coeff: UInt) => delay * coeff }
  
  // add up multiplier outputs with bit growth
  val result = mults.reduce(_+&_)

  // connect output
  io.out := result
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
  //emitVerilog(new MyFir(7, 12, HammingWindow), Array("--target-dir", "generated/HammingWindow"))
}