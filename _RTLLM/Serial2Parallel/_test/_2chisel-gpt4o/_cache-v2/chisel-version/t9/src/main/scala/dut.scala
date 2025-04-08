import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial   = Input(Bool())        // Serial input data
    val din_valid    = Input(Bool())       // Validity signal for input data
    val dout_parallel = Output(UInt(8.W)) // Parallel output data (8 bits wide)
    val dout_valid    = Output(Bool())    // Validity signal for the output data
  })

  // Internal Registers
  val shiftReg = RegInit(0.U(8.W))          // 8-bit shift register for assembling the serial data
  val counter  = RegInit(0.U(3.W))          // 3-bit counter (to count up to 8)
  val doutValid = RegInit(false.B)          // Register to hold dout_valid signal

  // Default Outputs
  io.dout_parallel := shiftReg
  io.dout_valid := doutValid

  // Sequential logic
  when(io.din_valid) {
    // Shift the serial data into the shift register
    shiftReg := Cat(shiftReg(6, 0), io.din_serial) // Concatenate din_serial as the LSB of shift register
    counter := counter + 1.U                     // Increment the counter by 1

    // Check if 8 bits have been received
    when(counter === 7.U) {                      // Counter is 7 (8th bit being received)
      doutValid := true.B                        // Set dout_valid to true
      counter := 0.U                             // Reset the counter
    } .otherwise {
      doutValid := false.B                       // Otherwise, dout_valid is false
    }
  } .otherwise {
    doutValid := false.B                         // If din_valid is not high, dout_valid remains false
  }
}

// Generate Verilog
/*
object dutMain extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
