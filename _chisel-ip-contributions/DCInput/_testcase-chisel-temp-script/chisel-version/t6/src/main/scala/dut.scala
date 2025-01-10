import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data.cloneType))
    val deq = Decoupled(data.cloneType)
  })

  // Registers and initial states
  val ready_r   = RegInit(true.B)
  val occupied  = RegInit(false.B)
  val hold      = Reg(data.cloneType)

  // Wires for load and drain conditions
  val load  = Wire(Bool())
  val drain = Wire(Bool())

  // Logic for load and drain conditions
  drain := occupied && io.deq.ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Data handling logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Control logic for load and drain
  when(load) {
    hold := io.enq.bits
    occupied := true.B
  }.elsewhen(drain) {
    occupied := false.B
  }

  // Ready logic
  ready_r := !load && (!occupied || drain)
  
  // Forward ready signal to input interface
  io.enq.ready := ready_r
}


