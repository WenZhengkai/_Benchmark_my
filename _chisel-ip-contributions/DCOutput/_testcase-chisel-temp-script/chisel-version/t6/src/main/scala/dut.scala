import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Internal register that indicates if valid data is available to deq
  val rValid = RegInit(false.B)

  // Ready logic for the enq interface
  // io.enq.ready should be true if deq is ready or there is no valid data in the register
  io.enq.ready := !rValid || io.deq.ready

  // Register logic for the valid signal
  // Update the rValid register based on conditions
  when(io.enq.fire) {
    rValid := true.B // Set valid when data is enqueued
  } .elsewhen(io.deq.ready) {
    rValid := false.B // Clear valid when data is dequeued
  }

  // Data transfer logic with RegEnable
  // Transfer data when io.enq.fire is true
  val rData = RegEnable(io.enq.bits, io.enq.fire)

  // Connect the output data and valid signals to the internal registers
  io.deq.bits := rData
  io.deq.valid := rValid
}

