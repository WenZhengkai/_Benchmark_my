// package holding_register

import chisel3._
import chisel3.util._

class HoldingRegister[T <: Data](data: T) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data.cloneType))
    val deq = DecoupledIO(data.cloneType)
  })

  // Internal registers
  val pValid = RegInit(false.B)
  val pData = Reg(data.cloneType)

  // Default assignments
  io.enq.ready := !pValid
  io.deq.valid := pValid
  io.deq.bits := pData

  // Store data when:
  // - Input is valid (enq.valid)
  // - Module is ready to accept data (enq.ready, which is !pValid)
  when(io.enq.valid && !pValid) {
    pData := io.enq.bits
    pValid := true.B
  }

  // Clear stored data when:
  // - Output interface acknowledges receipt (deq.ready)
  // - Module has valid data to provide (deq.valid, which is pValid)
  when(io.deq.ready && pValid) {
    pValid := false.B
  }
}

// If you need a main to test/demonstrate
/*
object HoldingRegisterMain extends App {
  emitVerilog(new HoldingRegister(UInt(32.W)), Array("--target-dir", "generated"))
}
*/
