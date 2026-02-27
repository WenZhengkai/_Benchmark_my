import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val data_in = Input(UInt(8.W))  // 8-bit input data
    val valid_in = Input(Bool())   // Indicates readiness to receive new data
    val valid_out = Output(Bool()) // Signals when the accumulation of 4 inputs is ready
    val data_out = Output(UInt(10.W)) // 10-bit accumulated output data
  })

  // Register to track the count of valid inputs received
  val count = RegInit(0.U(2.W)) // 2-bit register, since we only need to count up to 4
  val sum = RegInit(0.U(10.W))  // 10-bit register for the accumulated sum
  val valid_out_reg = RegInit(false.B) // Register to store valid_out signal

  // Default output assignments
  io.data_out := 0.U
  io.valid_out := false.B

  // Accumulation logic
  when(io.valid_in) {
    // Increment the count of received values and add the current data_in to the sum
    count := count + 1.U
    sum := sum + io.data_in

    // When 4 inputs are accumulated, set outputs
    when(count === 3.U) { // Previous count was 3, this is the 4th value
      io.data_out := sum + io.data_in
      io.valid_out := true.B

      // Reset the sum and count for the next batch
      sum := 0.U
      count := 0.U
    } .otherwise {
      // Valid out remains low if not yet 4 inputs
      io.valid_out := false.B
    }
  }
}
