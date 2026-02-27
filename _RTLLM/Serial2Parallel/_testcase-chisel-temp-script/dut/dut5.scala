import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool())
    val din_valid = Input(Bool())
    val dout_parallel = Output(UInt(8.W))
    val dout_valid = Output(Bool())
  })

  // Counter to track the number of serial bits received
  val cnt = RegInit(0.U(4.W))
  
  // Register to accumulate the serial input data
  val shiftReg = RegInit(0.U(8.W))
  
  // Default output values
  io.dout_parallel := shiftReg
  io.dout_valid := false.B

  when(io.din_valid) {
    // When input is valid, shift in the new bit to MSB and shift everything else right
    shiftReg := Cat(io.din_serial, shiftReg(7, 1))
    
    // Increment counter
    cnt := cnt + 1.U
    
    // When counter reaches 8, we've received all 8 bits
    when(cnt === 7.U) {
      // Reset counter
      cnt := 0.U
      // Set output valid signal
      io.dout_valid := true.B
    }
  }
}

// Optional: Object to generate Verilog
/*
object dutDriver extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
