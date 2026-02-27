import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool())
    val din_valid = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid = Output(Bool())
  })

  // Internal signals
  val cnt = RegInit(0.U(4.W)) // 4-bit counter
  val shiftReg = RegInit(0.U(8.W)) // 8-bit shift register

  // Default outputs
  io.dout_parallel := 0.U
  io.dout_valid := false.B

  // Logic for serial to parallel conversion
  when(io.din_valid) {
    // Shift in the serial data
    shiftReg := (shiftReg << 1) | io.din_serial
    cnt := cnt + 1.U

    // When 8 bits are received, output the parallel data
    when(cnt === 7.U) {
      io.dout_parallel := shiftReg
      io.dout_valid := true.B
      cnt := 0.U // Reset the counter
    }.otherwise {
      io.dout_valid := false.B
    }
  }.otherwise {
    io.dout_valid := false.B
  }
}

// Generate Verilog code
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
