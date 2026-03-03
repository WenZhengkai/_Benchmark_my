import chisel3._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial    = Input(Bool())
    val din_valid     = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid    = Output(Bool())
  })

  val shiftReg = RegInit(0.U(8.W))
  val cnt      = RegInit(0.U(4.W))
  val doutReg  = RegInit(0.U(8.W))
  val validReg = RegInit(false.B)

  // Default: output not valid unless exactly 8th valid bit arrives this cycle.
  validReg := false.B

  when(io.din_valid) {
    val nextShift = Cat(shiftReg(6, 0), io.din_serial) // first bit received ends at MSB after 8 shifts
    shiftReg := nextShift

    when(cnt === 7.U) {
      doutReg  := nextShift
      validReg := true.B
      cnt      := 0.U
    }.otherwise {
      cnt := cnt + 1.U
    }
  }

  io.dout_parallel := doutReg
  io.dout_valid    := validReg
}
