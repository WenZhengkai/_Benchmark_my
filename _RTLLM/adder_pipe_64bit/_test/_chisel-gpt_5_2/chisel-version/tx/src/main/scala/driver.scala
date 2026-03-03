import chisel3._
import chisel3.util._
// Generate the Verilog code
object Driver extends App {
  val dir = "../../_test/_cache/tx"
  emitVerilog(new dut(), Array("--target-dir", dir))
}
