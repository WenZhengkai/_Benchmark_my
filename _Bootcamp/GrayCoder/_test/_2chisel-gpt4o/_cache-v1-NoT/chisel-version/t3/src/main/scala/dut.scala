import chisel3._
import chisel3.util._

class dut(val bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  // Encoding Gray code: io.out := io.in ^ (io.in >> 1.U)
  when(io.encode) {
    io.out := io.in ^ (io.in >> 1.U)
  } .otherwise {
    // Initialize the result for the decoding process
    var result = io.in

    // Iteratively decode the Gray code
    for (i <- 0 until log2Ceil(bitwidth)) {
      result = result ^ (result >> (1 << i).U)
    }

    // Assign the final result to the output
    io.out := result
  }
}


