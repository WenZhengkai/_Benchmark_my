import chisel3._
import chisel3.util._

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out    = Output(UInt(bitwidth.W))
  })

  // Task 1: Implement Gray code encoding
  val encoded = io.in ^ (io.in >> 1.U)

  // Task 2: Initialize decoding logic
  var result = io.in

  // Task 3: Implement iterative XOR operations for decoding
  for (i <- 0 until log2Ceil(bitwidth)) {
    result = result ^ (result >> (1 << i).U)
  }

  // Task 4: Assign decoded result to the output when encoding is false
  io.out := Mux(io.encode, encoded, result)
}

