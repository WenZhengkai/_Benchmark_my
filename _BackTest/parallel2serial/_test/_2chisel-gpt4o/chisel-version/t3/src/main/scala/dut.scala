import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val d         = Input(UInt(4.W))  // 4-bit parallel data input
    val valid_out = Output(Bool())    // Valid signal indicating serial output availability
    val dout      = Output(UInt(1.W)) // Serial one-bit output
  })

  // Internal register to hold the parallel data
  val data = RegInit(0.U(4.W))
  // Counter register to track the current bit being output
  val cnt = RegInit(0.U(2.W)) // 2-bit counter (0-3)
  // Valid signal register
  val valid = RegInit(false.B)

  // Default values for outputs
  io.valid_out := valid
  io.dout := data(3) // Most significant bit is output first

  when(cnt === 3.U) {
    // On the 4th cycle, load new input data and reset the counter
    data := io.d
    cnt := 0.U
    valid := true.B
  } .otherwise {
    // Increment the counter, shift data left, and set valid to false
    cnt := cnt + 1.U
    data := data << 1
    valid := false.B
  }
}
