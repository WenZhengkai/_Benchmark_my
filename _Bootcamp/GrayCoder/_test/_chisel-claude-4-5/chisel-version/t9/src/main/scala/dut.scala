import chisel3._
import chisel3.util._
import scala.math.pow

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  when(io.encode) {
    // Encoding Mode: Binary to Gray code
    io.out := io.in ^ (io.in >> 1.U)
  }.otherwise {
    // Decoding Mode: Gray code to Binary
    val numIterations = log2Ceil(bitwidth)
    val intermediate = Wire(Vec(numIterations + 1, UInt(bitwidth.W)))
    
    // Initialize the first intermediate value with input
    intermediate(0) := io.in
    
    // Iteratively compute XOR with right-shifted values
    for (i <- 0 until numIterations) {
      val shiftAmount = pow(2, i).toInt
      intermediate(i + 1) := intermediate(i) ^ (intermediate(i) >> shiftAmount.U)
    }
    
    // Output the final result
    io.out := intermediate(numIterations)
  }
}

// Generate Verilog
/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(
    new dut(bitwidth = 8),
    Array("--target-dir", "generated")
  )
}
*/
