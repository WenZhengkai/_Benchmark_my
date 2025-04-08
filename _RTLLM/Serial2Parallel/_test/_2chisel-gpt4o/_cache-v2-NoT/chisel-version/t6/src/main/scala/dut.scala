import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Input Ports
    val din_serial = Input(Bool())
    val din_valid = Input(Bool())
    // Output Ports
    val dout_parallel = Output(UInt(8.W))
    val dout_valid = Output(Bool())
  })

  // Task 2: 4-bit counter to track received bits
  val cnt = RegInit(0.U(4.W)) // 4-bit counter initialized to 0

  // Task 3: Shift register to accumulate serial data
  val shift_reg = RegInit(0.U(8.W)) // 8-bit shift register initialized to 0

  // Task 5: Register for `dout_valid` signal
  val dout_valid_reg = RegInit(false.B) // Boolean register initialized to false

  // Default output assignments
  io.dout_parallel := 0.U
  io.dout_valid := false.B

  // Synchronous process for handling input and generating outputs
  when(io.din_valid) {
    // Shift register operation: shift left and insert the new serial input
    shift_reg := Cat(shift_reg(6, 0), io.din_serial)

    // Increment the counter
    cnt := cnt + 1.U

    // Check if a full byte (8 bits) has been received
    when(cnt === 8.U) {
      // Output the parallel data
      io.dout_parallel := shift_reg
      io.dout_valid := true.B

      // Reset the counter
      cnt := 0.U

      // Latch `dout_valid` for one clock cycle
      dout_valid_reg := true.B
    }.otherwise {
      // Ensure `dout_valid` is set to false if less than 8 bits received
      dout_valid_reg := false.B
    }
  } .otherwise {
    // If `din_valid` is not high, ensure outputs are reset
    dout_valid_reg := false.B
  }

  // Update outputs from internal registers
  io.dout_parallel := shift_reg
  io.dout_valid := dout_valid_reg
}

// Generate the Verilog code for the dut module
/*
object dut extends App {
  println("Generating Verilog for dut...")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
