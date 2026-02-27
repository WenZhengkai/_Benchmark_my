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

  // Default outputs
  io.dout_parallel := 0.U
  io.dout_valid := false.B

  // Logic
  when(io.din_valid) {
    shiftReg := (shiftReg << 1) | io.din_serial // Shift in the serial data
    cnt := cnt + 1.U // Increment the counter

    when(cnt === 7.U) { // When 8 bits are received
      io.dout_parallel := shiftReg // Output the parallel data
      io.dout_valid := true.B // Set output valid
      cnt := 0.U // Reset the counter
      shiftReg := 0.U // Reset the shift register (optional, depending on requirements)
    }.otherwise {
      io.dout_valid := false.B // Output is not valid
    }
  }.otherwise {
    io.dout_valid := false.B // Output is not valid
  }
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
