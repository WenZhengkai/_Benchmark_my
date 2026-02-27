import chisel3._
import chisel3.util._
import scala.math.pow

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  when (io.encode) {
    // Encoding: Binary to Gray code
    io.out := io.in ^ (io.in >> 1.U)
  } .otherwise {
    // Decoding: Gray code to Binary
    val numIters = log2Ceil(bitwidth)
    val decodeSteps = Wire(Vec(numIters + 1, UInt(bitwidth.W)))
    
    // Initialize first step with input
    decodeSteps(0) := io.in
    
    // Iterative XOR operations for decoding
    for (i <- 0 until numIters) {
      val shiftAmount = pow(2, i).toInt
      decodeSteps(i + 1) := decodeSteps(i) ^ (decodeSteps(i) >> shiftAmount.U)
    }
    
    // Output is the final step result
    io.out := decodeSteps(numIters)
  }
}

// Optional object for direct testing
/*
object dutMain extends App {
  println("Generating Verilog for Gray Code Encoder/Decoder")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(8), Array("--target-dir", "generated"))
}
*/
