import chisel3._
import chisel3.util._

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  when(io.encode) {
    // Task 1: Gray code encoding
    // Encoding a binary number to Gray code
    io.out := io.in ^ (io.in >> 1.U)
  } .otherwise {
    // Task 2: Initialize decoding logic
    // Setup for decoding the Gray code back to binary
    var result = io.in

    // Task 3: Iterative XOR operation for decoding
    // Use a `for` loop to perform operations required for decoding
    for (i <- 0 until log2Ceil(bitwidth)) {
      result = result ^ (result >> (1 << i).U)
    }

    // Task 4: Assign the decoded result to the output
    // Assign final decoding result to output when `encode` is false
    io.out := result
  }
}

// Generate the Verilog for this design
