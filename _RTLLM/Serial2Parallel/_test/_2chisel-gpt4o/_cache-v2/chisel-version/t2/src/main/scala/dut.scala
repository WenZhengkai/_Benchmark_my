import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial   = Input(Bool())      // Serial input data
    val din_valid    = Input(Bool())     // Validity signal for input data
    val dout_parallel = Output(UInt(8.W)) // Parallel output data (8-bit wide)
    val dout_valid   = Output(Bool())    // Validity signal for output data
  })

  // 4-bit counter to keep track of received bits
  val cnt = RegInit(0.U(4.W))
  // Register to store the 8-bit parallel output
  val shiftReg = RegInit(0.U(8.W))
  // Register to hold the validity of the parallel output
  val validReg = RegInit(false.B)

  // Default outputs
  io.dout_parallel := shiftReg
  io.dout_valid := validReg

  // Counter and shift register logic
  when(io.din_valid) {
    // Shift the serial input into the shift register
    shiftReg := Cat(shiftReg(6, 0), io.din_serial)
    // Increment the counter
    cnt := cnt + 1.U

    // Check if 8 bits have been received
    when(cnt === 7.U) {
      validReg := true.B  // Set the valid flag to 1 when all 8 bits are received
      cnt := 0.U          // Reset the counter
    }.otherwise {
      validReg := false.B // Valid flag remains 0 until 8 bits are received
    }
  }
}
