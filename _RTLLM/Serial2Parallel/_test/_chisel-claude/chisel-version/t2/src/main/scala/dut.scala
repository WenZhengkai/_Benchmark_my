// package serial2parallel

import chisel3._
import chisel3.util._

class SerialToParallel extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool())
    val din_valid = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid = Output(Bool())
  })
  
  // 4-bit counter to track the number of received bits
  val cnt = RegInit(0.U(4.W))
  // 8-bit shift register to store the incoming serial bits
  val shiftReg = RegInit(0.U(8.W))
  // Output valid register
  val outValid = RegInit(false.B)
  
  // Default outputs
  io.dout_parallel := shiftReg
  io.dout_valid := outValid
  
  when(io.din_valid) {
    // When input is valid, shift in the new bit at MSB position
    shiftReg := Cat(io.din_serial, shiftReg(7, 1))
    
    // Increment counter
    cnt := cnt + 1.U
    
    // When counter reaches 8, set output valid and reset counter
    when(cnt === 7.U) {
      outValid := true.B
      cnt := 0.U
    }.otherwise {
      outValid := false.B
    }
  }.otherwise {
    // When input is not valid, maintain current state
    outValid := false.B
  }
}

// Top-level module named dut as per specification
class dut extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool())
    val din_valid = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid = Output(Bool())
  })
  
  val converter = Module(new SerialToParallel())
  
  converter.io.din_serial := io.din_serial
  converter.io.din_valid := io.din_valid
  io.dout_parallel := converter.io.dout_parallel
  io.dout_valid := converter.io.dout_valid
}
