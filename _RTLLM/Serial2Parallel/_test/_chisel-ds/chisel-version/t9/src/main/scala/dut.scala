import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool())
    val din_valid = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid = Output(Bool())
  })

  // Internal signals
  val cnt = RegInit(0.U(4.W)) // 4-bit counter
  val shiftReg = RegInit(0.U(8.W)) // 8-bit shift register

  // Default output values
  io.dout_parallel := 0.U
  io.dout_valid := false.B

  // Logic for serial to parallel conversion
  when(io.din_valid) {
    // Shift in the serial data into the shift register
    shiftReg := Cat(shiftReg(6, 0), io.din_serial)
    cnt := cnt + 1.U

    // Check if 8 bits have been received
    when(cnt === 7.U) {
      io.dout_parallel := shiftReg // Output the 8-bit parallel data
      io.dout_valid := true.B // Set the valid signal
      cnt := 0.U // Reset the counter
    }
  }
}

// Generate Verilog code for the module
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
