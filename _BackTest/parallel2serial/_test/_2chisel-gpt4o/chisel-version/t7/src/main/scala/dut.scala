import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val d = Input(UInt(4.W))          // 4-bit parallel data input
    val valid_out = Output(Bool())    // Valid signal indicating serial output availability
    val dout = Output(Bool())         // Serial output
  })

  // Internal states: registers for shift data and counter
  val data = RegInit(0.U(4.W)) // Register to hold the shifted data
  val cnt = RegInit(0.U(3.W))  // 3-bit counter register (0-3 cycles)
  
  // Default outputs
  io.dout := false.B
  io.valid_out := false.B

  // Sequential logic
  when(cnt === 3.U) {               // If count is 3, process a new input
    data := io.d                    // Load new parallel input
    io.valid_out := true.B          // Signal valid output
    io.dout := io.d(3)              // Output the MSB (most significant bit)
    cnt := 0.U                      // Reset counter
  } .otherwise {                    // For other counts, continue shifting
    data := data << 1               // Shift data to the left
    io.dout := data(3)              // Output the MSB of the shifted data
    io.valid_out := false.B         // No new parallel input being processed
    cnt := cnt + 1.U                // Increment counter
  }
}

/*
object dutMain extends App {
  println("Generating dut Verilog")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
