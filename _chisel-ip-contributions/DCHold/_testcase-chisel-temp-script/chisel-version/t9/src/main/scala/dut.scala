import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data.cloneType))
    val deq = Decoupled(data.cloneType)
  })

  val pValid = RegInit(false.B)
  val pData  = Reg(chiselTypeOf(io.enq.bits))

  io.enq.ready := !pValid
  io.deq.valid := pValid
  io.deq.bits  := pData

  when(io.enq.valid && io.enq.ready) {
    pData  := io.enq.bits
    pValid := true.B
  }

  when(io.deq.valid && io.deq.ready) {
    pValid := false.B
  }
}
