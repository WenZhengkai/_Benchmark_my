import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val data_in = Input(UInt(8.W))
    val valid_in = Input(Bool())
    val valid_out = Output(Bool())
    val data_out = Output(UInt(10.W))
  })

  // Registers to store accumulated data and count
  val accReg = RegInit(0.U(10.W))
  val countReg = RegInit(0.U(2.W))
  val outputReg = RegInit(0.U(10.W))
  val validOutReg = RegInit(false.B)

  when(io.valid_in) {
    // Accumulate the input data
    accReg := accReg + io.data_in
    countReg := countReg + 1.U

    // When we've received 4 inputs
    when(countReg === 3.U) {
      outputReg := accReg + io.data_in  // Final accumulation
      validOutReg := true.B
      // Reset the accumulator and counter
      accReg := 0.U
      countReg := 0.U
    }.otherwise {
      validOutReg := false.B
    }
  }.otherwise {
    validOutReg := false.B
  }

  io.data_out := outputReg
  io.valid_out := validOutReg
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
