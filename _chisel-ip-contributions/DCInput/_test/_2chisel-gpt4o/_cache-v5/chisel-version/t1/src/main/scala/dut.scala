import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(dataType))
    val deq = DecoupledIO(dataType)
  })

  // Registers and Wires
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(dataType)
  
  // Wire to determine whether to load new data
  val load = WireDefault(io.enq.valid && ready_r && (!io.deq.ready || drain))
  // Wire to determine whether to drain data
  val drain = WireDefault(occupied && io.deq.ready)

  // Data Forwarding Logic
  when (occupied) {
    io.deq.bits := hold
  } .otherwise {
    io.deq.bits := io.enq.bits
  }

  // Data Valid Logic
  io.deq.valid := io.enq.valid || occupied

  // Control Logic for Loading Data
  when (load) {
    occupied := true.B
    hold := io.enq.bits
  }

  // Control Logic for Draining Data
  when (drain) {
    occupied := false.B
  }

  // Ready condition determination
  ready_r := !occupied || drain || load

  // Handling the ready signals
  io.enq.ready := ready_r
}

