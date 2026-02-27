import chisel3._
import chisel3.util._
import scala.math.pow

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  // Logic for encoding and decoding
  when(io.encode) {
    // Binary to Gray code encoding: output = input XOR (input >> 1)
    io.out := io.in ^ (io.in >> 1.U)
  }.otherwise {
    // Gray code to Binary decoding
    // This uses an iterative approach where we perform XOR operations
    // with shifted versions of intermediate results
    
    // Initialize the first intermediate value with the input
    val iterations = log2Ceil(bitwidth)
    val decodeSteps = Wire(Vec(iterations + 1, UInt(bitwidth.W)))
    decodeSteps(0) := io.in
    
    // Perform the iterative XOR operations
    for (i <- 0 until iterations) {
      val shiftAmount = pow(2, i).toInt
      decodeSteps(i + 1) := decodeSteps(i) ^ (decodeSteps(i) >> shiftAmount.U)
    }
    
    // The final result is the last intermediate value
    io.out := decodeSteps(iterations)
  }
}
