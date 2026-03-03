import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool())
    val din_valid = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid = Output(Bool())
  })

  // 4-bit counter to track the number of received bits
  val cnt = RegInit(0.U(4.W))
  
  // 8-bit shift register to store serial input data
  val shift_reg = RegInit(0.U(8.W))
  
  // Output valid register
  val valid_reg = RegInit(false.B)

  // Counter logic
  when(io.din_valid) {
    when(cnt === 7.U) {
      cnt := 0.U
    }.otherwise {
      cnt := cnt + 1.U
    }
  }

  // Shift register logic - shift from MSB to LSB
  when(io.din_valid) {
    shift_reg := Cat(shift_reg(6, 0), io.din_serial)
  }

  // Output valid logic
  when(io.din_valid && cnt === 7.U) {
    valid_reg := true.B
  }.otherwise {
    valid_reg := false.B
  }

  // Assign outputs
  io.dout_parallel := shift_reg
  io.dout_valid := valid_reg
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
