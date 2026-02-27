import chisel3._
import chisel3.util._
import scala.math.pow

class dut(bitwidth: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(bitwidth.W))
    val encode = Input(Bool())
    val out = Output(UInt(bitwidth.W))
  })

  // When encode is true, convert binary to Gray code
  // When encode is false, convert Gray code to binary
  when(io.encode) {
    // Binary to Gray code conversion: g = b ^ (b >> 1)
    io.out := io.in ^ (io.in >> 1.U)
  }.otherwise {
    // Gray code to Binary conversion
    // This is more complex and requires an iterative approach
    
    // Initialize the first value with the input Gray code
    val iterations = log2Ceil(bitwidth)
    val intermediateValues = Wire(Vec(iterations + 1, UInt(bitwidth.W)))
    intermediateValues(0) := io.in
    
    // Perform the iterative XOR operations
    for (i <- 0 until iterations) {
      val shiftAmount = pow(2, i).toInt
      intermediateValues(i + 1) := intermediateValues(i) ^ (intermediateValues(i) >> shiftAmount.U)
    }
    
    // Set the output to the final computed value
    io.out := intermediateValues(iterations)
  }
}

// Optional: Object to make the module instantiable from the command line
/*
object dutGenerator extends App {
  chisel3.Driver.execute(args, () => new dut(8)) // Default 8-bit width
}
*/
