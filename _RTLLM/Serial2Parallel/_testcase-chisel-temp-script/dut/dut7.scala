import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Input ports
    val din_serial = Input(Bool())         // Serial input
    val din_valid  = Input(Bool())         // Serial input validity flag
    // Output ports
    val dout_parallel = Output(UInt(8.W)) // 8-bit parallel output
    val dout_valid    = Output(Bool())    // Parallel output validity flag
  })

  // Task 2: Implement a 4-bit counter
  val cnt = RegInit(0.U(4.W)) // 4-bit counter initialized to 0

  // Counter logic
  when(io.din_valid) {
    cnt := cnt + 1.U
    when(cnt === 7.U) {   // When count reaches 7 (next will be 8 after increment)
      cnt := 0.U          // Reset the counter after receiving 8 bits
    }
  }

  // Task 3: Implement the shift register
  val shift_reg = RegInit(0.U(8.W)) // 8-bit shift register initialized to 0

  // Shift register logic
  when(io.din_valid) {
    shift_reg := Cat(shift_reg(6, 0), io.din_serial) // Shift left and insert new bit
  }

  // Task 4: Generate dout_parallel output
  io.dout_parallel := 0.U // Default to 0
  when(cnt === 7.U) {     // Output parallel data when 8 bits have been received
    io.dout_parallel := shift_reg
  }

  // Task 5: Generate dout_valid signal
  val dout_valid = RegInit(false.B) // Register to track dout_valid state

  // Update dout_valid signal
  when(cnt === 7.U && io.din_valid) { // Set dout_valid when parallel data is ready
    dout_valid := true.B
  }.otherwise {
    dout_valid := false.B
  }
  io.dout_valid := dout_valid // Connect registered dout_valid to output
}

// Generate the Verilog (for testing/simulation purpose)
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
