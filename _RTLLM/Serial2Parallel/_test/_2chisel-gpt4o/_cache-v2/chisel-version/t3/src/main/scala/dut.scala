import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool())     // Serial input data (1 bit)
    val din_valid = Input(Bool())     // Validity signal for input data
    val dout_parallel = Output(UInt(8.W)) // Parallel output data (8 bits wide)
    val dout_valid = Output(Bool())   // Validity signal for the output data
  })

  // Internal register to store the parallel data
  val dataReg = RegInit(0.U(8.W))     // 8-bit register to store the parallel output
  val cnt = RegInit(0.U(4.W))         // 4-bit counter to keep track of serial inputs
  val doutValidReg = RegInit(false.B) // Register for dout_valid flag

  // Default values for output
  io.dout_parallel := dataReg
  io.dout_valid := doutValidReg

  when(io.din_valid) {
    // Shift new serial data into the register (from MSB to LSB)
    dataReg := Cat(dataReg(6, 0), io.din_serial)
    // Increment the counter
    cnt := cnt + 1.U

    // Check if 8 bits have been received
    when(cnt === 7.U) {
      doutValidReg := true.B       // Set valid output signal
      cnt := 0.U                   // Reset counter
    }.otherwise {
      doutValidReg := false.B      // Output is not valid until 8 bits are received
    }
  } .otherwise {
    doutValidReg := false.B        // Reset dout_valid when input is not valid
  }
}

// Generate the Verilog code by extending App
/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
