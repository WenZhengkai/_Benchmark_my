import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val data_in  = Input(UInt(8.W))
    val valid_in = Input(Bool())
    val valid_out = Output(Bool())
    val data_out = Output(UInt(10.W))
  })

  // Internal registers
  val sum = RegInit(0.U(10.W)) // 10-bit register to store accumulated sum
  val count = RegInit(0.U(3.W)) // 3-bit counter to count valid inputs
  
  // Default output values
  io.data_out := 0.U
  io.valid_out := false.B

  when(io.valid_in) {
    // Accumulate sum and increment count
    sum := sum + io.data_in
    count := count + 1.U

    // When 4 inputs are accumulated
    when(count === 3.U) {
      io.data_out := sum + io.data_in // output the accumulated sum
      io.valid_out := true.B         // set valid_out signal
      sum := 0.U                     // reset the sum
      count := 0.U                   // reset the counter
    }
  }
}
