import chisel3._
import chisel3.util._

class dut[D <: Data](gen: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(gen))  // Input interface for incoming data
    val deq = DecoupledIO(gen)           // Output interface for processed data
  })

  // Internal registers and wires
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(gen)
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Data forwarding logic
  // Determine if we should load new data
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Determine if draining is possible
  drain := occupied && io.deq.ready

  // Data handling logic
  when (occupied) {
    io.deq.bits := hold
  } .otherwise {
    io.deq.bits := io.enq.bits
  }

  // Valid signal for output
  io.deq.valid := io.enq.valid || occupied

  // Control logic
  when (load) {
    hold := io.enq.bits
    occupied := true.B
  } .elsewhen (drain) {
    occupied := false.B
  }
  
  // Determine the ready signal
  ready_r := !load && (!occupied || drain)
  io.enq.ready := ready_r
}

