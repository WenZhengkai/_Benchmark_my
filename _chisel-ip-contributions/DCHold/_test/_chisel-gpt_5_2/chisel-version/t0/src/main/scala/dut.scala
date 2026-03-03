import chisel3._
import chisel3.util._

/** Ready/valid holding register (1-deep, fully registered, no combinational bypass).
  * Accepts new data only when empty; holds it until successfully dequeued.
  */
class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Storage registers
  val pValid = RegInit(false.B)
  val pData  = Reg(chiselTypeOf(data))

  // Handshakes
  val enqFire = io.enq.valid && io.enq.ready
  val deqFire = io.deq.valid && io.deq.ready

  // Ready/valid signals
  io.enq.ready := !pValid
  io.deq.valid := pValid
  io.deq.bits  := pData

  // State updates
  when(enqFire) {
    pData  := io.enq.bits
    pValid := true.B
  }.elsewhen(deqFire) {
    pValid := false.B
  }
}
