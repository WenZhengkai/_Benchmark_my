import chisel3._
import chisel3.util._
import scala.math.log2Ceil

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  // Task 1: Gray code encoding
  when(io.encode) {
    // Perform Gray code encoding
    io.out := io.in ^ (io.in >> 1.U)
  } .otherwise {
    // Task 2: Initialization for decoding
    var result = io.in

    // Task 3: Iterative XOR for decoding
    for (i <- 0 until log2Ceil(bitwidth)) {
      result = result ^ (result >> (1 << i).U)
    }

    // Task 4: Assign decoded result to output
    io.out := result
  }
}

