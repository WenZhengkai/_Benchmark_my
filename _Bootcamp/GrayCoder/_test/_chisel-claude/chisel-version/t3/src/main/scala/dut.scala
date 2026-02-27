import chisel3._
import chisel3.util._
import scala.math.pow

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })
  
  when (io.encode) {
    // Binary to Gray encoding: Gray = Binary XOR (Binary >> 1)
    io.out := io.in ^ (io.in >> 1.U)
  } .otherwise {
    // Gray to Binary decoding
    // This is implemented using a sequential XOR approach
    
    // Initialize the first value with the input Gray code
    val steps = log2Ceil(bitwidth)
    val decodingSteps = Wire(Vec(steps + 1, UInt(bitwidth.W)))
    decodingSteps(0) := io.in
    
    // Iteratively compute the binary value
    for (i <- 0 until steps) {
      val shiftAmount = pow(2, i).toInt
      decodingSteps(i + 1) := decodingSteps(i) ^ (decodingSteps(i) >> shiftAmount.U)
    }
    
    // The final value in the sequence is the decoded binary output
    io.out := decodingSteps(steps)
  }
}

// Optional companion object for easier instantiation
object dut {
  def apply(bitwidth: Int): dut = new dut(bitwidth)
}
