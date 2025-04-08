import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial  = Input(Bool())          // Single-bit serial data input
    val din_valid   = Input(Bool())          // Valid signal for the serial input
    val dout_parallel = Output(UInt(8.W))   // 8-bit parallel data output
    val dout_valid = Output(Bool())         // Valid signal for parallel output
  })

  // Task 2: 4-bit counter to keep track of received bits
  val cnt = RegInit(0.U(4.W))                // 4-bit counter, initialized to 0

  when(io.din_valid) {
    cnt := cnt + 1.U                        // Increment counter when input is valid
    when(cnt === 7.U) {                     // Reset counter after 8 bits (0-7)
      cnt := 0.U
    }
  }

  // Task 3: Shift register to accumulate serial input data
  val shift_reg = RegInit(0.U(8.W))          // 8-bit shift register, initialized to 0
  when(io.din_valid) {
    shift_reg := Cat(shift_reg(6, 0), io.din_serial) // Shift left and insert LSB
  }

  // Task 4: Output parallel data when a full byte is received
  io.dout_parallel := 0.U                   // Default output is 0
  when(cnt === 7.U) {                       // When counter reaches 8 (indicating full byte)
    io.dout_parallel := shift_reg           // Output the shift register value
  }

  // Task 5: Generate dout_valid signal
  val dout_valid = RegInit(false.B)         // Register to store dout_valid state
  when(cnt === 7.U && io.din_valid) {       // Set dout_valid at the end of a full byte
    dout_valid := true.B
  } .otherwise {
    dout_valid := false.B                   // Otherwise, reset dout_valid
  }
  io.dout_valid := dout_valid               // Connect to output

  // Synchronous reset is already handled through RegInit
}

// Generate Verilog for the dut module
/*
object dutMain extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
