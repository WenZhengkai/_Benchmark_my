import chisel3._
import chisel3.util._

class dut(val bitwidth: Int) extends Module {
  require(bitwidth > 0, "Bitwidth must be positive") // Validate bitwidth parameter

  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W)) // Input data
    val encode = Input(Bool())           // Encoding/decoding mode
    val out    = Output(UInt(bitwidth.W)) // Output data
  })

  // Handle 1-bit edge case separately
  if (bitwidth == 1) {
    io.out := io.in // For 1-bit, encoding and decoding are identical
  } else {
    // ----- Task 2: Gray Code Encoding Logic -----
    val encoded = io.in ^ (io.in >> 1.U) // Binary-to-Gray encoding

    // ----- Task 3: Gray Code Decoding Logic -----
    val numSteps = log2Ceil(bitwidth) // Calculate required number of XOR iterations
    var current = io.in               // Decoding starts from input

    // Iterative XOR shift structure
    for (i <- 0 until numSteps) {
      val shift = (1 << i).U
      current = current ^ (current >> shift) // Apply shift and XOR
    }

    val decoded = current // Result of decoding logic

    // ----- Task 4: Operation Mode Selection -----
    io.out := Mux(io.encode, encoded, decoded) // Select based on encode mode
  }
}

