

import chisel3._
import chisel3.util._

/**
 * GrayCoder Module
 * A digital circuit that performs encoding of binary numbers to Gray code,
 * and decoding of Gray code to binary numbers, controlled by a boolean signal.
 *
 * @param bitwidth Specifies the width of input/output data in bits.
 */
class dut(val bitwidth: Int) extends Module {
  require(bitwidth > 0, "Bitwidth must be greater than 0")

  // Input/Output interface
  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W))   // Input data to be encoded/decoded
    val encode = Input(Bool())            // Operation mode: true for encode, false for decode
    val out    = Output(UInt(bitwidth.W)) // Output data after encoding/decoding
  })

  // Encoding Mode: Binary to Gray code
  val encoded = io.in ^ (io.in >> 1.U)

  // Decoding Mode: Gray code to Binary
  val decoded = Wire(UInt(bitwidth.W))
  val result = RegInit(0.U(bitwidth.W)) // Register to store intermediate decoding results

  // Sequential decoding logic using XOR operations
  when(io.encode === false.B) {
    result := io.in // Initialize the process with input Gray code
    for (i <- 1 until bitwidth) {
      result := result ^ (io.in >> i.U)
    }
  }

  // Output logic: Select between encoded and decoded values
  io.out := Mux(io.encode, encoded, result)
}


