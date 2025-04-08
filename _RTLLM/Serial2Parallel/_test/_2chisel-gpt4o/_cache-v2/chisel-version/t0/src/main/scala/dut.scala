import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool())        // Single-bit serial input
    val din_valid  = Input(Bool())        // Validity signal for input data
    val dout_parallel = Output(UInt(8.W)) // 8-bit parallel output
    val dout_valid    = Output(Bool())    // Validity signal for output data
  })

  // 4-bit counter to track the number of bits received
  val cnt = RegInit(0.U(4.W))

  // Register to hold the 8-bit parallel data
  val parallelReg = RegInit(0.U(8.W))

  // Register to hold the output valid signal
  val validReg = RegInit(false.B)

  // Default output assignments
  io.dout_parallel := parallelReg
  io.dout_valid := validReg

  // Update logic
  when(io.din_valid) {
    // Shift the serial input into the MSB of the parallel register
    parallelReg := Cat(parallelReg(6, 0), io.din_serial)
    // Increment the counter
    cnt := cnt + 1.U
  }

  // If the counter reaches 8, mark output as valid and reset the counter
  when(cnt === 7.U && io.din_valid) {
    validReg := true.B
    cnt := 0.U // Reset the counter after 8 bits are received
  } .otherwise {
    validReg := false.B
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
