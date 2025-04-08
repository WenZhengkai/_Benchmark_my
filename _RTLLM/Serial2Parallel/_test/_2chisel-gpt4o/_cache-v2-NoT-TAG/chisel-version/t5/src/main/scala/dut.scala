import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial   = Input(Bool())     // Serial input data
    val din_valid    = Input(Bool())     // Validity signal for input data
    val dout_parallel = Output(UInt(8.W)) // Parallel output data (8 bits wide)
    val dout_valid    = Output(Bool())    // Validity signal for parallel output
  })

  // Task 1: Counter Implementation
  val cnt_reg = RegInit(0.U(4.W)) // 4-bit counter to track valid inputs

  // Increment the counter on each valid input
  when(io.din_valid) {
    when(cnt_reg === 8.U) {
      cnt_reg := 0.U // Reset counter when 8 valid inputs are received
    }.otherwise {
      cnt_reg := cnt_reg + 1.U
    }
  }

  // Task 2: Shift Register Logic
  val shift_reg = RegInit(0.U(8.W)) // 8-bit shift register

  // Shift data on each valid input
  when(io.din_valid) {
    shift_reg := Cat(shift_reg(6, 0), io.din_serial) // Left-shift and append input
  }

  // Task 3: Parallel Output Capture
  val dout_parallel_reg = RegInit(0.U(8.W)) // Register for parallel output

  // Latch shift_reg into parallel output when the 8th valid input is received
  when(io.din_valid && cnt_reg === 8.U) {
    dout_parallel_reg := shift_reg
  }

  // Connect the parallel output register to the module's output
  io.dout_parallel := dout_parallel_reg

  // Task 4: Valid Signal Generation
  val dout_valid_reg = RegInit(false.B) // Register to hold valid signal

  // Generate dout_valid when the 8th valid input is received
  dout_valid_reg := (io.din_valid && cnt_reg === 8.U)

  // Connect the valid signal register to the module's output
  io.dout_valid := dout_valid_reg
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
