import chisel3._
import chisel3.util._
// Generate the Verilog code
object Driver extends App {
  val dir = "../../_test/_cache/t8"
  emitVerilog(new dut(4,6), Array("--target-dir", dir))
}
