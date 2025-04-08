import chisel3._
import chisel3.util._

class dut(val bitwidth: Int) extends Module {
  // Parameter validation
  require(bitwidth > 0, "Bitwidth must be positive")

  // Define IO Interface
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))   // Input data
    val encode = Input(Bool())         // Mode: true for encode, false for decode
    val out = Output(UInt(bitwidth.W)) // Output data
  })

  // Task 2: Gray Code Encoding Logic
  // Binary to Gray code: encoded = in ^ (in >> 1)
  val encoded = io.in ^ (io.in >> 1.U)

  // Task 3: Gray Code Decoding Logic
  // Iterative XOR structure to decode Gray code to Binary
  val numSteps = log2Ceil(bitwidth) // Number of steps required for decoding
  var current: UInt = io.in        // Initialize current value with input

  (0 until numSteps).foreach { i =>
    // Powers of two shifts
    val shift = (1 << i).U
    current = current ^ (current >> shift) // Update current with shift-and-XOR
  }
  val decoded = current // Final decoded value

  // Task 4: Operation Mode Selection
  // Use Mux to choose between encoded and decoded results
  val output = Mux(io.encode, encoded, decoded)

  // Task 5: Handle edge cases (e.g., single-bit inputs)
  if (bitwidth == 1) {
    io.out := io.in // For 1-bit width, input directly equals output
  } else {
    io.out := output // Normal behavior
  }
}

