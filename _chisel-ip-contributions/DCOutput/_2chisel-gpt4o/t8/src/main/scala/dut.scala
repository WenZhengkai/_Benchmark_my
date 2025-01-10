import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Register to hold the valid status
  val rValid = RegInit(false.B)
  
  // Ready logic: combinatorial signal
  io.enq.ready := io.deq.ready || !rValid

  // Valid register logic: updating valid register
  when (io.enq.fire) {
    rValid := true.B
  }.elsewhen(io.deq.ready) {
    rValid := false.B
  }
  
  // Data transfer logic: register enabling
  val rData = RegEnable(io.enq.bits, io.enq.fire)

  // Output assignment
  io.deq.bits := rData
  io.deq.valid := rValid
}
