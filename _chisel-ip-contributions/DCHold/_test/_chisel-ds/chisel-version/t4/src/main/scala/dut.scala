import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Internal Registers
  val pValid = RegInit(false.B) // Indicates if there is valid data being held
  val pData = Reg(data)         // Holds the data of type D

  // Data Storage and Flow Control Logic
  when(pValid) {
    // When there is valid data, wait for deq.ready to unload it
    when(io.deq.ready) {
      pValid := false.B // Clear the valid flag
    }
  }.otherwise {
    // When there is no valid data, accept new data from enq.valid
    when(io.enq.valid) {
      pData := io.enq.bits // Capture the incoming data
      pValid := true.B     // Set the valid flag
    }
  }

  // Output Assignments
  io.deq.valid := pValid          // Indicate whether the data is available
  io.deq.bits := pData            // Provide the held data for consumption
  io.enq.ready := !pValid         // Indicate readiness to accept new data only when no data is currently being held
}

// Example instantiation with UInt as the data type
/*
object dut extends App {
  println("Generating the dut hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(UInt(8.W)), Array("--target-dir", "generated"))
}
*/
