import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool()) // Serial input data
    val din_valid = Input(Bool())  // Validity signal for input data
    val dout_parallel = Output(UInt(8.W)) // Parallel output data (8 bits)
    val dout_valid = Output(Bool())      // Validity signal for output data
  })

  // Internal signals
  val cnt = RegInit(0.U(4.W)) // 4-bit counter to track received bits
  val shiftReg = RegInit(0.U(8.W)) // 8-bit shift register to store serial data

  // Default outputs
  io.dout_parallel := 0.U
  io.dout_valid := false.B

  // Logic for serial-to-parallel conversion
  when(io.din_valid) {
    shiftReg := (shiftReg << 1) | io.din_serial // Shift and store the serial input
    cnt := cnt + 1.U // Increment the counter

    // When 8 bits are received
    when(cnt === 7.U) {
      io.dout_parallel := shiftReg // Output the parallel data
      io.dout_valid := true.B     // Set the valid signal
      cnt := 0.U                  // Reset the counter
      shiftReg := 0.U             // Clear the shift register
    }
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
