import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial    = Input(Bool())      // Serial input data
    val din_valid     = Input(Bool())     // Input valid signal
    val dout_parallel = Output(UInt(8.W)) // Parallel output data (8 bits)
    val dout_valid    = Output(Bool())    // Output valid signal
  })

  // Task 1: Counter Implementation
  // 4-bit counter to track valid serial inputs received
  val cnt_reg = RegInit(0.U(4.W)) // Initialize the counter to 0
  when(io.din_valid) {
    cnt_reg := cnt_reg + 1.U
    when(cnt_reg === 8.U) {
      cnt_reg := 0.U // Reset counter after 8 valid cycles
    }
  }

  // Task 2: Shift Register Logic
  // 8-bit shift register to accumulate serial inputs
  val shift_reg = RegInit(0.U(8.W)) // Initialize shift register to 0
  when(io.din_valid) {
    shift_reg := Cat(shift_reg(6, 0), io.din_serial) // Shift left and append LSB with `din_serial`
  }

  // Task 3: Parallel Output Capture
  // Latch parallel output when 8 bits are received
  val dout_parallel_reg = RegInit(0.U(8.W)) // Parallel output register, initialize to 0
  when(io.din_valid && cnt_reg === 8.U) {
    dout_parallel_reg := shift_reg // Capture the shift register value
  }
  io.dout_parallel := dout_parallel_reg // Drive the output

  // Task 4: Valid Signal Generation
  // Generate `dout_valid` for one clock cycle after 8 bits are received
  val dout_valid_reg = RegInit(false.B) // Validity signal register, initialize to false
  dout_valid_reg := io.din_valid && cnt_reg === 8.U // Assert valid signal for one cycle
  io.dout_valid := dout_valid_reg // Drive the output validity signal

  // Task 5: Reset and Initialization
  // Reset signals are already handled with `RegInit`
  // No further explicit reset handling is necessary
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
