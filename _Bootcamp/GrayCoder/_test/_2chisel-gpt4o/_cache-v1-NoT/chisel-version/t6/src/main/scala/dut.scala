import chisel3._
import chisel3.util._
import scala.math.pow

// Define the dut module
class dut(val bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  // Task 1: Implement Gray code encoding
  val grayEncoded = io.in ^ (io.in >> 1.U)

  // Task 2: Initialize for Gray code decoding
  var result = io.in

  // Task 3: Implement iterative XOR operations for Gray code decoding
  for (i <- 0 until log2Ceil(bitwidth)) {
    // Perform XOR with right-shifted versions of result
    result = result ^ (result >> (1 << i).U)
  }

  // Task 4: Assign final result to output based on the mode
  when(io.encode) {
    io.out := grayEncoded // Encoding mode
  }.otherwise {
    io.out := result // Decoding mode
  }
}

// Main object to generate the Verilog code
