import chisel3._
import chisel3.util._
import scala.math._

class dut(val bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  when(io.encode) {
    // Task 1: Implement the Gray code encoding logic
    io.out := io.in ^ (io.in >> 1.U)
  } .otherwise {
    // Task 2: Implement the initialization for the Gray code decoding logic
    var result = io.in
    for (i <- 0 until log2Ceil(bitwidth)) {
      // Task 3: Implement iterative XOR operations for Gray code decoding
      result = result ^ (result >> (1 << i).U)
    }
    // Task 4: Assign the final decoded result to the output
    io.out := result
  }
}


