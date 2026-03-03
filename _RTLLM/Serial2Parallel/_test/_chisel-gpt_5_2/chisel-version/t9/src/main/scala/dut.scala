import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial   = Input(Bool())
    val din_valid    = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid   = Output(Bool())
  })

  val shiftReg = RegInit(0.U(8.W))
  val cnt      = RegInit(0.U(4.W)) // counts received valid bits: 0..8
  val outValid = RegInit(false.B)

  // Default: dout_valid is a 1-cycle pulse when 8th valid bit arrives
  outValid := false.B

  when(io.din_valid) {
    // Shift left and insert new bit at LSB:
    // first received bit ends up at MSB after 8 shifts => MSB-to-LSB ordering.
    shiftReg := Cat(shiftReg(6, 0), io.din_serial.asUInt)

    when(cnt === 7.U) {
      cnt      := 0.U
      outValid := true.B
    }.otherwise {
      cnt := cnt + 1.U
    }
  }

  io.dout_parallel := shiftReg
  io.dout_valid    := outValid
}
