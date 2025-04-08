import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Input ports
    val din_serial  = Input(Bool())       // Single-bit serial input
    val din_valid   = Input(Bool())       // Data valid signal

    // Output ports
    val dout_parallel = Output(UInt(8.W)) // 8-bit parallel output
    val dout_valid    = Output(Bool())    // Output valid signal
  })

  // Task 2: Implement a 4-bit counter (`cnt`) to keep track of received bits
  val cnt = RegInit(0.U(4.W)) // 4-bit counter initialized to 0
  when(io.din_valid) {
    cnt := cnt + 1.U
    when(cnt === 8.U) { // Reaches 8 (index starts from 0 to 8)
      cnt := 0.U        // Reset the counter to 0
    }
  }

  // Task 3: Implement the shift register to accumulate serial input data
  val shift_reg = RegInit(0.U(8.W)) // 8-bit shift register initialized to 0
  when(io.din_valid) {
    shift_reg := Cat(shift_reg(6, 0), io.din_serial) // Shift left and insert LSB
  }

  // Task 4: Generate the `dout_parallel` output signal
  val dout_parallel = WireDefault(0.U(8.W)) // Default to 0
  when(cnt === 8.U && io.din_valid) {       // Full byte received
    dout_parallel := shift_reg             // Assign the value of shift register
  }
  io.dout_parallel := dout_parallel        // Connect to IO

  // Task 5: Generate the `dout_valid` output signal
  val dout_valid = RegInit(false.B) // Register for valid signal (initialized to false)
  dout_valid := (cnt === 8.U && io.din_valid) // True when byte is complete
  io.dout_valid := dout_valid                 // Connect to IO

  // Notes on reset handling: All registers (`cnt`, `shift_reg`, `dout_valid`) reset to their initial states (0 or false.B) automatically via `RegInit`.
}

// Generate the Verilog code by extending App
/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
