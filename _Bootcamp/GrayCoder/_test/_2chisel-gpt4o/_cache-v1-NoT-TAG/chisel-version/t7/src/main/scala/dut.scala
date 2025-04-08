import chisel3._
import chisel3.util._
import scala.math.pow

class dut(bitwidth: Int) extends Module {
  // Validate that the bitwidth is positive
  require(bitwidth > 0, "Bitwidth must be positive")

  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))  // Input data (binary or gray)
    val encode = Input(Bool())        // Mode selection: true => encode(Binary to Gray), false => decode(Gray to Binary)
    val out = Output(UInt(bitwidth.W)) // Output data
  })

  // Task 2: Gray Code Encoding
  // Binary-to-Gray encoding logic: Gray = Binary XOR (Binary >> 1)
  val encoded = Wire(UInt(bitwidth.W))
  encoded := io.in ^ (io.in >> 1.U)

  // Task 3: Gray Code Decoding
  // For Gray-to-Binary decoding, use iterative XOR logic
  val decoded = Wire(UInt(bitwidth.W))
  if (bitwidth == 1) {
    // Special case for a single bit (Gray code is the same as binary)
    decoded := io.in
  } else {
    // General case for multi-bit gray code decoding
    val numSteps = log2Ceil(bitwidth) // Number of iterative steps
    var current = io.in              // Start with the input Gray code
    for (i <- 0 until numSteps) {
      val shift = (1 << i).U         // Calculate the shift value for the current iteration
      current = current ^ (current >> shift) // Apply XOR with the shifted value
    }
    decoded := current
  }

  // Task 4: Operation Mode Selection
  // Use a Mux to select encoded result (when io.encode = true) or decoded result (when io.encode = false)
  
  if (bitwidth == 1) { 
 io.out :=io.in
}
  io.out := Mux(io.encode, encoded, decoded) // Select based on mode

}
