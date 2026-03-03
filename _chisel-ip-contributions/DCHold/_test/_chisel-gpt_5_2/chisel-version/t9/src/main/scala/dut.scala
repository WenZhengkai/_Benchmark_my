import chisel3._
import chisel3.util._

/** Ready/valid holding register with no combinational path from enq to deq.
  * Accepts new data only when empty; holds until successfully dequeued.
  */
class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  val pValid = RegInit(false.B)
  val pData  = Reg(chiselTypeOf(data))

  // Output side
  io.deq.valid := pValid
  io.deq.bits  := pData

  // Input side (ready only when empty)
  io.enq.ready := !pValid

  // Handshakes
  val doEnq = io.enq.valid && io.enq.ready
  val doDeq = io.deq.valid && io.deq.ready

  when(doEnq) {
    pData  := io.enq.bits
    pValid := true.B
  }.elsewhen(doDeq) {
    pValid := false.B
  }
}
