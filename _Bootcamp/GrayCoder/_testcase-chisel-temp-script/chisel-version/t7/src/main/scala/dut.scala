import chisel3._
import chisel3.util._
import scala.math.pow

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  when(io.encode) {
    // Binary to Gray code encoding
    io.out := io.in ^ (io.in >> 1.U)
  }.otherwise {
    // Gray code to Binary decoding
    // This requires a sequential process
    val numIterations = log2Ceil(bitwidth)
    
    // Initialize with the input value
    val intermediateValues = Wire(Vec(numIterations + 1, UInt(bitwidth.W)))
    intermediateValues(0) := io.in
    
    // Iteratively compute the binary value
    for (i <- 0 until numIterations) {
      val shiftAmount = pow(2, i).toInt
      intermediateValues(i + 1) := intermediateValues(i) ^ (intermediateValues(i) >> shiftAmount.U)
    }
    
    // The final value is the binary representation
    io.out := intermediateValues(numIterations)
  }
}
