import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(dataType))  // Input interface
    val deq = DecoupledIO(dataType)           // Output interface
  })

  // Internal registers for data storage and valid indication
  val pValid = RegInit(false.B)
  val pData = Reg(dataType)

  // Control logic for data storage
  when(io.enq.valid && !pValid && io.enq.ready) {
    pData := io.enq.bits             // Capture data into internal storage
    pValid := true.B                 // Set pValid to indicate data is available
  }

  // Control logic for data release
  when(io.deq.ready && pValid) {
    pValid := false.B                // Clear pValid once the data is successfully dequeued
  }

  // Output assignments
  io.deq.valid := pValid             // Valid output based on internal state
  io.deq.bits := pData               // Output data 
  io.enq.ready := !pValid            // Ready input when no data is being held

}

