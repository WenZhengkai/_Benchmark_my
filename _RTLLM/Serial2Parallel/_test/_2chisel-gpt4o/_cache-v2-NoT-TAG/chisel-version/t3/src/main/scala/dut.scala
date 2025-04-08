import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val din_serial = Input(Bool())        // Serial input data
    val din_valid = Input(Bool())        // Validity signal for input data
    val dout_parallel = Output(UInt(8.W))  // Parallel output data (8 bits wide)
    val dout_valid = Output(Bool())      // Validity signal for the output data
  })

  // Task 5: Reset and Initialization
  val cntReg = RegInit(0.U(4.W))         // 4-bit counter register
  val shiftReg = RegInit(0.U(8.W))       // 8-bit shift register
  val doutParallelReg = RegInit(0.U(8.W)) // Register for output parallel data
  val doutValidReg = RegInit(false.B)    // Register for dout_valid signal

  // Task 1: Counter Implementation
  when(io.din_valid) {
    cntReg := cntReg + 1.U
    when(cntReg === 8.U) {
      cntReg := 0.U     // Reset counter after 8 valid cycles
    }
  }

  // Task 2: Shift Register Logic
  when(io.din_valid) {
    shiftReg := Cat(shiftReg(6, 0), io.din_serial) // Shift left and append din_serial to LSB
  }

  // Task 3: Parallel Output Capture
  when(io.din_valid && cntReg === 8.U) {
    doutParallelReg := shiftReg // Latch the shift register when 8 valid bits are accumulated
  }

  // Task 4: Valid Signal Generation
  doutValidReg := io.din_valid && cntReg === 8.U // Assert dout_valid when 8 bits are valid

  // Connect registers to the output ports
  io.dout_parallel := doutParallelReg
  io.dout_valid := doutValidReg
}

// Generate Verilog for the dut module
/*
object dutMain extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
