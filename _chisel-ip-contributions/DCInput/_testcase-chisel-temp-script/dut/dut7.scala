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
  
  // Control signals
  val drain = Wire(Bool())
  val load = Wire(Bool())
  
  // Determine when to drain data from the buffer
  drain := occupied && io.deq.ready
  
  // Determine when to load data into the buffer
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)
  
  // Set the output data
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  
  // Output valid when we have data (either occupied or valid input)
  io.deq.valid := occupied || (io.enq.valid && !load)
  
  // Ready to accept new data when we're not occupied or we're draining
  io.enq.ready := ready_r
  
  // Update registers based on load and drain operations
  when(load) {
    hold := io.enq.bits
    occupied := true.B
  }.elsewhen(drain) {
    occupied := false.B
  }
  
  // Update ready status
  ready_r := !occupied || drain
}
