import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Input ports
    val din_serial = Input(Bool())
    val din_valid = Input(Bool())
    
    // Output ports
    val dout_parallel = Output(UInt(8.W))
    val dout_valid = Output(Bool())
  })
  
  // Counter to track number of bits received (4-bit to count up to 8)
  val cnt = RegInit(0.U(4.W))
  
  // Shift register to store incoming serial data
  val shiftReg = RegInit(0.U(8.W))
  
  // Default output values
  io.dout_parallel := shiftReg
  io.dout_valid := false.B
  
  // Process serial input data on valid input
  when(io.din_valid) {
    // Shift in new bit (MSB first)
    shiftReg := Cat(shiftReg(6, 0), io.din_serial)
    
    // Increment counter
    cnt := cnt + 1.U
    
    // When counter reaches 8, set output valid and reset counter
    when(cnt === 7.U) {
      io.dout_valid := true.B
      cnt := 0.U
    }
  }
}

// Optional: Object for direct testing via command line
/*
object dutMain extends App {
  println("Generating the dut hardware")
  emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
