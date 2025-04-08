import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool())         // Single-bit serial input
    val din_valid = Input(Bool())         // Validity signal for input data
    val dout_parallel = Output(UInt(8.W)) // 8-bit parallel output
    val dout_valid = Output(Bool())       // Validity signal for output data
  })

  // Internal registers
  val shiftReg = RegInit(0.U(8.W))        // 8-bit shift register
  val cnt = RegInit(0.U(4.W))             // 4-bit counter
  val validReg = RegInit(false.B)         // Register to hold the output validity signal

  // Default output values
  io.dout_parallel := shiftReg
  io.dout_valid := validReg

  // Main logic
  when(io.din_valid) {
    // Shift the input data into the shift register
    shiftReg := Cat(shiftReg(6, 0), io.din_serial) // Shift left and append serial input (MSB-first order)
    // Increment the counter
    cnt := cnt + 1.U
    
    // Check if 8 bits have been received
    when(cnt === 7.U) { // When counter reaches 8 (0 through 7 is 8 cycles)
      cnt := 0.U
      validReg := true.B // Set the valid output signal
    } .otherwise {
      validReg := false.B // Reset the valid output signal
    }
  }.otherwise {
    validReg := false.B // Reset the valid output signal when din_valid is low
  }
}

// Generate the Verilog code (for testing or FPGA synthesis)
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
