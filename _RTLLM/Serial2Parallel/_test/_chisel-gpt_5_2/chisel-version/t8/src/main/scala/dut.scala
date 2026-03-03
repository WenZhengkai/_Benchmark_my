import chisel3._
import chisel3.util._

/**
  * dut: Serial-to-parallel (8-bit) converter
  *
  * - Collects 8 valid serial bits (din_serial when din_valid=1)
  * - Places incoming bits from MSB to LSB in dout_parallel
  * - Asserts dout_valid for 1 cycle when 8 bits have been received
  */
class dut extends Module {
  val io = IO(new Bundle {
    val din_serial    = Input(Bool())
    val din_valid     = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid    = Output(Bool())
  })

  val shiftReg = RegInit(0.U(8.W))
  val cnt      = RegInit(0.U(4.W)) // counts received valid bits (0..8)

  // Default: output not valid unless we complete a word this cycle
  io.dout_valid    := false.B
  io.dout_parallel := shiftReg

  when(io.din_valid) {
    // Shift left and append new bit into LSB.
    // After 8 bits: first received ends up at MSB, last received at LSB.
    shiftReg := Cat(shiftReg(6, 0), io.din_serial)

    when(cnt === 7.U) {
      // This is the 8th valid bit
      cnt := 0.U
      io.dout_valid := true.B
      // Present the completed byte immediately on dout_parallel
      io.dout_parallel := Cat(shiftReg(6, 0), io.din_serial)
    }.otherwise {
      cnt := cnt + 1.U
    }
  }
}
