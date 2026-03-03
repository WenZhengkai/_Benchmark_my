import chisel3._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial    = Input(Bool())
    val din_valid     = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid    = Output(Bool())
  })

  val shiftReg        = RegInit(0.U(8.W))
  val cnt             = RegInit(0.U(4.W)) // counts valid bits: 0..7
  val doutParallelReg = RegInit(0.U(8.W))
  val doutValidReg    = RegInit(false.B)

  // Default: output not valid unless 8th valid bit arrives this cycle
  doutValidReg := false.B

  when(io.din_valid) {
    val nextShift = Cat(shiftReg(6, 0), io.din_serial) // serial bits map MSB->LSB over 8 cycles
    shiftReg := nextShift

    when(cnt === 7.U) {
      doutParallelReg := nextShift
      doutValidReg := true.B
      cnt := 0.U
      shiftReg := 0.U
    }.otherwise {
      cnt := cnt + 1.U
    }
  }

  io.dout_parallel := doutParallelReg
  io.dout_valid    := doutValidReg
}
