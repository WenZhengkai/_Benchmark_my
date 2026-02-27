import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val d = Input(UInt(4.W))       // Parallel 4-bit input
    val valid_out = Output(Bool()) // Valid signal for serial output
    val dout = Output(Bool())      // Serial output
  })

  // Registers for storing data and counter
  val data = RegInit(0.U(4.W))     // Data register for shifting bits
  val cnt = RegInit(0.U(2.W))      // 2-bit counter (0 to 3)
  val valid = RegInit(false.B)     // Valid signal register

  // Default values
  io.valid_out := valid
  io.dout := data(3)               // Output most-significant bit of data register as serial output

  // Logic for shifting and updating
  when(cnt === 3.U) {              // If counter is 3 (last bit to output),
    data := io.d                   // Load new parallel data
    cnt := 0.U                     // Reset counter
    valid := true.B                // Output is valid
  }.otherwise {                    // Otherwise,
    data := data << 1              // Shift data register left (MSB is cleared)
    cnt := cnt + 1.U               // Increment counter
    valid := false.B               // Output is invalid during shift cycles
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
