import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data.cloneType))
    val deq = Decoupled(data.cloneType)
  })

  // Holding state
  val pValid = RegInit(false.B)
  val pData  = Reg(chiselTypeOf(data))

  // Interface signals
  io.enq.ready := !pValid
  io.deq.valid := pValid
  io.deq.bits  := pData

  // Load when empty and input handshake succeeds
  when(io.enq.fire) {
    pData  := io.enq.bits
    pValid := true.B
  }

  // Unload when output handshake succeeds
  when(io.deq.fire) {
    pValid := false.B
  }
}
