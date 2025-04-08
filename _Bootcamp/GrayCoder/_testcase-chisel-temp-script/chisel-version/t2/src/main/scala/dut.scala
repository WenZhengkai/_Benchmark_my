import chisel3._
import chisel3.util._
import scala.math.pow

class dut(val bitwidth: Int) extends Module {
  // Parameter validation
  require(bitwidth > 0, "Bitwidth must be positive")

  // Define IO interface
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))  // Input data
    val encode = Input(Bool())        // Encoding or decoding mode
    val out = Output(UInt(bitwidth.W)) // Output data
  })

  // Handle special case for 1-bit input
  if (bitwidth == 1) {
    // For 1-bit, Gray encoding and decoding result is the same as input
    io.out := io.in
  } else {
    // Normal logic for multi-bit Gray encoding and decoding

    // Task 2: Gray code encoding logic
    val encoded = io.in ^ (io.in >> 1.U) // XOR with shifted version of itself

    // Task 3: Gray code decoding logic
    val numSteps = log2Ceil(bitwidth) // Number of iterations needed
    var current = io.in               // Intermediate value for iterative decoding
    for (i <- 0 until numSteps) {
      val shift = (1 << i).U          // Powers of 2 for bit shifting
      current = current ^ (current >> shift) // Iterative XOR process
    }
    val decoded = current             // The fully decoded result after loop

    // Task 4: Output selection based on operation mode
    io.out := Mux(io.encode, encoded, decoded) // Select between encoding and decoding output
  }
}

