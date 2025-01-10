import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Register for the valid signal of dequeue interface
  val rValid = RegInit(false.B)

  // Combinational logic for enq.ready
  io.enq.ready := io.deq.ready || !rValid

  // Logic for updating rValid
  when (io.enq.fire()) {
    rValid := true.B
  } .elsewhen (io.deq.ready) {
    rValid := false.B
  }

  // RegEnable for transferring data from enq to deq
  io.deq.bits := RegEnable(io.enq.bits, io.enq.fire())

  // Valid signal for the deq interface reflects rValid
  io.deq.valid := rValid
}
