import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data.cloneType))
    val deq = DecoupledIO(data.cloneType)
  })

  // Internal registers and wires
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)
  
  val drain = Wire(Bool())
  val load = Wire(Bool())

  // Determine drain condition: occupied and downstream ready
  drain := occupied && io.deq.ready
  
  // Determine load condition: valid input, module ready, and either downstream not ready or draining
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Update internal state
  when(load) {
    occupied := true.B
    hold := io.enq.bits
  }.elsewhen(drain) {
    occupied := false.B
  }

  // Control logic for ready signal
  ready_r := !occupied || drain

  // Data forwarding logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied
  
  // Signal to input source when we're ready to accept data
  io.enq.ready := ready_r
}
