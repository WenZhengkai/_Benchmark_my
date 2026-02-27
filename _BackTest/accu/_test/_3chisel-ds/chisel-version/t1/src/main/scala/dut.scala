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
  val accumulator = RegInit(0.U(10.W))
  val counter = RegInit(0.U(2.W))
  val outputReg = RegInit(0.U(10.W))
  val validOutReg = RegInit(false.B)

  when(io.valid_in) {
    // Accumulate the input data
    accumulator := accumulator + io.data_in
    counter := counter + 1.U

    // When we've received 4 inputs
    when(counter === 3.U) {
      outputReg := accumulator + io.data_in  // Add current input to previous 3
      validOutReg := true.B
      accumulator := 0.U  // Reset accumulator
      counter := 0.U      // Reset counter
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
