// package spc

import chisel3._
import chisel3.util._

class SerialToParallel extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool())
    val din_valid = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid = Output(Bool())
  })

  // 4-bit counter to track the number of bits received
  val cnt = RegInit(0.U(4.W))
  // 8-bit shift register to accumulate input bits
  val shiftReg = RegInit(0.U(8.W))
  // Output register
  val outputReg = RegInit(0.U(8.W))
  // Output valid signal
  val outputValid = RegInit(false.B)

  // Default output connections
  io.dout_parallel := outputReg
  io.dout_valid := outputValid

  // Reset output valid by default each cycle
  outputValid := false.B

  when(io.din_valid) {
    // Shift in new bit from MSB to LSB
    shiftReg := Cat(shiftReg(6, 0), io.din_serial)
    
    // Increment counter
    cnt := cnt + 1.U
    
    // When we've received 8 bits
    when(cnt === 7.U) {
      // Reset counter
      cnt := 0.U
      
      // Update output register with the completed byte
      outputReg := Cat(shiftReg(6, 0), io.din_serial)
      
      // Set output valid
      outputValid := true.B
    }
  }
}

// Object to make the module instantiable from FIRRTL
/*
object SerialToParallel extends App {
  chisel3.Driver.execute(args, () => new SerialToParallel)
}
*/
