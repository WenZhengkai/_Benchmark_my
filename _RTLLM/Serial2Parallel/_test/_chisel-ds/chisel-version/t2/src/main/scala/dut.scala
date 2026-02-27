import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial   = Input(Bool())       // Serial input data
    val din_valid    = Input(Bool())       // Validity signal for input data
    val dout_parallel = Output(UInt(8.W))  // Parallel output data (8 bits)
    val dout_valid   = Output(Bool())      // Validity signal for output data
  })

  // Internal signals
  val cnt = RegInit(0.U(4.W))              // 4-bit counter to track received bits
  val shiftReg = RegInit(0.U(8.W))         // 8-bit shift register to store serial data

  // Default output values
  io.dout_parallel := 0.U
  io.dout_valid := false.B

  // Logic for serial-to-parallel conversion
  when(io.din_valid) {
    // Shift in the serial data and increment the counter
    shiftReg := (shiftReg << 1) | io.din_serial
    cnt := cnt + 1.U

    // When 8 bits are received, output the parallel data and set valid signal
    when(cnt === 7.U) {
      io.dout_parallel := shiftReg
      io.dout_valid := true.B
      cnt := 0.U // Reset the counter
    }
  }
}

// Generate Verilog code for the module
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), args)
}
*/
