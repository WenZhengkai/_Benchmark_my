// package graycode

import chisel3._
import chisel3.util._
import scala.math.pow

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  // When encode is true, convert binary to Gray code
  // When encode is false, convert Gray code to binary
  when(io.encode) {
    // Binary to Gray code conversion: out = in ^ (in >> 1)
    io.out := io.in ^ (io.in >> 1.U)
  }.otherwise {
    // Gray code to binary conversion
    // This is more complex and requires iterative XOR operations
    
    // Initialize with the input value
    val decodingSteps = log2Ceil(bitwidth)
    val intermediateValues = Wire(Vec(decodingSteps + 1, UInt(bitwidth.W)))
    
    // First intermediate value is the input
    intermediateValues(0) := io.in
    
    // Perform iterative XOR operations for decoding
    for (i <- 0 until decodingSteps) {
      val shiftAmount = pow(2, i).toInt
      intermediateValues(i + 1) := intermediateValues(i) ^ (intermediateValues(i) >> shiftAmount.U)
    }
    
    // Final output is the last computed intermediate value
    io.out := intermediateValues(decodingSteps)
  }
}
