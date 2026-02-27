import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val d        = Input(UInt(4.W)) // 4-bit parallel data input
    val valid_out = Output(Bool())  // Valid signal for serial data output
    val dout      = Output(Bool())  // Serial data output
  })

  // Internal registers for the counter and data register
  val cnt  = RegInit(0.U(2.W))  // Counter register (2 bits to count 0-3)
  val data = RegInit(0.U(4.W))  // Data register
  
  // Output logic
  io.dout := data(3)            // Serial output (MSB of data)
  io.valid_out := cnt === 0.U   // Valid signal is high only when counter is 0

  // Sequential logic
  when(cnt === 3.U) {
    data := io.d                // Load the parallel data input into the data register
    cnt := 0.U                  // Reset the counter
  }.otherwise {
    data := data << 1           // Shift the data register left (MSB to LSB)
    cnt := cnt + 1.U            // Increment the counter
  }
}

/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
