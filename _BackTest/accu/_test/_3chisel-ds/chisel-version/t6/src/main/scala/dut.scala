import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val data_in = Input(UInt(8.W))
    val valid_in = Input(Bool())
    val data_out = Output(UInt(10.W))
    val valid_out = Output(Bool())
  })

  // Registers to store accumulated sum and count
  val sumReg = RegInit(0.U(10.W))
  val countReg = RegInit(0.U(2.W))
  val outputReg = RegInit(0.U(10.W))
  val validOutReg = RegInit(false.B)

  when(io.valid_in) {
    // Accumulate the input data
    sumReg := sumReg + io.data_in
    countReg := countReg + 1.U

    // When we have 4 inputs, output the sum
    when(countReg === 3.U) {
      outputReg := sumReg + io.data_in  // Add current input before output
      validOutReg := true.B
      sumReg := 0.U  // Reset sum for next accumulation
      countReg := 0.U // Reset count
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
