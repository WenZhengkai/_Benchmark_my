import chisel3._
import chisel3.util._
// Generate the Verilog code
object Driver extends App {
  val dir = "generated"
  emitVerilog(new CSR_golden(), Array("--target-dir", dir))
}
