import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial    = Input(Bool())           // Serial input data (1-bit)
    val din_valid     = Input(Bool())           // Validity of input data
    val dout_parallel = Output(UInt(8.W))      // Parallel output data (8 bits)
    val dout_valid    = Output(Bool())          // Validity of output data
  })

  // Register to hold the 8-bit parallel data
  val parallelData = RegInit(0.U(8.W))

  // Counter to track the number of valid serial bits received
  val counter = RegInit(0.U(4.W)) // 4-bit counter (since we need to count up to 8)

  // Output validity signal
  val validOut = RegInit(false.B)

  // Default outputs
  io.dout_parallel := parallelData
  io.dout_valid := validOut

  // Clocked process
  when(io.din_valid) { // Only process if valid input is indicated
    // Shift left and insert the serial input at the least significant position
    parallelData := Cat(parallelData(6, 0), io.din_serial)

    // Increment the counter
    counter := counter + 1.U

    // Check if 8 bits have been received
    when(counter === 7.U) { // Counter reaches 8 (0 to 7)
      validOut := true.B     // Set the output validity signal
      counter := 0.U         // Reset the counter
    } .otherwise {
      validOut := false.B    // Output is not valid yet
    }
  } .otherwise {
    validOut := false.B      // If no valid input, output is not valid
  }
}

// Generate the Verilog code
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
