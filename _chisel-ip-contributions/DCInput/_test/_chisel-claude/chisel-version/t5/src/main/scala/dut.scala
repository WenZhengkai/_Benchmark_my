import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data.cloneType))
    val deq = DecoupledIO(data.cloneType)
  })

  // Registers and wires
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)
  
  val drain = Wire(Bool())
  val load = Wire(Bool())

  // Define conditions for drain and load
  drain := occupied && io.deq.ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Update registers based on load and drain conditions
  when(load) {
    occupied := true.B
    hold := io.enq.bits
  }.elsewhen(drain) {
    occupied := false.B
  }

  // Set output data
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  
  // Set valid and ready signals
  io.deq.valid := io.enq.valid || occupied
  ready_r := !occupied || drain
  io.enq.ready := ready_r

  // For debugging
  // printf(p"occupied: $occupied, drain: $drain, load: $load, ready_r: $ready_r\n")
}
