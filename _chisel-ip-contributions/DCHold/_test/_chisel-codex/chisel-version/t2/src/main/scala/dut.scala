import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(chiselTypeOf(data)))
    val deq = Decoupled(chiselTypeOf(data))
  })

  // Holding registers
  val pValid = RegInit(false.B)
  val pData  = Reg(chiselTypeOf(data))

  // Interface outputs
  io.deq.valid := pValid
  io.deq.bits  := pData
  io.enq.ready := !pValid

  // Capture input when empty
  when(!pValid && io.enq.valid) {
    pData := io.enq.bits
    pValid := true.B
  }

  // Release held data on dequeue handshake
  when(pValid && io.deq.ready) {
    pValid := false.B
  }
}
