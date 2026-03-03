import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial    = Input(Bool())
    val din_valid     = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid    = Output(Bool())
  })

  // Shift register to collect 8 serial bits
  val shiftReg = RegInit(0.U(8.W))
  // 4-bit counter as requested
  val cnt      = RegInit(0.U(4.W))

  val doutParallelReg = RegInit(0.U(8.W))
  val doutValidReg    = RegInit(false.B)

  // Default: output not valid unless 8th bit arrives this cycle
  doutValidReg := false.B

  when(io.din_valid) {
    // New shift-register value after receiving current serial bit
    val nextShift = Cat(shiftReg(6, 0), io.din_serial)

    when(cnt === 7.U) {
      // 8 bits received -> publish parallel output and assert valid
      doutParallelReg := nextShift
      doutValidReg    := true.B
      cnt             := 0.U
      shiftReg        := 0.U
    }.otherwise {
      shiftReg := nextShift
      cnt      := cnt + 1.U
    }
  }

  io.dout_parallel := doutParallelReg
  io.dout_valid    := doutValidReg
}
