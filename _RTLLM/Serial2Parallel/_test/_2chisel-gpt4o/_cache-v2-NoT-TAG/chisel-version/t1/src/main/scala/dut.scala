import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial   = Input(Bool())           // Serial input data
    val din_valid    = Input(Bool())           // Valid signal for input data
    val dout_parallel = Output(UInt(8.W))     // Parallel output (8 bits)
    val dout_valid   = Output(Bool())          // Valid signal for output data
  })

  // Task 1: Counter Implementation
  val cnt_reg = RegInit(0.U(4.W))             // 4-bit counter to track valid inputs
  
  // Counter Logic
  when(io.din_valid) {                        // Increment on valid input
    when(cnt_reg === 8.U) {
      cnt_reg := 0.U                          // Reset counter after 8 inputs
    }.otherwise {
      cnt_reg := cnt_reg + 1.U                // Increment counter
    }
  }

  // Task 2: Shift Register Logic
  val shift_reg = RegInit(0.U(8.W))           // 8-bit shift register
  
  when(io.din_valid) {
    shift_reg := Cat(shift_reg(6, 0), io.din_serial) // Shift left and append din_serial to LSB
  }

  // Task 3: Parallel Output Capture
  val dout_parallel_reg = RegInit(0.U(8.W))  // Register to latch parallel output
  
  when(io.din_valid && (cnt_reg === 8.U)) {  // Capture shift_reg value on 8th bit
    dout_parallel_reg := shift_reg
  }

  // Task 4: Valid Signal Generation
  val dout_valid_reg = RegInit(false.B)      // Output valid signal
  dout_valid_reg := io.din_valid && (cnt_reg === 8.U) // Assert for one cycle after 8th bit
  
  // Connect outputs
  io.dout_parallel := dout_parallel_reg
  io.dout_valid := dout_valid_reg
}

// Generate Verilog
/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
