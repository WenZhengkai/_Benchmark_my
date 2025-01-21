import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Registers and wires for internal control logic
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Determine the load condition
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Determine the drain condition
  drain := occupied && io.deq.ready

  // Setting data forwarding rules
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Control logic for data loading and draining
  when (load) {
    hold := io.enq.bits
    occupied := true.B
  }
  
  when (drain) {
    occupied := false.B
  }

  // Ready signal logic
  ready_r := !occupied || drain || !load
  io.enq.ready := ready_r
}

