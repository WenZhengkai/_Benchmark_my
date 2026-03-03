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
  val cnt      = RegInit(0.U(4.W)) // counts received valid bits (0..8)

  // Default outputs
  io.dout_parallel := shiftReg
  io.dout_valid    := false.B

  when(io.din_valid) {
    // Shift in from MSB to LSB: first received bit ends up at bit 7
    shiftReg := Cat(shiftReg(6, 0), io.din_serial.asUInt)

    when(cnt === 7.U) {
      // Just received the 8th bit
      cnt := 0.U
      io.dout_valid := true.B
      io.dout_parallel := Cat(shiftReg(6, 0), io.din_serial.asUInt) // output the newly completed byte
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
