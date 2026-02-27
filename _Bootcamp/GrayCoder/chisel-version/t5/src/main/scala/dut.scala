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
    // This is implemented through iterative XOR operations
    val iterations = log2Ceil(bitwidth)
    
    // Initialize with the input Gray code
    val intermediate = Wire(Vec(iterations + 1, UInt(bitwidth.W)))
    intermediate(0) := io.in
    
    // Perform iterative XOR operations for decoding
    for (i <- 0 until iterations) {
      val shiftAmount = pow(2, i).toInt
      intermediate(i + 1) := intermediate(i) ^ (intermediate(i) >> shiftAmount.U)
    }
    
    // The final result is the last intermediate value
    io.out := intermediate(iterations)
  }
}
