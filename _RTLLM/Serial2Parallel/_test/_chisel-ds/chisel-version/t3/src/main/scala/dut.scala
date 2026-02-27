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

  // Logic
  when(io.din_valid) {
    shiftReg := (shiftReg << 1) | io.din_serial.asUInt
    cnt := cnt + 1.U

    when(cnt === 7.U) {
      io.dout_parallel := shiftReg
      io.dout_valid := true.B
      cnt := 0.U
      shiftReg := 0.U
    }.otherwise {
      io.dout_valid := false.B
    }
  }.otherwise {
    io.dout_valid := false.B
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
