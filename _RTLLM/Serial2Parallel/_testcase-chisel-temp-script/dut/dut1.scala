import chisel3._

class dut extends Module {
  override def desiredName: String = "dut"

  val io = IO(new Bundle {
    val din_serial    = Input(Bool())   // Serial input data (1 bit)
    val din_valid     = Input(Bool())   // Input valid
    val dout_parallel = Output(UInt(8.W)) // Parallel output data (8 bits)
    val dout_valid    = Output(Bool())  // Output valid
  })

  val shiftReg = RegInit(0.U(8.W))
  val cnt      = RegInit(0.U(4.W)) // Counts valid bits received: 0 to 7

  io.dout_parallel := shiftReg
  io.dout_valid    := false.B

  when(io.din_valid) {
    val nextShift = Cat(shiftReg(6, 0), io.din_serial)

    when(cnt === 7.U) {
      // 8th valid bit received: output complete byte (MSB first, LSB last)
      shiftReg          := nextShift
      io.dout_parallel  := nextShift
      io.dout_valid     := true.B
      cnt               := 0.U
    }.otherwise {
      shiftReg := nextShift
      cnt      := cnt + 1.U
    }
  }
}
