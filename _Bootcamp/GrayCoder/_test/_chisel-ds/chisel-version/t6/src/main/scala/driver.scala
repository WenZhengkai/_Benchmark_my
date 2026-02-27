import chisel3._
import chisel3.util._
// Generate the Verilog code
object Driver extends App {
  val dir = "../../_test/_cache/t6"
  emitVerilog(new dut(64), Array("--target-dir", dir))
}
