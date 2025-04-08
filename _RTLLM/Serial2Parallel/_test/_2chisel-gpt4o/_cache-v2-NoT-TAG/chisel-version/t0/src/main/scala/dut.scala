import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool())     // Serial input data
    val din_valid = Input(Bool())     // Signal indicating validity of input data
    val dout_parallel = Output(UInt(8.W)) // Parallel output data (8 bits wide)
    val dout_valid = Output(Bool())   // Validity signal for parallel output
  })

  // Task 1: Counter Implementation
  val cnt_reg = RegInit(0.U(4.W)) // 4-bit counter initialized to 0

  // Increment or reset counter based on din_valid
  when(io.din_valid) {
    when(cnt_reg === 8.U) {
      cnt_reg := 0.U // Reset counter when 8 valid data are received
    }.otherwise {
      cnt_reg := cnt_reg + 1.U
    }
  }

  // Task 2: Shift Register Logic
  val shift_reg = RegInit(0.U(8.W)) // 8-bit shift register initialized to 0

  // Update shift register with incoming serial data
  when(io.din_valid) {
    shift_reg := (shift_reg << 1) | io.din_serial
  }

  // Task 3: Parallel Output Capture
  val dout_parallel_reg = RegInit(0.U(8.W)) // 8-bit parallel output register initialized to 0

  // Load shift register data into the output register when 8 bits are received
  when(io.din_valid && cnt_reg === 8.U) {
    dout_parallel_reg := shift_reg
  }

  // Connect output ports
  io.dout_parallel := dout_parallel_reg

  // Task 4: Valid Signal Generation
  val dout_valid_reg = RegInit(false.B) // Register to hold dout_valid signal

  // Assert dout_valid for one cycle when 8 valid bits are received
  dout_valid_reg := io.din_valid && (cnt_reg === 8.U)
  io.dout_valid := dout_valid_reg

  // Note: Reset for cnt_reg, shift_reg, and dout_parallel_reg is handled by RegInit
}

// Generate Verilog of the module for use in hardware
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
