import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial    = Input(Bool())
    val din_valid     = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid    = Output(Bool())
  })

  val shiftReg = RegInit(0.U(8.W))
  val cnt      = RegInit(0.U(4.W)) // counts number of valid bits received (0..8)

  // Default outputs
  io.dout_parallel := shiftReg
  io.dout_valid    := false.B

  when(io.din_valid) {
    // Shift left and insert new bit at LSB; after 8 bits, MSB is the earliest bit received
    shiftReg := Cat(shiftReg(6, 0), io.din_serial.asUInt)

    when(cnt === 7.U) {
      // This input is the 8th bit
      cnt := 0.U
      io.dout_valid := true.B
    } .otherwise {
      cnt := cnt + 1.U
    }
  }
}
