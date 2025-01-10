import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data)) // Input interface
    val deq = DecoupledIO(data)          // Output interface
  })

  // Register for tracking valid data in the module
  val rValid = RegInit(false.B)
  
  // Combinatorial ready signal
  io.enq.ready := io.deq.ready || !rValid
  
  // Register-Enable for data transfer, enabled when data is enqueued
  when (io.enq.fire()) {
    io.deq.bits := io.enq.bits // Transfer data from enq to deq
  }

  // Managing the valid register
  when (io.enq.fire()) {
    rValid := true.B // Set valid when data is enqueued
  } .elsewhen(io.deq.ready) {
    rValid := false.B // Clear valid when data is dequeued
  }

  // Reflect the valid state on the deq interface
  io.deq.valid := rValid
}
