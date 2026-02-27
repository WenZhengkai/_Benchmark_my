import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val d = Input(UInt(4.W))   // 4-bit parallel data input
    val valid_out = Output(Bool()) // Valid signal indicating serial output availability
    val dout = Output(UInt(1.W))   // Serial output representing data
  })

  // Internal registers
  val data = RegInit(0.U(4.W)) // Register to hold the input parallel data
  val cnt  = RegInit(0.U(2.W)) // 2-bit counter to keep track of the serial bits being output

  // Default values for outputs
  io.valid_out := false.B
  io.dout := 0.U

  // Serial conversion logic
  when(cnt === 3.U) {
    // This is the fourth (last) bit being output
    io.valid_out := true.B      // Valid signal is set high
    io.dout := data(3)          // Output the MSB of `data`
    data := io.d                // Load new parallel data into the register
    cnt := 0.U                  // Reset the counter
  }.otherwise {
    io.dout := data(3)          // Output the MSB of data
    io.valid_out := false.B     // Valid signal is set low
    data := data << 1           // Shift `data` to the left (move bits)
    cnt := cnt + 1.U            // Increment counter
  }
}

// Testbench and simulation logic would normally be provided separately.
