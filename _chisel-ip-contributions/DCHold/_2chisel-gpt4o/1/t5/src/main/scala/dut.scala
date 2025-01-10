import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(dataType))
    val deq = Decoupled(dataType)
  })

  // Internal registers
  val pValid = RegInit(false.B)
  val pData = Reg(dataType)

  // Data Storage and Flow Control
  when(io.enq.fire() && !pValid) {
    pData := io.enq.bits
    pValid := true.B
  }

  when(io.deq.fire() && pValid) {
    pValid := false.B
  }

  // Output Assignments
  io.deq.valid := pValid
  io.deq.bits := pData
  io.enq.ready := !pValid
}
