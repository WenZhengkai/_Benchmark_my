import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Declare a register to hold the valid status
  val rValid = RegInit(false.B)

  // Ready logic: combinatorial
  // The enq.ready signal is true when the deq interface is ready or when rValid is false
  io.enq.ready := io.deq.ready || !rValid

  // Valid logic: sequential
  // Update rValid based on whether the data is enqueued or dequeued
  when (io.enq.fire) {
    rValid := true.B
  } .elsewhen (io.deq.fire) {
    rValid := false.B
  }

  // Data Transfer logic: registered when enqueuing
  // Use RegEnable to latch the data when enqueue is fired
  val regBits = RegEnable(io.enq.bits, io.enq.fire)

  // Output interface setup
  io.deq.bits  := regBits
  io.deq.valid := rValid
}
