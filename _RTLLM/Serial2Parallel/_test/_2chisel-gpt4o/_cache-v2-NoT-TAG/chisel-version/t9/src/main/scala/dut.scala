import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool())        // Serial input data
    val din_valid = Input(Bool())         // Validity signal for input data
    val dout_parallel = Output(UInt(8.W)) // Parallel output data (8 bits wide)
    val dout_valid = Output(Bool())       // Validity signal for the output data
  })

  // Task 1: Counter Implementation
  val cnt_reg = RegInit(0.U(4.W)) // 4-bit counter initialized to 0
  when(io.din_valid) {
    when(cnt_reg === 8.U) {
      cnt_reg := 0.U // Reset counter to 0 after 8 cycles
    }.otherwise {
      cnt_reg := cnt_reg + 1.U // Increment counter if valid data is received
    }
  }

  // Task 2: Shift Register Logic
  val shift_reg = RegInit(0.U(8.W)) // 8-bit shift register initialized to 0
  when(io.din_valid) {
    shift_reg := Cat(shift_reg(6, 0), io.din_serial) // Shift left and append serial input
  }

  // Task 3: Parallel Output Capture
  val dout_parallel_reg = RegInit(0.U(8.W)) // 8-bit register for parallel output
  when(io.din_valid && cnt_reg === 8.U) {
    dout_parallel_reg := shift_reg // Latch the parallel output when 8 bits are received
  }
  io.dout_parallel := dout_parallel_reg // Connect internal register to output

  // Task 4: Valid Signal Generation
  val dout_valid_reg = RegInit(false.B) // Register to hold `dout_valid` signal
  dout_valid_reg := io.din_valid && (cnt_reg === 8.U) // Assert `dout_valid` for one cycle after 8th bit
  io.dout_valid := dout_valid_reg

  // Note: Reset and initialization are handled using `RegInit`, so all registers are initialized to 0.
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut())
}
*/
