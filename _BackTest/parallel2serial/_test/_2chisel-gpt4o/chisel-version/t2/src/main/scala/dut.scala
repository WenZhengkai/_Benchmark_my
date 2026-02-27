import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val d = Input(UInt(4.W))       // 4-bit parallel data input
    val valid_out = Output(Bool()) // Valid signal indicating the availability of serial output
    val dout = Output(UInt(1.W))   // Serial output representing the converted data
  })

  // Internal registers
  val data = RegInit(0.U(4.W))     // Register to hold the parallel input data during processing
  val cnt = RegInit(0.U(2.W))      // Counter register (0 to 3 for 4 bits)

  // Output signal initialization
  io.valid_out := false.B
  io.dout := 0.U
  
  when(cnt === 3.U) {
    // Next cycle is the start of a new data conversion
    data := io.d       // Load new parallel data into the register
    io.valid_out := true.B // Indicate valid output for MSB
    io.dout := data(3)     // Output most significant bit (MSB) of the data
    cnt := 0.U             // Reset counter for the next cycle
  }.otherwise {
    // Process the current data
    cnt := cnt + 1.U       // Increment the counter
    data := data << 1      // Shift the data register left (MSB shifts into LSB)
    io.dout := data(3)     // Output the most significant bit
    io.valid_out := false.B // Keep valid signal low
  }
}

// Generate Verilog code for the dut
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
