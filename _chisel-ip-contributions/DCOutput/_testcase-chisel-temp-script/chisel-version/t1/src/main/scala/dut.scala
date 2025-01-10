import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(dataType))
    val deq = Decoupled(dataType)
  })

  // Register to hold the validity of the output data
  val rValid = RegInit(false.B)

  // Combinatorial logic for io.enq.ready
  // io.enq.ready is true if io.deq is ready or no valid data is stored
  io.enq.ready := io.deq.ready || !rValid

  // Update the rValid register
  when(io.enq.fire) {
    // Data is successfully enqueued
    rValid := true.B
  }.elsewhen(io.deq.ready) {
    // Data is successfully dequeued
    rValid := false.B
  }

  // Transfer data to io.deq.bits with RegEnable
  io.deq.bits := RegEnable(io.enq.bits, io.enq.fire)

  // Output the valid status to deq interface
  io.deq.valid := rValid
}
