import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial   = Input(Bool())        // Single-bit serial input
    val din_valid    = Input(Bool())        // Data valid signal for input
    val dout_parallel = Output(UInt(8.W))   // 8-bit parallel output
    val dout_valid   = Output(Bool())       // Data valid signal for output
  })

  // Task 2: 4-bit counter
  val cnt = RegInit(0.U(4.W)) // 4-bit counter initialized to 0
  when (io.din_valid) {
    cnt := cnt + 1.U
    when (cnt === 7.U) { // Reset the counter after receiving 8 bits
      cnt := 0.U
    }
  }

  // Task 3: Shift register
  val shift_reg = RegInit(0.U(8.W)) // 8-bit shift register initialized to 0
  when (io.din_valid) {
    shift_reg := Cat(shift_reg(6, 0), io.din_serial) // Shift left and insert serial data
  }

  // Task 4: Generate dout_parallel output signal
  val dout_parallel = WireDefault(0.U(8.W)) // Wire to handle combinational logic
  when (cnt === 7.U) {
    dout_parallel := shift_reg
  }
  io.dout_parallel := dout_parallel

  // Task 5: Generate dout_valid output signal
  val dout_valid = RegInit(false.B) // Register to store output data validity
  when (cnt === 7.U) {
    dout_valid := true.B
  }.otherwise {
    dout_valid := false.B
  }
  io.dout_valid := dout_valid
}
