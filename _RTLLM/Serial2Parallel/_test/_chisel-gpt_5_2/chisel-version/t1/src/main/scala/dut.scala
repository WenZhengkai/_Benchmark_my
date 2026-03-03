import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial   = Input(Bool())
    val din_valid    = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid   = Output(Bool())
  })

  // Shift register holds collected bits; first received goes to MSB.
  val shiftReg = RegInit(0.U(8.W))
  val cnt      = RegInit(0.U(4.W)) // counts valid received bits: 0..7

  // Default outputs
  io.dout_parallel := shiftReg
  io.dout_valid    := false.B

  when(io.din_valid) {
    // Shift left, append new serial bit at LSB => first bit ends up at MSB after 8 bits
    shiftReg := Cat(shiftReg(6, 0), io.din_serial.asUInt)

    when(cnt === 7.U) {
      // This cycle captures the 8th bit; output becomes valid
      io.dout_valid := true.B
      cnt := 0.U
    }.otherwise {
      cnt := cnt + 1.U
    }
  }
}

/*
object dut extends App {
  emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
