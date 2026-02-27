import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val data_in = Input(UInt(8.W)) // 8-bit input data
    val valid_in = Input(Bool())   // Signal indicating readiness for new data
    val data_out = Output(UInt(10.W)) // 10-bit accumulated output data
    val valid_out = Output(Bool())    // Signal indicating 4 input data accumulation
  })

  // Internal registers
  val sumReg = RegInit(0.U(10.W)) // Register to store the accumulated sum
  val countReg = RegInit(0.U(3.W)) // Register to count the number of inputs (4 max)
  val validOutReg = RegInit(false.B) // Register to hold valid_out state

  // Default outputs
  io.data_out := 0.U
  io.valid_out := validOutReg
  validOutReg := false.B // Reset valid_out by default

  when(io.valid_in) {
    // Accumulate the input data
    sumReg := sumReg + io.data_in
    countReg := countReg + 1.U

    // When 4 inputs are accumulated
    when(countReg === 3.U) {
      io.data_out := sumReg + io.data_in // Output the accumulated sum
      validOutReg := true.B // Trigger valid_out signal
      sumReg := 0.U         // Reset the sum register
      countReg := 0.U       // Reset the count register
    }
  }
}

// Generate the Verilog of the module for synthesis
/*
object DutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new Dut())
}
*/
