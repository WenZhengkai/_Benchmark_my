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
  val cnt = RegInit(0.U(4.W)) // 4-bit counter to track received bits
  val shiftReg = RegInit(0.U(8.W)) // 8-bit shift register to store serial data

  // Default outputs
  io.dout_parallel := 0.U
  io.dout_valid := false.B

  // Logic for processing serial input
  when(io.din_valid) {
    shiftReg := (shiftReg << 1) | io.din_serial // Shift and insert new bit
    cnt := cnt + 1.U // Increment counter
  }

  // Logic for generating parallel output and valid signal
  when(cnt === 8.U) {
    io.dout_parallel := shiftReg // Output the collected 8-bit data
    io.dout_valid := true.B // Set valid signal
    cnt := 0.U // Reset counter
    shiftReg := 0.U // Clear shift register (optional)
  }
}

// Generate Verilog code for the module
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
