import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Register to store the valid state
  val rValid = RegInit(false.B)

  // Register to store the data
  val rData = RegEnable(io.enq.bits, io.enq.fire)

  // Ready logic for enq
  io.enq.ready := io.deq.ready || !rValid

  // Valid register logic
  when(io.deq.ready) {
    rValid := io.enq.fire || rValid && !io.deq.ready
  }.otherwise {
    rValid := rValid || io.enq.fire
  }

  // Set the output signals
  io.deq.valid := rValid
  io.deq.bits := rData
}
