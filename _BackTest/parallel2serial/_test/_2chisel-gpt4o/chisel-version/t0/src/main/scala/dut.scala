import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val d         = Input(UInt(4.W))   // 4-bit parallel data input
    val dout      = Output(UInt(1.W)) // Serial output
    val valid_out = Output(Bool())    // Valid signal
  })

  // Internal registers
  val data = RegInit(0.U(4.W)) // Register to hold the 4-bit data
  val cnt  = RegInit(0.U(2.W)) // 2-bit counter register to count cycles

  // Default valid_out and dout
  io.valid_out := false.B
  io.dout      := data(3) // Output MSB of 'data'

  when(cnt === 3.U) {
    // When counter indicates the last bit of the parallel input
    cnt := 0.U                 // Reset the counter
    data := io.d               // Load new parallel input into the data register
    io.valid_out := true.B     // Indicate valid output
  }.otherwise {
    // Increment the counter and shift the data register
    cnt := cnt + 1.U
    data := data << 1          // Shift data register: MSB -> LSB
    io.valid_out := false.B    // Output not valid until the next cycle
  }
}

/*
object dutDriver extends App {
  // Generate Verilog for the dut
  chisel3.Driver.execute(args, () => new dut)
}
*/
