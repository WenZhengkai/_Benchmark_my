import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial    = Input(Bool())
    val din_valid     = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid    = Output(Bool())
  })

  // Shift register to collect 8 serial bits (first bit received becomes MSB).
  val shiftReg = RegInit(0.U(8.W))
  // 4-bit counter as requested, counts valid serial bits received (0 to 7).
  val cnt      = RegInit(0.U(4.W))

  // Output registers
  val doutParallelReg = RegInit(0.U(8.W))
  val doutValidReg    = RegInit(false.B)

  // Default: output not valid unless the 8th valid bit arrives this cycle.
  doutValidReg := false.B

  when(io.din_valid) {
    val nextShift = Cat(shiftReg(6, 0), io.din_serial)

    when(cnt === 7.U) {
      // 8th bit received: latch full byte and assert valid.
      doutParallelReg := nextShift
      doutValidReg := true.B
      cnt := 0.U
    }.otherwise {
      cnt := cnt + 1.U
    }

    shiftReg := nextShift
  }

  io.dout_parallel := doutParallelReg
  io.dout_valid := doutValidReg
}
