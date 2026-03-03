import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data.cloneType))
    val deq = Decoupled(data.cloneType)
  })

  val pValid = RegInit(false.B)
  val pData  = Reg(data.cloneType)

  // Accept input only when the holding register is empty.
  io.enq.ready := !pValid

  // Present held data to output.
  io.deq.valid := pValid
  io.deq.bits  := pData

  // Capture input data.
  when(io.enq.valid && io.enq.ready) {
    pData := io.enq.bits
    pValid := true.B
  }

  // Release held data after successful dequeue handshake.
  when(io.deq.valid && io.deq.ready) {
    pValid := false.B
  }
}
