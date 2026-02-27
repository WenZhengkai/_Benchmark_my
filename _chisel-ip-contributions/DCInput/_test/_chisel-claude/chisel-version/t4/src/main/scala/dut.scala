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

  // Determine drain condition: we drain when we're occupied and downstream is ready
  drain := occupied && io.deq.ready
  
  // Determine load condition: we load when upstream is valid, we're ready, 
  // and either downstream isn't ready or we're simultaneously draining
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Update occupied state
  when(load) {
    occupied := true.B
  }.elsewhen(drain) {
    occupied := false.B
  }

  // Update hold register when loading
  when(load) {
    hold := io.enq.bits
  }

  // Set output data
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  
  // Output is valid when we're occupied or have valid input
  io.deq.valid := occupied || io.enq.valid
  
  // Update ready state: we're ready when not occupied or when draining
  ready_r := !occupied || drain
  
  // Connect ready signal to input interface
  io.enq.ready := ready_r
}
