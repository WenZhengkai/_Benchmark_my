import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Input Ports
    val din_serial = Input(Bool())    // 1-bit serial input
    val din_valid = Input(Bool())    // 1-bit valid signal

    // Output Ports
    val dout_parallel = Output(UInt(8.W)) // 8-bit parallel output
    val dout_valid = Output(Bool())       // 1-bit valid signal for parallel output
  })

  // Task 2: 4-bit counter
  val cnt = RegInit(0.U(4.W)) // 4-bit counter to count up to 8 (to track the 8 bits received)
  when(io.din_valid) {
    cnt := cnt + 1.U
    when(cnt === 7.U) { // Reset counter when a full byte is received
      cnt := 0.U
    }
  }

  // Task 3: Shift register
  val shift_reg = RegInit(0.U(8.W)) // Initialize 8-bit shift register with 0
  when(io.din_valid) {
    shift_reg := Cat(shift_reg(6, 0), io.din_serial) // Shift register logic
  }

  // Task 4: Parallel output logic
  io.dout_parallel := 0.U // Default value for parallel output
  when(cnt === 7.U) {
    io.dout_parallel := shift_reg // Assign parallel output when 8 bits are received
  }

  // Task 5: Valid output logic
  val dout_valid_reg = RegInit(false.B) // Register to store dout_valid state
  io.dout_valid := dout_valid_reg
  when(cnt === 7.U) {
    dout_valid_reg := true.B // Set dout_valid to high when data is valid
  } .otherwise {
    dout_valid_reg := false.B // Reset dout_valid to low for other cases
  }
}

// Generate the Verilog code for the module
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
