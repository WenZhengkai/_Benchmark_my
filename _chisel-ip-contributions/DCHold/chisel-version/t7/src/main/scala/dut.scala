// package circuit

import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data.cloneType))
    val deq = DecoupledIO(data.cloneType)
  })

  // Internal state
  val pValid = RegInit(false.B)
  val pData = Reg(data.cloneType)

  // Default values
  io.enq.ready := !pValid
  io.deq.valid := pValid
  io.deq.bits := pData

  // Control logic
  when (io.enq.valid && !pValid) {
    pValid := true.B
    pData := io.enq.bits
  }.elsewhen (io.deq.ready && pValid) {
    pValid := false.B
  }
}
