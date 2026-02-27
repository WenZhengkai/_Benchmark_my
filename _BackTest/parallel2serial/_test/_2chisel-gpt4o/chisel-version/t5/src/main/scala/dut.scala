import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val d         = Input(UInt(4.W))  // 4-bit parallel data input
    val valid_out = Output(Bool())   // Valid signal indicating serial output availability
    val dout      = Output(UInt(1.W)) // Serial output representing converted data
  })

  // Internal registers
  val data = RegInit(0.U(4.W))       // Register to hold the parallel input
  val cnt  = RegInit(0.U(2.W))       // 2-bit counter to track serial output position

  // Default output values
  io.dout := data(3)                // The MSB of the data register is the current output
  io.valid_out := false.B           // Default value for valid signal

  when(cnt === 3.U) {               // Counter reaches 3 (last serial bit of the input)
    data := io.d                    // Load new parallel data into the data register
    cnt := 0.U                      // Reset counter to 0
    io.valid_out := true.B          // Indicate valid serial output
  } .otherwise {
    data := data << 1               // Shift data register left by one bit
    cnt := cnt + 1.U                // Increment the counter
    io.valid_out := false.B         // Not valid output for in-between cycles
  }
}

/*
object dut extends App {
  println("Generating the dut hardware")
  chisel3.Driver.execute(args, () => new dut)
}
*/
