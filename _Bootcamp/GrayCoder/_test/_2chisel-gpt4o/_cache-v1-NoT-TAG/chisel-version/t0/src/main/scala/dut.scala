import chisel3._
import chisel3.util._
import scala.math._

class dut(bitwidth: Int) extends Module {
  require(bitwidth > 0, "Bitwidth must be positive") // Ensure bitwidth is valid

  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))   // Input signal
    val encode = Input(Bool())         // Encode/Decode control signal
    val out = Output(UInt(bitwidth.W)) // Output signal
  })

  if (bitwidth == 1) {
    // Handle 1-bit special case: Gray code is the same as binary for single bit
    io.out := io.in
  } else {
    // Task 2: Gray Code Encoding Logic
    val encoded = Wire(UInt(bitwidth.W)) // Wire for encoded value
    encoded := io.in ^ (io.in >> 1.U)    // Binary to Gray code conversion

    // Task 3: Gray Code Decoding Logic
    val numSteps = log2Ceil(bitwidth)    // Number of required XOR iterations
    val decoded = Wire(UInt(bitwidth.W)) // Wire for decoded (binary) value
    var current = io.in                  // Start with the input

    // Iterative XOR shift and accumulation to decode Gray code
    for (i <- 0 until numSteps) {
      val shift = (1 << i).U // Calculate power-of-two shift
      current = current ^ (current >> shift)
    }
    decoded := current // Final decoded result

    // Task 4: Operation Mode Selection
    io.out := Mux(io.encode, encoded, decoded) // Select mode based on encode signal
  }
}

// Test the design using Chisel tester (if desired)
