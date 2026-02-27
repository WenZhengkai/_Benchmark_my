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

  // Default outputs
  io.data_out := 0.U
  io.valid_out := outputValid

  when(io.valid_in) {
    when(counter === 3.U) {
      // On the 4th valid input, output the accumulated sum
      accumulator := accumulator + io.data_in
      io.data_out := accumulator + io.data_in
      outputValid := true.B
      counter := 0.U
      accumulator := 0.U
    }.otherwise {
      // Accumulate input and increment counter
      accumulator := accumulator + io.data_in
      counter := counter + 1.U
      outputValid := false.B
    }
  }.otherwise {
    outputValid := false.B
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
