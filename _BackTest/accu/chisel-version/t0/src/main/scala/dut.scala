import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val data_in   = Input(UInt(8.W))   // 8-bit input data
    val valid_in  = Input(Bool())     // Input signal indicating readiness for new data
    val valid_out = Output(Bool())    // Output signal indicating accumulation of 4 inputs
    val data_out  = Output(UInt(10.W)) // 10-bit accumulated sum of 4 inputs
  })

  // Register to keep track of accumulated sum
  val sumReg = RegInit(0.U(10.W))
  
  // Counter to track the number of valid inputs
  val countReg = RegInit(0.U(2.W))

  // Register to hold the valid_out signal
  val validOutReg = RegInit(false.B)

  // Default outputs
  io.valid_out := validOutReg
  io.data_out := 0.U
  
  // Logic for accumulating data and generating valid_out
  when(io.valid_in) {
    sumReg := sumReg + io.data_in
    countReg := countReg + 1.U

    when(countReg === 3.U) { // 4th valid input (0-based counting)
      io.data_out := sumReg + io.data_in  // Include the current input in the final sum
      validOutReg := true.B               // Set valid_out for 1 cycle
      sumReg := 0.U                       // Reset sum after output
      countReg := 0.U                     // Reset count after output
    }.otherwise {
      validOutReg := false.B              // Continue accumulating but do not set valid_out
    }
  }.otherwise {
    validOutReg := false.B                // No valid input, reset valid_out to false
  }
}
