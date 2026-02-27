import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val d        = Input(UInt(4.W))  // 4-bit parallel data input
    val valid_out = Output(Bool())  // Output signal indicating valid serial output
    val dout     = Output(UInt(1.W)) // Serial output one bit at a time
  })

  // Internal registers
  val cnt   = RegInit(0.U(2.W))      // 2-bit counter initialized to 0
  val data  = RegInit(0.U(4.W))      // Register to hold the 4-bit parallel data
  val valid = RegInit(false.B)       // Valid signal register, initialized to 0
  
  // Initial outputs
  io.valid_out := valid
  io.dout := data(3) // Output the MSB of the data register
  
  when(cnt === 3.U) {
    // If counter equals 3 (last cycle of serial output)
    data := io.d     // Update the data register with new parallel input
    cnt := 0.U       // Reset the counter
    valid := true.B  // Set valid signal to 1
  }.otherwise {
    // Otherwise increment the counter and shift data
    cnt := cnt + 1.U
    valid := false.B    // Maintain valid signal as 0 during intermediate cycles
    data := data << 1.U // Shift data register to the left by 1 bit
  }
}
