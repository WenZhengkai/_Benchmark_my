// package holding_register

import chisel3._
import chisel3.util._

class HoldingRegister[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data.cloneType))
    val deq = DecoupledIO(data.cloneType)
  })

  // Internal registers
  val pValid = RegInit(false.B)
  val pData = Reg(data.cloneType)

  // Default values
  io.enq.ready := !pValid
  io.deq.valid := pValid
  io.deq.bits := pData

  // State logic
  when(io.enq.fire) {
    pValid := true.B
    pData := io.enq.bits
  }.elsewhen(io.deq.fire) {
    pValid := false.B
  }
}
