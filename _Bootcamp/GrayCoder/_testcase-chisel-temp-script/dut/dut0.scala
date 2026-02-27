// package gray_encoder_decoder

import chisel3._
import chisel3.util._
import scala.math.pow

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  // Gray code encoding logic (binary to Gray)
  // Formula: gray = binary ^ (binary >> 1)
  val grayEncoded = io.in ^ (io.in >> 1.U)

  // Gray code decoding logic (Gray to binary)
  // This is implemented iteratively
  val numIters = log2Ceil(bitwidth)
  val decodeIters = Wire(Vec(numIters + 1, UInt(bitwidth.W)))
  
  // Initialize with input Gray code
  decodeIters(0) := io.in
  
  // Iterative decoding process
  for (i <- 0 until numIters) {
    val shiftAmount = pow(2, i).toInt
    decodeIters(i + 1) := decodeIters(i) ^ (decodeIters(i) >> shiftAmount.U)
  }
  
  // Final decoded binary value
  val binaryDecoded = decodeIters(numIters)

  // Select output based on encode flag
  io.out := Mux(io.encode, grayEncoded, binaryDecoded)
}
