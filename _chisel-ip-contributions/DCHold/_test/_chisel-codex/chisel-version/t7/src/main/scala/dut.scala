import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data.cloneType))
    val deq = Decoupled(data.cloneType)
  })

  val pValid = RegInit(false.B)
  val pData  = Reg(chiselTypeOf(io.enq.bits))

  // Enqueue when empty.
  when(!pValid && io.enq.valid) {
    pData := io.enq.bits
    pValid := true.B
  }

  // Dequeue when full and consumer is ready.
  when(pValid && io.deq.ready) {
    pValid := false.B
  }

  io.enq.ready := !pValid
  io.deq.valid := pValid
  io.deq.bits  := pData
}
