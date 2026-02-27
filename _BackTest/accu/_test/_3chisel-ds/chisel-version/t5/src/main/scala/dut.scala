import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val data_in = Input(UInt(8.W))
    val valid_in = Input(Bool())
    val data_out = Output(UInt(10.W))
    val valid_out = Output(Bool())
  })

  // Registers to store accumulated sum and count
  val sumReg = RegInit(0.U(10.W))
  val countReg = RegInit(0.U(2.W))
  
  // Default outputs
  io.data_out := 0.U
  io.valid_out := false.B

  when(io.valid_in) {
    when(countReg === 3.U) {
      // On 4th input (count=3), output sum and reset
      io.data_out := sumReg + io.data_in
      io.valid_out := true.B
      sumReg := 0.U
      countReg := 0.U
    }.otherwise {
      // Accumulate input and increment count
      sumReg := sumReg + io.data_in
      countReg := countReg + 1.U
    }
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
