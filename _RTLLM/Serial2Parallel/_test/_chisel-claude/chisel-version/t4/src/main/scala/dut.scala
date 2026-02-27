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
  val shiftReg = RegInit(0.U(8.W))  // 8-bit shift register to store serial input
  val counter = RegInit(0.U(4.W))   // 4-bit counter to track number of bits received
  val validOut = RegInit(false.B)   // Output valid signal
  
  // Default output values
  io.dout_parallel := shiftReg
  io.dout_valid := validOut
  
  // Shift register and counter logic
  when(io.din_valid) {
    // Shift the input data into the shift register (MSB first)
    shiftReg := Cat(shiftReg(6, 0), io.din_serial)
    
    // Increment the counter
    counter := counter + 1.U
    
    // When counter reaches 8, set output valid and reset counter
    when(counter === 7.U) {
      validOut := true.B
      counter := 0.U
    }.otherwise {
      validOut := false.B
    }
  }.otherwise {
    validOut := false.B
  }
}
