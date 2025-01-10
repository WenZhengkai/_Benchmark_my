import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(dataType))
    val deq = DecoupledIO(dataType)
  })

  // Internal registers to hold the state
  val pValid = RegInit(false.B)
  val pData = Reg(dataType)

  // Data Storage and Flow Control
  when(io.enq.valid && !pValid) {
    pData := io.enq.bits
    pValid := true.B
  }.elsewhen(io.deq.ready && pValid) {
    pValid := false.B
  }

  // Output assignments
  io.deq.valid := pValid
  io.deq.bits := pData
  io.enq.ready := !pValid
}
