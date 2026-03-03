import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial    = Input(Bool())
    val din_valid     = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid    = Output(Bool())
  })

  // Shift register collects serial bits; first received bit ends up at MSB after 8 valid inputs
  val shiftReg = RegInit(0.U(8.W))
  val cnt      = RegInit(0.U(4.W)) // counts valid bits: 0..8
  val doutReg  = RegInit(0.U(8.W))
  val vldReg   = RegInit(false.B)

  vldReg := false.B // default: output not valid

  when(io.din_valid) {
    val nextShift = Cat(shiftReg(6, 0), io.din_serial.asUInt)

    when(cnt === 7.U) {
      // 8th valid bit received: output assembled byte and assert valid
      doutReg := nextShift
      vldReg  := true.B
      cnt     := 0.U
    }.otherwise {
      shiftReg := nextShift
      cnt      := cnt + 1.U
    }
  }

  io.dout_parallel := doutReg
  io.dout_valid    := vldReg
}
