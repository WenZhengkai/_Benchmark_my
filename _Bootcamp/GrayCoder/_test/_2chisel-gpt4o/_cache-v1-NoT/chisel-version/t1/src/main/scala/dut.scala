import chisel3._
import chisel3.util._

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out    = Output(UInt(bitwidth.W))
  })

  // Task 1: Gray code encoding logic
  when(io.encode) {
    // Perform the Gray code encoding: io.out := io.in ^ (io.in >> 1.U)
    io.out := io.in ^ (io.in >> 1.U)
  }.otherwise {
    // Task 2: Initialization for Gray code decoding
    var result = io.in

    // Task 3: Iterative XOR operations for Gray code decoding
    for (i <- 0 until log2Ceil(bitwidth)) {
      // Update result by XORing with right-shifted versions of itself
      result = result ^ (result >> (1 << i).U)
    }

    // Task 4: Assign the final decoded result to the output
    io.out := result
  }
}

// Instantiate the module for simulation or hardware generation
