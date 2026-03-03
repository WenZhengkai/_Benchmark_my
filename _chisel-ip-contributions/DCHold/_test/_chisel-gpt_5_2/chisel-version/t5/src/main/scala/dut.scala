import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Holding registers
  val pValid = RegInit(false.B)
  val pData  = Reg(chiselTypeOf(data))

  // Ready/valid interface behavior (no combinational path from enq to deq)
  io.enq.ready := !pValid
  io.deq.valid := pValid
  io.deq.bits  := pData

  // Handshakes
  val enqFire = io.enq.valid && io.enq.ready
  val deqFire = io.deq.valid && io.deq.ready

  // Capture when empty and producer fires
  when(enqFire) {
    pData  := io.enq.bits
    pValid := true.B
  }

  // Release when consumer fires
  when(deqFire) {
    pValid := false.B
  }
}
