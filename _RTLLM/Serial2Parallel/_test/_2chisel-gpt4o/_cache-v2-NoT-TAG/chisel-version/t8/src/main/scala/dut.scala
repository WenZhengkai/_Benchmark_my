import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial    = Input(Bool())       // Serial input data
    val din_valid     = Input(Bool())      // Validity signal for input data
    val dout_parallel = Output(UInt(8.W))  // Parallel output data (8 bits wide)
    val dout_valid    = Output(Bool())     // Validity signal for output data
  })

  // Task 1: Counter Implementation
  val cnt_reg = RegInit(0.U(4.W)) // 4-bit counter register initialized to 0

  when(io.din_valid) { // Increment counter only when din_valid is asserted
    when(cnt_reg === 8.U) {
      cnt_reg := 0.U // Reset counter when it reaches 8
    }.otherwise {
      cnt_reg := cnt_reg + 1.U // Increment counter
    }
  }

  // Task 2: Shift Register Logic
  val shift_reg = RegInit(0.U(8.W)) // 8-bit shift register to accumulate serial inputs

  when(io.din_valid) {
    shift_reg := Cat(shift_reg(6, 0), io.din_serial) // Left-shift by 1 and append din_serial
  }

  // Task 3: Parallel Output Capture
  val dout_parallel_reg = RegInit(0.U(8.W)) // 8-bit register for parallel output data

  when(io.din_valid && cnt_reg === 8.U) { // When 8 bits are received
    dout_parallel_reg := shift_reg // Latch shift_reg into dout_parallel_reg
  }

  io.dout_parallel := dout_parallel_reg // Connect dout_parallel_reg to output port

  // Task 4: Valid Signal Generation
  val dout_valid_reg = RegInit(false.B) // Register for dout_valid signal

  when(io.din_valid && cnt_reg === 8.U) {
    dout_valid_reg := true.B // Signal valid data on the 8th bit
  }.otherwise {
    dout_valid_reg := false.B // Reset dout_valid after one cycle
  }

  io.dout_valid := dout_valid_reg // Connect dout_valid_reg to output port

  // Task 5: Reset and Initialization
  // Registers are initialized to 0 using RegInit during declaration
  // Additional asynchronous reset logic can be added here if needed
}

// Generate Verilog code
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), args)
}
*/
