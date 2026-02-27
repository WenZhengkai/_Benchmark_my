import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val data_in = Input(UInt(8.W))
    val valid_in = Input(Bool())
    val data_out = Output(UInt(10.W))
    val valid_out = Output(Bool())
  })

  // Registers to store accumulated data and count
  val accumulator = RegInit(0.U(10.W))
  val counter = RegInit(0.U(2.W))
  val outputValid = RegInit(false.B)

  when(io.valid_in) {
    // Accumulate the input data
    accumulator := accumulator + io.data_in
    counter := counter + 1.U

    // Check if we've received 4 inputs
    when(counter === 3.U) {
      io.data_out := accumulator + io.data_in  // Add the 4th value
      outputValid := true.B
      // Reset for next accumulation
      accumulator := 0.U
      counter := 0.U
    }.otherwise {
      io.data_out := 0.U  // Output 0 when not enough data
      outputValid := false.B
    }
  }.otherwise {
    io.data_out := 0.U
    outputValid := false.B
  }

  io.valid_out := outputValid
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
