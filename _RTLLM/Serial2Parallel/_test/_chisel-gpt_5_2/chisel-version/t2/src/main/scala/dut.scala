import chisel3._
import chisel3.util._

/**
  * dut: Serial-to-parallel (8-bit) converter
  *
  * - Captures din_serial when din_valid is high
  * - After receiving 8 valid bits, presents them on dout_parallel
  *   with the first received bit as MSB and the last received bit as LSB
  * - dout_valid is asserted for 1 cycle when dout_parallel is updated
  */
class dut extends Module {
  val io = IO(new Bundle {
    val din_serial    = Input(Bool())
    val din_valid     = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid    = Output(Bool())
  })

  val shiftReg = RegInit(0.U(8.W))
  val cnt      = RegInit(0.U(4.W)) // counts number of valid bits received (0..8)

  // Default output valid low; pulse high when 8 bits complete
  val doutValidReg = RegInit(false.B)
  doutValidReg := false.B

  when(io.din_valid) {
    // Shift left, insert new bit into LSB.
    // This results in the first received bit ending up in MSB after 8 shifts.
    shiftReg := Cat(shiftReg(6, 0), io.din_serial)

    when(cnt === 7.U) {
      cnt := 0.U
      doutValidReg := true.B
    }.otherwise {
      cnt := cnt + 1.U
    }
  }

  io.dout_parallel := shiftReg
  io.dout_valid    := doutValidReg
}
