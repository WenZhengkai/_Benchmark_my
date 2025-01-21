import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Initialize registers and wires
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Determine load and drain conditions
  drain := occupied && io.deq.ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Data handling logic
  when(load) {
    hold := io.enq.bits
  }

  // Control logic
  when(load) { 
    occupied := true.B 
  }
  when(drain) { 
    occupied := false.B 
  }

  ready_r := !occupied || drain || load

  // Assign outputs based on internal state
  io.enq.ready := ready_r
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied
}

