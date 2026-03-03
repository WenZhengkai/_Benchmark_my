import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial    = Input(Bool())
    val din_valid     = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid    = Output(Bool())
  })

  val shiftReg = RegInit(0.U(8.W))
  val cnt      = RegInit(0.U(4.W))

  // Defaults
  io.dout_parallel := shiftReg
  io.dout_valid    := false.B

  when(io.din_valid) {
    // Shift in new bit so that first received ends up in MSB after 8 bits:
    // After 8 inputs: shiftReg = b0 b1 b2 b3 b4 b5 b6 b7
    shiftReg := Cat(shiftReg(6, 0), io.din_serial)

    when(cnt === 7.U) {
      // Just accepted the 8th bit
      io.dout_valid := true.B
      cnt := 0.U
    }.otherwise {
      cnt := cnt + 1.U
    }
  }
}
