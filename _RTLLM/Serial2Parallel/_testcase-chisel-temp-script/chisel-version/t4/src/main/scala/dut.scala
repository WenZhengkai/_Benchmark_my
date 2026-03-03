import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial    = Input(Bool())     // Serial input data
    val din_valid     = Input(Bool())     // Input valid
    val dout_parallel = Output(UInt(8.W)) // Parallel output
    val dout_valid    = Output(Bool())    // Output valid
  })

  val shiftReg = RegInit(0.U(8.W))
  val cnt      = RegInit(0.U(4.W)) // 4-bit counter (0~8)

  val nextData = Cat(shiftReg(6, 0), io.din_serial)

  io.dout_parallel := shiftReg
  io.dout_valid    := false.B

  when(io.din_valid) {
    shiftReg := nextData

    when(cnt === 7.U) {
      // 8th valid bit received: output complete parallel byte
      io.dout_parallel := nextData
      io.dout_valid    := true.B
      cnt := 0.U
    }.otherwise {
      cnt := cnt + 1.U
    }
  }
}
