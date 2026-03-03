import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial    = Input(Bool())
    val din_valid     = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid    = Output(Bool())
  })

  val shiftReg    = RegInit(0.U(8.W))
  val cnt         = RegInit(0.U(4.W)) // counts 0 to 7 valid bits
  val doutReg     = RegInit(0.U(8.W))
  val doutValidReg = RegInit(false.B)

  // Default: output valid deasserted unless a full byte is completed this cycle
  doutValidReg := false.B

  when(io.din_valid) {
    val nextShift = Cat(shiftReg(6, 0), io.din_serial.asUInt)

    when(cnt === 7.U) {
      // 8th valid bit received: latch parallel output and assert valid
      doutReg      := nextShift
      doutValidReg := true.B
      cnt          := 0.U
    }.otherwise {
      cnt := cnt + 1.U
    }

    shiftReg := nextShift
  }

  io.dout_parallel := doutReg
  io.dout_valid    := doutValidReg
}

/*
object dut extends App {
  emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
