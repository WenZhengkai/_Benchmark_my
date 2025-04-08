import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial    = Input(Bool())         // Serial input data
    val din_valid     = Input(Bool())        // Valid signal for the input
    val dout_parallel = Output(UInt(8.W))   // Parallel 8-bit output data
    val dout_valid    = Output(Bool())      // Valid signal for the output
  })

  // Task 1: Counter Implementation (4-bit counter)
  val cnt_reg = RegInit(0.U(4.W)) // 4-bit counter, initialized to 0
  when(io.din_valid) {
    when(cnt_reg === 8.U) {
      cnt_reg := 0.U // Reset counter when it reaches 8
    }.otherwise {
      cnt_reg := cnt_reg + 1.U // Increment counter on valid input
    }
  }

  // Task 2: Shift Register Logic (8-bit shift register)
  val shift_reg = RegInit(0.U(8.W)) // 8-bit shift register, initialized to 0
  when(io.din_valid) {
    shift_reg := Cat(shift_reg(6, 0), io.din_serial) // Left shift and append serial input
  }

  // Task 3: Parallel Output Capture
  val dout_parallel_reg = RegInit(0.U(8.W)) // 8-bit register for output, initialized to 0
  when(io.din_valid && cnt_reg === 8.U) {   // When counter reaches 8 and input is valid
    dout_parallel_reg := shift_reg         // Latch shift register value to the output
  }
  io.dout_parallel := dout_parallel_reg    // Connect output register to the output port

  // Task 4: Valid Signal Generation
  val dout_valid_reg = RegInit(false.B)    // Register for dout_valid, initialized to false
  dout_valid_reg := (io.din_valid && cnt_reg === 8.U) // Assert valid when counter is 8 and din_valid is high
  io.dout_valid := dout_valid_reg          // Connect dout_valid_reg to the output port

  // Task 5: Reset and Initialization (handled by RegInit for all registers)
}

// Generate the Verilog
/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, args)
}
*/
