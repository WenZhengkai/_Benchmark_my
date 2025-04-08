import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial   = Input(Bool())              // Serial input data
    val din_valid    = Input(Bool())             // Validity signal for input data
    val dout_parallel = Output(UInt(8.W))        // Parallel output data (8 bits wide)
    val dout_valid   = Output(Bool())            // Validity signal for the output data
  })

  // Internal 4-bit counter to track received bits
  val cnt = RegInit(0.U(4.W))
  val dout = RegInit(0.U(8.W))                   // 8-bit register to hold parallel output data
  val valid = RegInit(false.B)                   // Output validity flag

  // Default outputs
  io.dout_parallel := dout
  io.dout_valid := valid

  // Update logic
  when(io.din_valid) {
    // Shift in the serial bit and increment the counter
    dout := Cat(dout(6, 0), io.din_serial)
    cnt := cnt + 1.U

    // When 8 bits have been received, mark output as valid
    valid := cnt === 7.U
    when(cnt === 7.U) {
      cnt := 0.U // Reset counter after 8 bits have been processed
    }
  } .otherwise {
    // If din_valid is not asserted, output is not valid
    valid := false.B
  }
}

/*
object dutDriver extends App {
  // Generate the Verilog code
  chisel3.Driver.execute(args, () => new dut)
}
*/
