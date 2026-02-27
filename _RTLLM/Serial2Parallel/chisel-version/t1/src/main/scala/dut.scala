// package dut

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
  
  // Internal registers
  val cnt = RegInit(0.U(4.W))         // Counter to track number of bits received
  val shiftReg = RegInit(0.U(8.W))    // Shift register to store incoming bits
  val validOut = RegInit(false.B)     // Register for output validity
  
  // Default output values
  io.dout_valid := validOut
  io.dout_parallel := shiftReg
  
  when(io.din_valid) {
    // When input is valid, shift in the serial bit and increment counter
    shiftReg := Cat(shiftReg(6, 0), io.din_serial)
    cnt := cnt + 1.U
    
    // When we've received 8 bits, set output valid and reset counter
    when(cnt === 7.U) {
      validOut := true.B
      cnt := 0.U
    }.otherwise {
      validOut := false.B
    }
  }.otherwise {
    // When input is not valid, keep the same state
    validOut := false.B
  }
}
