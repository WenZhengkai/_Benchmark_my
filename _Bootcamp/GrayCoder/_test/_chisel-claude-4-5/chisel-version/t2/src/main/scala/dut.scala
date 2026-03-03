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
    val intermediates = Wire(Vec(numIterations + 1, UInt(bitwidth.W)))
    
    // Initialize the first intermediate value with input
    intermediates(0) := io.in
    
    // Iteratively compute XOR with right-shifted values
    for (i <- 0 until numIterations) {
      val shiftAmount = pow(2, i).toInt
      intermediates(i + 1) := intermediates(i) ^ (intermediates(i) >> shiftAmount.U)
    }
    
    // Output is the last computed intermediate value
    io.out := intermediates(numIterations)
  }
}

// Object for generating Verilog
/*
object dut extends App {
  println("Generating Verilog for dut module...")
  (new chisel3.stage.ChiselStage).emitVerilog(
    new dut(bitwidth = 8),
    Array("--target-dir", "generated")
  )
}
*/
