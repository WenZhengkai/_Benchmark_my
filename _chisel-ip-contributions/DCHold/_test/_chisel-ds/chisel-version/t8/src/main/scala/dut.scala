import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Internal registers
  val pValid = RegInit(false.B) // Indicates whether valid data is being held
  val pData = Reg(data)         // Holds the data of type D

  // Data storage and flow control logic
  when(io.enq.valid && !pValid) {
    // Capture incoming data when valid and no data is currently held
    pData := io.enq.bits
    pValid := true.B
  }.elsewhen(io.deq.ready && pValid) {
    // Unload data when consumer is ready and data is held
    pValid := false.B
  }

  // Output assignments
  io.deq.valid := pValid          // Indicates whether data is available
  io.deq.bits := pData            // Provides the held data for consumption
  io.enq.ready := !pValid         // Ready to accept new data only when no data is held
}

// Example usage
/*
object dut extends App {
  // Define a simple UInt data type for testing
  val dataType = UInt(8.W)
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(dataType), Array("--target-dir", "generated"))
}
*/
