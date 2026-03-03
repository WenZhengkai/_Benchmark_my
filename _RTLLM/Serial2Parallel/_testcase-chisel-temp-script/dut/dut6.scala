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
  val cnt      = RegInit(0.U(4.W)) // counts received valid bits: 0..8
  val outReg   = RegInit(0.U(8.W))
  val outValid = RegInit(false.B)

  // Default: output not valid unless exactly finishing a byte this cycle
  outValid := false.B

  when(io.din_valid) {
    val nextShift = Cat(shiftReg(6, 0), io.din_serial.asUInt) // first bit ends at MSB after 8 shifts
    shiftReg := nextShift

    when(cnt === 7.U) {
      // 8th valid bit received this cycle
      outReg   := nextShift
      outValid := true.B
      cnt      := 0.U
    }.otherwise {
      cnt := cnt + 1.U
    }
  }

  io.dout_parallel := outReg
  io.dout_valid    := outValid
}
