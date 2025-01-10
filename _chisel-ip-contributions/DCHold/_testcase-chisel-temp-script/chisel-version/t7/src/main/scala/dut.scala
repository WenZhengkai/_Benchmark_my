import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Internal registers
  val pValid = RegInit(false.B)
  val pData = Reg(data)

  // Data Storage and Flow Control
  when(io.enq.fire() && !pValid) {
    // Capture the data when it's valid and nothing is currently held
    pData := io.enq.bits
    pValid := true.B
  }.elsewhen(io.deq.fire() && pValid) {
    // Clear the data when the consumer has taken it
    pValid := false.B
  }

  // Output assignments
  io.deq.valid := pValid
  io.deq.bits := pData
  io.enq.ready := !pValid

}
