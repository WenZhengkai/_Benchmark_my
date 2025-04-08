import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool())   // Serial input data
    val din_valid = Input(Bool())   // Validity signal for input data
    val dout_parallel = Output(UInt(8.W)) // Parallel output data (8 bits wide)
    val dout_valid = Output(Bool()) // Validity signal for output data
  })

  // 8-bit parallel data register
  val parallelData = RegInit(0.U(8.W))

  // 4-bit counter for counting incoming serial bits
  val cnt = RegInit(0.U(4.W))

  // Output valid signal
  val outputValid = RegInit(false.B)

  // Default values for output
  io.dout_parallel := parallelData
  io.dout_valid := outputValid

  // Main logic
  when(io.din_valid) {
    // Shift incoming serial data into the parallel register from MSB to LSB
    parallelData := Cat(parallelData(6, 0), io.din_serial)
    cnt := cnt + 1.U

    // When 8 bits have been received, set the output valid signal
    when(cnt === 7.U) {
      outputValid := true.B
      cnt := 0.U // Reset counter
    } .otherwise {
      outputValid := false.B
    }
  } .otherwise {
    // If input is not valid, do not update the state
    outputValid := false.B
  }
}

/*
object dut extends App {
  // Generates the Verilog
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
