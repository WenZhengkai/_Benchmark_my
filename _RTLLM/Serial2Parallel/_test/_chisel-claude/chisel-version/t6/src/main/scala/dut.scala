// package dut

import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool())
    val din_valid = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid = Output(Bool())
  })

  // 4-bit counter to track the number of serial input bits received
  val cnt = RegInit(0.U(4.W))
  // 8-bit register to store the serial input data
  val shiftReg = RegInit(0.U(8.W))
  // Output valid signal
  val outValid = RegInit(false.B)

  // Default outputs
  io.dout_parallel := shiftReg
  io.dout_valid := outValid

  when (io.din_valid) {
    // Shift the serial input data into the register from MSB to LSB
    shiftReg := Cat(shiftReg(6, 0), io.din_serial)
    
    // Increment the counter
    cnt := cnt + 1.U
    
    // Check if we've received 8 bits
    when (cnt === 7.U) {
      // Reset counter and set output valid
      cnt := 0.U
      outValid := true.B
    } .otherwise {
      outValid := false.B
    }
  } .otherwise {
    outValid := false.B
  }
}
