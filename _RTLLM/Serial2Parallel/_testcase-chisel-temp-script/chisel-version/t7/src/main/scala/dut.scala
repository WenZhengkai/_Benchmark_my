// package seqpara

import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool())
    val din_valid = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid = Output(Bool())
  })

  // 4-bit counter to track the number of received bits
  val cnt = RegInit(0.U(4.W))
  
  // 8-bit shift register to accumulate the serial input
  val shiftReg = RegInit(0.U(8.W))
  
  // Default value for output valid signal
  io.dout_valid := false.B
  
  // Default connection for output parallel data
  io.dout_parallel := shiftReg
  
  when(io.din_valid) {
    // When input is valid, shift the register and insert the new bit at MSB
    shiftReg := Cat(io.din_serial, shiftReg(7, 1))
    
    // Increment the counter
    cnt := cnt + 1.U
    
    // Check if we've received 8 bits
    when(cnt === 7.U) {
      // Reset counter for next sequence
      cnt := 0.U
      
      // Set output valid when we've collected all 8 bits
      io.dout_valid := true.B
    }
  }
}
