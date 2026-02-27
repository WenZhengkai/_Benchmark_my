import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Internal Registers
  val pValid = RegInit(false.B) // Indicates if valid data is held
  val pData = Reg(data)         // Holds the data

  // Data Storage and Flow Control Logic
  when(pValid) {
    // When data is held, wait for deq.ready to unload
    when(io.deq.ready) {
      pValid := false.B // Clear pValid when data is unloaded
    }
  }.otherwise {
    // When no data is held, accept new data from enq
    when(io.enq.valid) {
      pData := io.enq.bits // Capture new data
      pValid := true.B     // Set pValid to indicate valid data is held
    }
  }

  // Output Assignments
  io.deq.valid := pValid          // Drive deq.valid with pValid
  io.deq.bits := pData            // Drive deq.bits with pData
  io.enq.ready := !pValid         // Drive enq.ready with !pValid
}

// Example usage with UInt as the data type
/*
object dut extends App {
  val dataType = UInt(8.W) // Example data type
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(dataType), Array("--target-dir", "generated"))
}
*/
