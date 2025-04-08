import chisel3._
import chisel3.util._
import scala.math.pow

class dut(val bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out    = Output(UInt(bitwidth.W))
  })

  // Task 1: Implement Gray code encoding logic
  when(io.encode) {
    // Perform Gray code encoding when encode is true
    io.out := io.in ^ (io.in >> 1.U)
  }.otherwise {
    // Task 2: Initialize for Gray code decoding logic
    // Initialize result with the input data
    var result = io.in

    // Task 3: Implement iterative XOR operations for decoding
    val width = log2Ceil(bitwidth)
    for (i <- 0 until width) {
      result = result ^ (result >> (1 << i).U)
    }

    // Task 4: Assign the final decoded result to the output
    io.out := result
  }
}

