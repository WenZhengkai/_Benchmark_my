import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data.cloneType))
    val deq = Decoupled(data.cloneType)
  })

  val pValid = RegInit(false.B)
  val pData  = Reg(data.cloneType)

  // Accept new data only when buffer is empty.
  io.enq.ready := !pValid

  when(io.enq.fire) {
    pData  := io.enq.bits
    pValid := true.B
  }

  // Present held data to output.
  io.deq.valid := pValid
  io.deq.bits  := pData

  // Clear valid once consumer successfully takes the data.
  when(io.deq.fire) {
    pValid := false.B
  }
}
