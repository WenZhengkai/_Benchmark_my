import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Input ports
    val din_serial = Input(Bool())
    val din_valid = Input(Bool())
    
    // Output ports
    val dout_parallel = Output(UInt(8.W))
    val dout_valid = Output(Bool())
  })
  
  // 4-bit counter to track number of bits received
  val cnt = RegInit(0.U(4.W))
  
  // 8-bit shift register to store input bits
  val shift_reg = RegInit(0.U(8.W))
  
  // Default values
  io.dout_valid := false.B
  io.dout_parallel := 0.U
  
  when(io.din_valid) {
    // Shift the input bit into the register (from MSB to LSB)
    shift_reg := Cat(shift_reg(6, 0), io.din_serial)
    
    // Increment the counter
    cnt := cnt + 1.U
    
    // When we've received 8 bits, output the parallel data and assert valid
    when(cnt === 7.U) {
      io.dout_valid := true.B
      io.dout_parallel := Cat(shift_reg(6, 0), io.din_serial)
      cnt := 0.U
    }
  }
}
