import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  val pValid = RegInit(false.B)
  val pData  = Reg(chiselTypeOf(io.enq.bits))

  // Default interface behavior
  io.enq.ready := !pValid
  io.deq.valid := pValid
  io.deq.bits  := pData

  // Capture incoming data when empty
  when(!pValid && io.enq.valid) {
    pData  := io.enq.bits
    pValid := true.B
  }

  // Release held data when consumed
  when(pValid && io.deq.ready) {
    pValid := false.B
  }
}
