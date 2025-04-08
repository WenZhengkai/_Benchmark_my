import chisel3._
import chisel3.util._

class dut(bitwidth: Int) extends Module {
  // Validate that the bitwidth is greater than 0
  require(bitwidth > 0, "Bitwidth must be positive")

  // Define the IO interface
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))  // Input data
    val encode = Input(Bool())        // Operation mode: true for encoding, false for decoding
    val out = Output(UInt(bitwidth.W)) // Output data
  })

  // Edge case for 1-bit width
  if (bitwidth == 1) {
    io.out := io.in  // No transformation required for single-bit Gray code
  } else {
    // Gray Code Encoding: Binary to Gray conversion
    val encoded = io.in ^ (io.in >> 1.U)

    // Gray Code Decoding: Gray to Binary conversion
    val numSteps = log2Ceil(bitwidth) // Number of iterations based on bitwidth
    var current = io.in               // Initialize intermediate variable for decoding
    for (i <- 0 until numSteps) {
      val shift = (1 << i).U          // Compute the shift amount (powers of two)
      current = current ^ (current >> shift)
    }

    // Select the output based on the `encode` signal
    io.out := Mux(io.encode, encoded, current)
  }
}

