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

  // Gray code encoding: binary to Gray code
  // Gray code = binary XOR (binary right-shifted by 1)
  val grayEncoded = io.in ^ (io.in >> 1.U)

  // Gray code decoding: Gray code to binary
  // This is done iteratively using a power-of-two approach
  val numIterations = log2Ceil(bitwidth)
  
  // Start with the Gray code input
  val decodeIterations = Wire(Vec(numIterations + 1, UInt(bitwidth.W)))
  decodeIterations(0) := io.in
  
  // Iteratively decode by XORing with right-shifted versions
  for (i <- 0 until numIterations) {
    val shiftAmount = pow(2, i).toInt
    decodeIterations(i + 1) := decodeIterations(i) ^ (decodeIterations(i) >> shiftAmount.U)
  }
  
  // Select the final decoded binary output
  val grayDecoded = decodeIterations(numIterations)

  // Output selection based on the 'encode' control signal
  io.out := Mux(io.encode, grayEncoded, grayDecoded)
}
