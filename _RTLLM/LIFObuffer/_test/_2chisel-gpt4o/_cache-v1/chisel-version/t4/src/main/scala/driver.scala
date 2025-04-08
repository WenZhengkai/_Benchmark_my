import chisel3._
import chisel3.util._
// Generate the Verilog code
object AdderPipe64bitDriver extends App {
  val dir = "../../_test/_2chisel-gpt4o/t4"
  emitVerilog(new dut(), Array("--target-dir", dir))
}
