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

  // Counter logic
  when(cnt === 3.U) {
    cnt := 0.U
    data := io.d
    valid := true.B
  }.otherwise {
    cnt := cnt + 1.U
    data := Cat(data(2, 0), data(3))
    valid := false.B
  }

  // Output assignments
  io.valid_out := valid
  io.dout := data(3)
}
