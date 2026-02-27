import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Input ports
    val data_in = Input(UInt(8.W))    // 8-bit input data
    val valid_in = Input(Bool())     // Valid input signal

    // Output ports
    val valid_out = Output(Bool())   // Valid output signal
    val data_out = Output(UInt(10.W)) // 10-bit accumulated output
  })

  // Register to hold the intermediate sum
  val accumulator = RegInit(0.U(10.W))
  // Register to count valid inputs
  val count = RegInit(0.U(2.W)) // 2 bits are sufficient to count up to 4
  // Register for the output valid signal
  val validOutReg = RegInit(false.B)

  // Default values for outputs
  io.valid_out := validOutReg
  validOutReg := false.B  // Reset after one cycle
  io.data_out := 0.U

  when(io.valid_in) { // Only process if valid input is high
    // Accumulate input data
    accumulator := accumulator + io.data_in
    // Increment the count
    count := count + 1.U

    // If four valid inputs have been accumulated
    when(count === 3.U) {
      // Output the accumulated value
      io.data_out := accumulator + io.data_in // Include the current input
      validOutReg := true.B // Signal valid output

      // Reset the accumulator and count
      accumulator := 0.U
      count := 0.U
    }
  }
}
