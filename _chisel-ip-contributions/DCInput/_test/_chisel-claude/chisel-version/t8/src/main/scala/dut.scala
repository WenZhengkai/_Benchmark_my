import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data.cloneType))
    val deq = DecoupledIO(data.cloneType)
  })

  // State registers
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)

  // Control signals
  val drain = Wire(Bool())
  val load = Wire(Bool())

  // Condition to drain data: module has data and downstream is ready
  drain := occupied && io.deq.ready
  
  // Condition to load data: new data available, module ready, and 
  // either downstream not ready or we're draining data
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Update occupied status
  when(load) {
    occupied := true.B
  }.elsewhen(drain) {
    occupied := false.B
  }

  // Update hold register when loading
  when(load) {
    hold := io.enq.bits
  }

  // Ready signal logic
  ready_r := !occupied || drain

  // Input interface ready signal
  io.enq.ready := ready_r

  // Output interface logic
  io.deq.valid := io.enq.valid || occupied
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
}
