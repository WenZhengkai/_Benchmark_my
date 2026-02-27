import chisel3._
import chisel3.util._
// Generate the Verilog code
object Driver extends App {
  val dir = "generated"
  emitVerilog(new BHT(), Array("--target-dir", dir))
}
