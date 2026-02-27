// package dut

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
    // Binary to Gray code: XOR input with input shifted right by 1
    io.out := io.in ^ (io.in >> 1.U)
  }.otherwise {
    // Gray code to binary conversion
    // This requires iterative XOR operations
    val iterations = log2Ceil(bitwidth)
    val intermediateValues = Wire(Vec(iterations + 1, UInt(bitwidth.W)))
    
    // Initialize with the input Gray code
    intermediateValues(0) := io.in
    
    // Perform the iterative XOR operations for decoding
    for (i <- 0 until iterations) {
      val shiftAmount = pow(2, i).toInt
      intermediateValues(i + 1) := intermediateValues(i) ^ (intermediateValues(i) >> shiftAmount.U)
    }
    
    // The final value is the decoded binary number
    io.out := intermediateValues(iterations)
  }
}
