import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool())
    val din_valid = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid = Output(Bool())
  })

  // 4-bit counter to track number of bits received
  val cnt = RegInit(0.U(4.W))
  
  // 8-bit shift register to accumulate serial data
  val shift_reg = RegInit(0.U(8.W))
  
  // Output register for parallel data
  val dout_parallel_reg = RegInit(0.U(8.W))
  
  // Output valid register
  val dout_valid_reg = RegInit(false.B)

  // Default values
  dout_valid_reg := false.B

  when(io.din_valid) {
    // Shift in the new bit from MSB side
    shift_reg := Cat(shift_reg(6, 0), io.din_serial)
    
    // Increment counter
    cnt := cnt + 1.U
    
    // Check if we've received 8 bits
    when(cnt === 7.U) {
      // Output the complete 8-bit data
      dout_parallel_reg := Cat(shift_reg(6, 0), io.din_serial)
      dout_valid_reg := true.B
      // Reset counter
      cnt := 0.U
    }
  }

  // Connect outputs
  io.dout_parallel := dout_parallel_reg
  io.dout_valid := dout_valid_reg
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
