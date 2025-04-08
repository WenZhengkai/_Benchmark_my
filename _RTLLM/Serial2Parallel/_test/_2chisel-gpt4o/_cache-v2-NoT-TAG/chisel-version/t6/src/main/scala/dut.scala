// Import Chisel library
import chisel3._
import chisel3.util._

/** dut Module
  * Converts a serial input stream into 8-bit parallel output data.
  * 
  * Inputs:
  *   - din_serial: Input single-bit serial data
  *   - din_valid:  Validity signal for the input data
  * Outputs:
  *   - dout_parallel: 8-bit parallel output
  *   - dout_valid: Validity signal for the parallel output
  */
class dut extends Module {
  val io = IO(new Bundle {
    val din_serial   = Input(Bool()) // Serial input data
    val din_valid    = Input(Bool()) // Serial input validity signal
    val dout_parallel = Output(UInt(8.W)) // Parallel 8-bit output
    val dout_valid    = Output(Bool()) // Parallel output validity signal
  })

  // Task 1: Counter Implementation
  // A 4-bit counter to track the number of valid bits received
  val cnt_reg = RegInit(0.U(4.W)) // Counter register initialized to 0

  // Increment counter only when din_valid is asserted
  when(io.din_valid) {
    when(cnt_reg === 8.U) {
      cnt_reg := 0.U // Reset counter after counting 8 valid bits
    }.otherwise {
      cnt_reg := cnt_reg + 1.U
    }
  }

  // Task 2: Shift Register Logic
  // An 8-bit shift register to accumulate the serial input data
  val shift_reg = RegInit(0.U(8.W)) // Register initialized to 0

  when(io.din_valid) {
    // Shift left and append the new serial input data
    shift_reg := Cat(shift_reg(6, 0), io.din_serial)
  }

  // Task 3: Parallel Output Capture
  // Register to hold the final parallel output
  val dout_parallel_reg = RegInit(0.U(8.W)) // Parallel output initialized to 0

  // Capture the parallel data when counter reaches 8 and input is valid
  when(io.din_valid && cnt_reg === 8.U) {
    dout_parallel_reg := shift_reg
  }

  // Connect dout_parallel_reg to the output port
  io.dout_parallel := dout_parallel_reg

  // Task 4: Valid Signal Generation
  // Hold dout_valid high for one clock cycle after output is valid
  val dout_valid_reg = RegInit(false.B) // Valid signal register initialized to 0

  // Assert dout_valid when 8 valid inputs are received
  dout_valid_reg := io.din_valid && (cnt_reg === 8.U)

  // Connect dout_valid_reg to the output port
  io.dout_valid := dout_valid_reg
}

// Generate Verilog for the dut module
/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
