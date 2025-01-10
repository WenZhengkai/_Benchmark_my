import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data)) // Input interface
    val deq = Decoupled(data) // Output interface
  })

  // Internal registers and wires
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Determine when to load new data
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Determine when to drain current data
  drain := occupied && io.deq.ready

  // Control logic for ready register
  ready_r := (!occupied && !load) || (drain && !load)

  // Assignments for the decoupled interfaces
  io.enq.ready := ready_r
  io.deq.valid := io.enq.valid || occupied
  io.deq.bits := Mux(occupied, hold, io.enq.bits)

  // Data handling logic
  when (load) {
    hold := io.enq.bits
    occupied := true.B
  } .elsewhen (drain) {
    occupied := false.B
  }
}

