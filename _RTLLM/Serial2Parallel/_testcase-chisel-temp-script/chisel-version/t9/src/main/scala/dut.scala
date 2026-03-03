import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial    = Input(Bool())     // Serial input bit
    val din_valid     = Input(Bool())     // Serial input valid
    val dout_parallel = Output(UInt(8.W)) // 8-bit parallel output
    val dout_valid    = Output(Bool())    // Output valid
  })

  val shiftReg = RegInit(0.U(8.W))
  val cnt      = RegInit(0.U(4.W)) // counts received valid bits: 0..7
  val outReg   = RegInit(0.U(8.W))
  val outValid = RegInit(false.B)

  // Default: dout_valid is a one-cycle pulse when 8th valid bit arrives
  outValid := false.B

  when(io.din_valid) {
    when(cnt === 7.U) {
      // 8th bit received: form output byte (first bit becomes MSB, last becomes LSB)
      outReg   := Cat(shiftReg(6, 0), io.din_serial)
      outValid := true.B
      cnt      := 0.U
      shiftReg := 0.U
    }.otherwise {
      shiftReg := Cat(shiftReg(6, 0), io.din_serial)
      cnt      := cnt + 1.U
    }
  }

  io.dout_parallel := outReg
  io.dout_valid    := outValid
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
