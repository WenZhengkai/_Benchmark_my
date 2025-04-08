import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool())        // Serial input data
    val din_valid = Input(Bool())        // Validity signal for the input data
    val dout_parallel = Output(UInt(8.W)) // Parallel output data (8 bits wide)
    val dout_valid = Output(Bool())       // Validity signal for the output data
  })

  // Internal registers
  val shiftReg = RegInit(0.U(8.W))        // 8-bit shift register to accumulate serial data
  val cnt = RegInit(0.U(4.W))             // 4-bit counter to track the number of received bits
  val doutValidReg = RegInit(false.B)     // Register to hold validity signal for the output

  // Default values for output
  io.dout_parallel := shiftReg
  io.dout_valid := doutValidReg

  // Logic to shift in data and update register values
  when(io.din_valid) {
    // Shift the serial input into the shift register from the MSB side
    shiftReg := Cat(shiftReg(6, 0), io.din_serial)
    // Increment the counter when valid data is received
    cnt := cnt + 1.U

    // When 8 bits have been received, set the valid signal and reset the counter
    when(cnt === 7.U) {
      doutValidReg := true.B
      cnt := 0.U
    }.otherwise {
      doutValidReg := false.B
    }
  }.otherwise {
    // If no valid input, ensure the output valid signal is de-asserted
    doutValidReg := false.B
  }
}

/*
object dutDriver extends App {
  println("Generating the dut hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
