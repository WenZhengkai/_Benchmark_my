import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Registers for readiness and status
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)

  // Combinational wires for load and drain
  val load = io.enq.valid && ready_r && (!io.deq.ready || (occupied && io.deq.ready))
  val drain = occupied && io.deq.ready

  // Handle data forwarding
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Control logic
  when(load) {
    hold := io.enq.bits
    occupied := true.B
  } .elsewhen(drain) {
    occupied := false.B
  }

  // Determine module's ready status
  ready_r := (!occupied && !load) || (drain && !load)
  io.enq.ready := ready_r
}
