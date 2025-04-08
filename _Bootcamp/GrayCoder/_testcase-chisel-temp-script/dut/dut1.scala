

import chisel3._
import chisel3.util._

class dut(val bitwidth: Int) extends Module {
  // Ensure the bitwidth is positive
  require(bitwidth > 0, "Bitwidth must be positive")

  // IO definition
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))  // Input binary or Gray code
    val encode = Input(Bool())       // Operation mode: true for encode, false for decode
    val out = Output(UInt(bitwidth.W)) // Output binary or Gray code
  })

  // Edge case: Special handling for single-bit width
  if (bitwidth == 1) {
    // 1-bit Gray code is the same as binary
    io.out := io.in
  } else {
    // Task 2: Gray Code Encoding Logic
    // Compute the Gray code encoding
    val encoded = io.in ^ (io.in >> 1.U)

    // Task 3: Gray Code Decoding Logic
    // Compute the binary decoding from Gray code
    val numSteps = log2Ceil(bitwidth) // Number of steps required for decoding
    var current = io.in               // Intermediate value for iterative decoding

    for (i <- 0 until numSteps) {
      val shift = (1 << i).U       // Powers of two shifts
      current = current ^ (current >> shift) // Shift and XOR for decoding
    }

    // Handle normal operation: Select output based on the encode flag
    // Task 4: Operation Mode Selection
    io.out := Mux(io.encode, encoded, current)
  }
}

// Testbench for the dut module
