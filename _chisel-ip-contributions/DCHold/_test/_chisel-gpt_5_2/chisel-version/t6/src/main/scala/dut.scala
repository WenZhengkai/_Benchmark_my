import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  val pValid = RegInit(false.B)
  val pData  = Reg(chiselTypeOf(data))

  // Handshakes
  val enqFire = io.enq.valid && io.enq.ready
  val deqFire = io.deq.valid && io.deq.ready

  // Default interface behavior
  io.enq.ready := !pValid
  io.deq.valid := pValid
  io.deq.bits  := pData

  // State updates (no combinational path from enq to deq or vice-versa)
  when(enqFire) {
    pData  := io.enq.bits
    pValid := true.B
  }.elsewhen(deqFire) {
    pValid := false.B
  }
}
