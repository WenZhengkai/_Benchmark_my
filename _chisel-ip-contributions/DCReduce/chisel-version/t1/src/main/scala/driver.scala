import chisel3._
import chisel3.util._
// Generate the Verilog code
object Driver extends App {
  val dir = "../../_test/_cache/t1"
   def xor(a: UInt, b: UInt): UInt = a ^ b
  emitVerilog(new dut(UInt(8.W), n = 6, op = xor), Array("--target-dir", dir))
}
