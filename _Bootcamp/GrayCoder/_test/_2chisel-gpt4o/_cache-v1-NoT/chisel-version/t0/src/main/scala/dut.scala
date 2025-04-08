import chisel3._
import chisel3.util._
import scala.math._

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in     = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out    = Output(UInt(bitwidth.W))
  })

  // Task 1: Implement the Gray code encoding logic
  val grayEncoded = io.in ^ (io.in >> 1.U)

  // Task 2: Implement the initialization for the Gray code decoding logic
  var result = io.in

  // Task 3: Implement iterative XOR operations for Gray code decoding
  if (!io.encode) {
    for (i <- 1 until log2Ceil(bitwidth)) {
      result = result ^ (result >> (1 << i).U)
    }
  }

  // Task 4: Assign the final decoded result to the output
  io.out := Mux(io.encode, grayEncoded, result)
}

