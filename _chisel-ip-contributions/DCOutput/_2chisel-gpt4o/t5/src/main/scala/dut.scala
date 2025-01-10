import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(dataType))
    val deq = DecoupledIO(dataType)
  })

  // Register to hold the valid state for dequeuing
  val rValid = RegInit(false.B)
  val rData = RegEnable(next = io.enq.bits, enable = io.enq.fire)

  // Combinatorial logic for the ready signal of enqueue interface
  io.enq.ready := io.deq.ready || !rValid

  // Logic to update the rValid register indicating valid data
  when(io.enq.fire) {
    rValid := true.B
  }.elsewhen(io.deq.ready) {
    rValid := false.B
  }

  // Connect the rData register to the dequeuing interface
  io.deq.bits := rData
  io.deq.valid := rValid
}

