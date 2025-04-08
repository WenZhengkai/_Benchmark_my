import chisel3._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool())         // Single-bit serial input
    val din_valid = Input(Bool())          // Valid signal for serial input
    val dout_parallel = Output(UInt(8.W)) // 8-bit parallel output
    val dout_valid = Output(Bool())       // Valid signal for parallel output
  })

  // Task 2: 4-bit counter (to keep track of number of received bits)
  val cnt = RegInit(0.U(4.W)) // 4-bit counter, initialized to 0

  when(io.din_valid) {
    // Increment counter when din_valid is high
    cnt := cnt + 1.U
    // Reset counter to 0 when it reaches 8
    when(cnt === 7.U) { 
      cnt := 0.U 
    }
  }

  // Task 3: Implement the shift register
  val shift_reg = RegInit(0.U(8.W)) // 8-bit shift register, initialized to 0

  when(io.din_valid) {
    // Shift left the existing data and insert din_serial into LSB
    shift_reg := Cat(shift_reg(6, 0), io.din_serial)
  }

  // Task 4: Generate the dout_parallel output
  io.dout_parallel := 0.U // Default output is 0
  when(cnt === 7.U && io.din_valid) {
    io.dout_parallel := shift_reg // Parallel data ready when 8 bits received
  }

  // Task 5: Generate the dout_valid output signal
  val dout_valid_reg = RegInit(false.B) // Register to hold dout_valid state

  // Set dout_valid when 8 bits are received; otherwise false
  when(cnt === 7.U && io.din_valid) {
    dout_valid_reg := true.B
  }.otherwise {
    dout_valid_reg := false.B
  }

  // Connect dout_valid register to output
  io.dout_valid := dout_valid_reg
}

// Test harness for the dut module
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
