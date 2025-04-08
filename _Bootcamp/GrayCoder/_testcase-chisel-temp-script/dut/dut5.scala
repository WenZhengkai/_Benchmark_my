import chisel3._
import chisel3.util._
import scala.math.log10Ceil

class dut(val bitwidth: Int) extends Module {
  require(bitwidth > 0, "Bitwidth must be positive")

  // IO definition
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))  // Input signal (binary or Gray code)
    val encode = Input(Bool())        // Operation mode, true = encode, false = decode
    val out = Output(UInt(bitwidth.W)) // Output signal (binary or Gray code)
  })

  // Task 2: Gray Code Encoding Logic
  val encoded = Wire(UInt(bitwidth.W)) // Wire for encoded (binary to Gray)
  encoded := io.in ^ (io.in >> 1.U)

  // Task 3: Gray Code Decoding Logic
  val numSteps = log2Ceil(bitwidth) // Number of steps required for decoding
  val decoded = Wire(UInt(bitwidth.W)) // Wire for decoded (Gray to binary)
  var current = io.in // Initialize intermediate value

  for (i <- 0 until numSteps) {
    val shift = (1 << i).U // Powers of two shifts
    current = current ^ (current >> shift) // Iterative XOR for decoding
  }
  decoded := current

  // Task 4: Operation Mode Selection
  // Choose encoded or decoded output based on io.encode
  io.out := Mux(io.encode, encoded, decoded)

  // Task 5: Edge Case Handling
  // Special case for bitwidth = 1, direct connection for single bit
  if (bitwidth == 1) {
    io.out := io.in
  }
}


