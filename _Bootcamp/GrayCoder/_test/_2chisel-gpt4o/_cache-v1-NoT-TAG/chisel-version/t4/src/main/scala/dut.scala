import chisel3._
import chisel3.util._
import scala.math.pow

// dut Module definition
class dut(val bitwidth: Int) extends Module {
  require(bitwidth > 0, "Bitwidth must be positive") // Ensure bitwidth is positive

  // I/O Bundle Definition
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W)) // Input data (binary or Gray code)
    val encode = Input(Bool())      // Operation mode: true for encoding, false for decoding
    val out = Output(UInt(bitwidth.W)) // Output data (encoded or decoded)
  })

  // Special case for 1-bit Gray code
  if (bitwidth == 1) {
    // For 1-bit, Gray code and binary are identical
    io.out := io.in
  } else {
    // Task 2: Gray Code Encoding Logic
    val encoded = io.in ^ (io.in >> 1.U) // Binary to Gray conversion

    // Task 3: Gray Code Decoding Logic
    val numSteps = log2Ceil(bitwidth) // Number of iterations needed
    var current = io.in               // Intermediate value for decoding
    for (i <- 0 until numSteps) {
      val shift = (1 << i).U         // Powers of two shifts
      current = current ^ (current >> shift) // Iterative XOR for decoding
    }
    val decoded = current             // Final value after decoding

    // Task 4: Output Selection Based on Operation Mode
    io.out := Mux(io.encode, encoded, decoded) // Select encoded or decoded result
  }
}

