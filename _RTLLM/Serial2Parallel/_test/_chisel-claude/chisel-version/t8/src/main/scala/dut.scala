import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool())
    val din_valid = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid = Output(Bool())
  })

  // Internal 4-bit counter to track the number of received bits
  val cnt = RegInit(0.U(4.W))
  
  // 8-bit shift register to store incoming serial data
  val shiftReg = RegInit(0.U(8.W))
  
  // Default output signals
  io.dout_valid := false.B
  io.dout_parallel := shiftReg

  when(io.din_valid) {
    // Shift register operation: shift left and insert new bit at LSB position
    shiftReg := Cat(shiftReg(6, 0), io.din_serial)
    
    // Increment counter
    cnt := cnt + 1.U
    
    // When counter reaches 8, set output valid and reset counter
    when(cnt === 7.U) {
      io.dout_valid := true.B
      cnt := 0.U
    }
  }
}
