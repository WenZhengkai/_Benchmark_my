import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial   = Input(Bool())
    val din_valid    = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid    = Output(Bool())
  })

  // 4-bit counter to track number of bits received
  val cnt = RegInit(0.U(4.W))
  
  // 8-bit shift register to store serial data
  val shiftReg = RegInit(0.U(8.W))
  
  // Output valid register
  val validReg = RegInit(false.B)

  // Default output valid is false
  io.dout_valid := validReg
  validReg := false.B

  when(io.din_valid) {
    // Shift in new bit from MSB side
    shiftReg := Cat(shiftReg(6, 0), io.din_serial)
    
    // Increment counter
    cnt := cnt + 1.U
    
    // When counter reaches 8, set valid output
    when(cnt === 7.U) {
      validReg := true.B
      cnt := 0.U
    }
  }

  // Output the parallel data
  io.dout_parallel := shiftReg
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
