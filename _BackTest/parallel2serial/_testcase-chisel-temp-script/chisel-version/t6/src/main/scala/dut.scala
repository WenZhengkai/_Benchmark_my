import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val d = Input(UInt(4.W))
    val valid_out = Output(Bool())
    val dout = Output(UInt(1.W))
  })

  // Internal registers
  val data = RegInit(0.U(4.W))
  val cnt = RegInit(0.U(2.W))
  val valid = RegInit(false.B)

  // Default output assignments
  io.valid_out := valid
  io.dout := data(3)

  // Main logic
  when(cnt === 3.U) {
    data := io.d
    cnt := 0.U
    valid := false.B
  }.otherwise {
    cnt := cnt + 1.U
    valid := true.B
    data := Cat(data(2, 0), data(3))
  }
}

// Optional: Object for testing
/*
object dutMain extends App {
  println(new (chisel3.stage.ChiselStage).emitVerilog(new dut()))
}
*/
