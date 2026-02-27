import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val d = Input(UInt(4.W))
    val valid_out = Output(Bool())
    val dout = Output(UInt(1.W))
  })

  val data = RegInit(0.U(4.W))
  val cnt = RegInit(0.U(2.W))
  val valid = RegInit(false.B)

  // Default output assignments
  io.valid_out := valid
  io.dout := data(3)

  when(cnt === 3.U) {
    data := io.d
    cnt := 0.U
    valid := true.B
  }.otherwise {
    cnt := cnt + 1.U
    valid := false.B
    data := Cat(data(2, 0), data(3))
  }
}

// Optional: Object to generate Verilog
/*
object dutDriver extends App {
  chisel3.emitVerilog(new dut())
}
*/
