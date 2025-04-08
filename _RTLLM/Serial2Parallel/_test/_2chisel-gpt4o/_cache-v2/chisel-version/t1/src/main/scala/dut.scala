import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial   = Input(Bool())         // Serial input data
    val din_valid    = Input(Bool())        // Validity signal for input data
    val dout_parallel = Output(UInt(8.W))  // Parallel output data (8 bits wide)
    val dout_valid   = Output(Bool())       // Validity signal for output data
  })

  // 4-bit counter to track the number of serial input bits
  val cnt = RegInit(0.U(4.W))

  // 8-bit register to hold the parallel data
  val shiftReg = RegInit(0.U(8.W))

  // Register for dout_valid (valid output signal)
  val doutValidReg = RegInit(false.B)

  // Default outputs
  io.dout_parallel := shiftReg
  io.dout_valid := doutValidReg

  // Synchronous logic
  when(io.din_valid) { // If din_valid is high, process the serial input
    shiftReg := Cat(shiftReg(6, 0), io.din_serial) // Shift in the serial data
    cnt := cnt + 1.U                             // Increment the counter

    // When we have received 8 bits, set dout_valid to true and reset the counter
    when(cnt === 7.U) {
      doutValidReg := true.B
      cnt := 0.U
    }.otherwise {
      doutValidReg := false.B
    }
  }.otherwise {
    doutValidReg := false.B // If din_valid is low, clear dout_valid signal
  }
}

// Scala object to generate the Verilog code
/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
