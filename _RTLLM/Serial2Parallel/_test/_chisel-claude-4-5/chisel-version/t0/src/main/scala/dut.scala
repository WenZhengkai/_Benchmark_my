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
  
  // 8-bit shift register to accumulate serial data
  val shiftReg = RegInit(0.U(8.W))
  
  // Output valid register
  val validReg = RegInit(false.B)
  
  // Output parallel data register
  val parallelReg = RegInit(0.U(8.W))

  // Default values
  validReg := false.B

  when(io.din_valid) {
    // Shift in the new bit from MSB to LSB
    shiftReg := Cat(shiftReg(6, 0), io.din_serial)
    
    // Increment counter
    cnt := cnt + 1.U
    
    // Check if 8 bits have been received
    when(cnt === 7.U) {
      // Output the complete 8-bit data
      parallelReg := Cat(shiftReg(6, 0), io.din_serial)
      validReg := true.B
      cnt := 0.U
    }
  }

  // Assign outputs
  io.dout_parallel := parallelReg
  io.dout_valid := validReg
}

// Generator object for Chisel
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
