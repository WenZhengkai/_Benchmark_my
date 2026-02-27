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

  // Data can be drained when we have data stored and downstream is ready
  drain := occupied && io.deq.ready
  
  // Load condition: Valid input data available, module is ready to accept it,
  // and either downstream isn't ready or we're also draining data
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // When occupied, output comes from our storage register
  // Otherwise, data is passed through directly
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  
  // Output is valid when we have stored data or when there's valid input data
  io.deq.valid := occupied || (io.enq.valid && !load)
  
  // Ready to accept new data when not occupied or when draining
  io.enq.ready := ready_r
  
  // State updates
  when(load) {
    hold := io.enq.bits
    occupied := true.B
  }.elsewhen(drain) {
    occupied := false.B
  }
  
  // Update ready state for next cycle
  ready_r := !occupied || drain
}
