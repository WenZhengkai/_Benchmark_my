import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial   = Input(Bool())       // Single-bit serial input
    val din_valid    = Input(Bool())      // Input data valid
    val dout_parallel = Output(UInt(8.W)) // 8-bit parallel output
    val dout_valid   = Output(Bool())     // Output data valid
  })

  // Task 2: Implement a 4-bit counter to track received bits
  val cnt = RegInit(0.U(4.W)) // 4-bit counter for bits

  when(io.din_valid) {                 // When data is valid
    cnt := cnt + 1.U                  // Increment counter
    when(cnt === 7.U) {               // Reset counter when it reaches 8
      cnt := 0.U
    }
  }

  // Task 3: Implement the shift register
  val shift_reg = RegInit(0.U(8.W))    // Shift register to store serial data
  when(io.din_valid) {
    shift_reg := Cat(shift_reg(6, 0), io.din_serial) // Shift left and insert new bit (LSB)
  }

  // Task 4: Generate the `dout_parallel` output signal
  val dout_parallel_reg = RegInit(0.U(8.W))         // Register for parallel output
  when(cnt === 7.U && io.din_valid) {               // When one byte is received
    dout_parallel_reg := shift_reg                  // Assign shift register to output
  }

  // Task 5: Generate the `dout_valid` output signal
  val dout_valid_reg = RegInit(false.B)             // Register for output valid signal
  when(cnt === 7.U && io.din_valid) {               // Assert dout_valid when one byte is received
    dout_valid_reg := true.B
  }.otherwise {                                     // Otherwise, deassert dout_valid
    dout_valid_reg := false.B
  }

  // Connect internal signals to output ports
  io.dout_parallel := dout_parallel_reg
  io.dout_valid := dout_valid_reg
}

// Generate the Verilog for the design
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
