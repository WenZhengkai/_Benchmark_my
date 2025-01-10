import chisel3._
import chisel3.util._
// Generate the Verilog code
object Driver extends App {
  val dir = "../../_test/_cache/t2"
  val outputWidth = 4 + 3 + log2Ceil(4 + 2) + 1
  println("Generating the IIRFilter hardware")
  emitVerilog(new dut(
        inputWidth = 4,
        coefWidth = 3,
        coefDecimalWidth = 0,
        outputWidth = outputWidth,
        numeratorNum = 4,
        denominatorNum = 2
  ), Array("--target-dir", dir))
}
