import chisel3._
import chisel3.util.DecoupledIO

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Registers
  val pValid = RegInit(false.B)
  val pData = Reg(data)

  // Data Storage and Flow Control
  when(io.enq.valid && io.enq.ready) {
    // Capture data when enq handshake occurs
    pData := io.enq.bits
    pValid := true.B
  }.elsewhen(io.deq.valid && io.deq.ready) {
    // Clear valid when deq handshake occurs
    pValid := false.B
  }

  // Output Assignments
  io.deq.valid := pValid
  io.deq.bits := pData
  io.enq.ready := !pValid
}
