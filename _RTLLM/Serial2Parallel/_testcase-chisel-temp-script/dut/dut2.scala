import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Input ports
    val din_serial = Input(Bool())        // Serial data input (1 bit)
    val din_valid = Input(Bool())        // Data valid signal (1 bit)
    // Output ports
    val dout_parallel = Output(UInt(8.W)) // Parallel data output (8 bits)
    val dout_valid = Output(Bool())      // Output valid signal (1 bit)
  })

  // Task 2: Implement the 4-bit counter
  val cnt = RegInit(0.U(4.W)) // 4-bit counter initialized to 0

  when(io.din_valid) {
    cnt := cnt + 1.U // Increment counter when din_valid is high
    when(cnt === 7.U) { // Check if counter reaches 8 (0 to 7 are 8 cycles)
      cnt := 0.U // Reset counter to 0
    }
  }

  // Task 3: Implement the shift register
  val shift_reg = RegInit(0.U(8.W)) // 8-bit shift register initialized to 0

  when(io.din_valid) {
    shift_reg := Cat(shift_reg(6, 0), io.din_serial) // Shift left, insert serial data into LSB
  }

  // Task 4: Generate dout_parallel output
  val dout_parallel = RegInit(0.U(8.W)) // Register for parallel output

  when(cnt === 7.U && io.din_valid) { // Output valid data when 8 bits are collected
    dout_parallel := shift_reg // Assign shift register to parallel output
  }

  // Task 5: Generate dout_valid output
  val dout_valid = RegInit(false.B) // Register to store dout_valid signal

  when(cnt === 7.U && io.din_valid) {
    dout_valid := true.B // Set dout_valid high when new byte is ready
  }.elsewhen(!io.din_valid) {
    dout_valid := false.B // Reset dout_valid when no valid input is present
  }

  // Connect the outputs
  io.dout_parallel := dout_parallel
  io.dout_valid := dout_valid
}

// Main object to generate the Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
