import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial   = Input(Bool())      // Serial input data (1-bit)
    val din_valid    = Input(Bool())     // Validity signal for input data
    val dout_parallel = Output(UInt(8.W)) // Parallel output data (8-bit)
    val dout_valid    = Output(Bool())   // Validity signal for the output data
  })

  // Task 1: Counter Implementation
  val cnt_reg = RegInit(0.U(4.W)) // 4-bit counter register initialized to 0

  when(io.din_valid) {
    cnt_reg := cnt_reg + 1.U
    when(cnt_reg === 7.U) { // Counting till 8 (0 to 7), reset on the next valid cycle
      cnt_reg := 0.U
    }
  }

  // Task 2: Shift Register Logic
  val shift_reg = RegInit(0.U(8.W)) // 8-bit shift register initialized to 0

  when(io.din_valid) {
    shift_reg := Cat(shift_reg(6, 0), io.din_serial) // Left-shift and append din_serial to LSB
  }

  // Task 3: Parallel Output Capture
  val dout_parallel_reg = RegInit(0.U(8.W)) // Register for parallel output initialized to 0

  when(io.din_valid && (cnt_reg === 7.U)) { // On the 8th valid cycle, latch parallel data
    dout_parallel_reg := shift_reg
  }
  io.dout_parallel := dout_parallel_reg // Connect register to output port

  // Task 4: Valid Signal Generation
  val dout_valid_reg = RegInit(false.B) // Register for dout_valid initialized to 0 (false)

  dout_valid_reg := io.din_valid && (cnt_reg === 7.U) // Assert dout_valid on 8th valid cycle
  io.dout_valid := dout_valid_reg // Connect dout_valid to output port

  // Task 5: Reset and Initialization
  // Handled using `RegInit` during declaration
}

// Test the module
/*
object dutMain extends App {
  println("Generating the dut hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
