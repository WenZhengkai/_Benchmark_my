import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Input ports
    val din_serial  = Input(Bool())    // Single-bit serial input
    val din_valid   = Input(Bool())    // Single-bit valid signal

    // Output ports
    val dout_parallel = Output(UInt(8.W)) // 8-bit parallel output
    val dout_valid    = Output(Bool())    // Parallel data valid signal
  })

  // Task 2: 4-bit counter to track received bits
  val cnt = RegInit(0.U(4.W)) // 4-bit counter initialized to 0

  // Task 3: 8-bit shift register for serial-to-parallel conversion
  val shift_reg = RegInit(0.U(8.W)) // 8-bit shift register initialized to 0

  // Task 5: Register to hold dout_valid signal
  val dout_valid_reg = RegInit(false.B) // dout_valid initialized to false

  // Sequential logic
  when (io.din_valid) {
    // Increment counter
    cnt := cnt + 1.U

    // Shift left and insert new bit at LSB in shift register
    shift_reg := Cat(shift_reg(6, 0), io.din_serial)

    // If 8 bits are received, latch outputs and reset counter
    when (cnt === 8.U) {
      cnt := 0.U                 // Reset counter
      dout_valid_reg := true.B   // Set dout_valid to true
    } .otherwise {
      dout_valid_reg := false.B  // Clear dout_valid for other cases
    }
  } .otherwise {
    // If din_valid is not asserted, keep current state
    dout_valid_reg := false.B
  }

  // Task 4: Assign outputs
  io.dout_parallel := shift_reg // Parallel output always reflects shift_reg value
  io.dout_valid := dout_valid_reg // Validity signal output
}

// Generate the Verilog code for the module
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
