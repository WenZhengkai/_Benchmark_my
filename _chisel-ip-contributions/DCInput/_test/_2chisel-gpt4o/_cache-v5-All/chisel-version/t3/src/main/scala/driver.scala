import chisel3._
import chisel3.util._
// Generate the Verilog code
object Driver extends App {
  val dir = "../../_test/_cache/t3"
  emitVerilog(new dut(UInt(8.W)), Array("--target-dir", dir))
}
