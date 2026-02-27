import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val d = Input(UInt(4.W))        // 4-bit parallel data input
    val valid_out = Output(Bool()) // Valid signal indicating the availability of serial output
    val dout = Output(Bool())      // Serial output representing the converted data
  })

  // Internal registers
  val cnt = RegInit(0.U(2.W))  // 2-bit counter to track the bit position (0 to 3)
  val data = RegInit(0.U(4.W)) // Register to hold the current parallel input data

  // Output signals default values
  io.valid_out := false.B
  io.dout := false.B

  // Sequential logic
  when(cnt === 3.U) {
    // If counter reaches the last bit (3), load new data, reset counter, and set valid signal
    data := io.d             // Load the parallel data into the data register
    cnt := 0.U               // Reset the counter to 0
    io.valid_out := true.B   // Set valid signal to indicate data is ready
    io.dout := data(3)       // Output the most significant bit of the data register
  }.otherwise {
    // During other cycles, shift data left and increment the counter
    cnt := cnt + 1.U         // Increment the counter
    io.valid_out := false.B  // The valid signal remains inactive
    io.dout := data(2 - cnt) // Output the next bit based on the current counter
  }
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
