

import chisel3._
import chisel3.util._

class dut(val bitwidth: Int) extends Module {
  // Ensure the bitwidth is positive
  require(bitwidth > 0, "Bitwidth must be positive")

  // Define IO interface
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))     // Input data
    val encode = Input(Bool())          // Mode select: true for encoding, false for decoding
    val out = Output(UInt(bitwidth.W))  // Output data
  })

  // Handle one-bit edge case explicitly
  if (bitwidth == 1) {
    // For 1-bit, Gray code is the same as the binary representation
    io.out := io.in
  } else {
    // Gray code encode logic: binary to Gray conversion
    val encoded = io.in ^ (io.in >> 1.U)

    // Gray code decode logic: iterative XOR structure
    val numSteps = log2Ceil(bitwidth)  // Number of XOR iterations needed
    var current = io.in                // Initialize current value for decoding
    for (i <- 0 until numSteps) {
      val shift = (1 << i).U           // Calculate the shift value as powers of 2
      current = current ^ (current >> shift)
    }
    val decoded = current              // Final decoded value after all iterations

    // Output assignment based on mode selection
    io.out := Mux(io.encode, encoded, decoded) // Output encoding or decoding based on `encode` signal
  }
}

