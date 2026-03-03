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
  when(io.enq.valid && !pValid) {
    // Capture data when enq is valid and no data is currently held
    pData := io.enq.bits
    pValid := true.B
  }.elsewhen(io.deq.ready && pValid) {
    // Clear valid when data is successfully dequeued
    pValid := false.B
  }

  // Output Assignments
  io.deq.valid := pValid
  io.deq.bits := pData
  io.enq.ready := !pValid
}
