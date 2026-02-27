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
  
  // Define drain and load conditions
  drain := occupied && io.deq.ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)
  
  // Set output data
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  
  // Determine output validity
  io.deq.valid := occupied || (io.enq.valid && !load)
  
  // Input readiness
  io.enq.ready := ready_r
  
  // Update state on load/drain
  when(load) {
    hold := io.enq.bits
    occupied := true.B
  }.elsewhen(drain) {
    occupied := false.B
  }
  
  // Update ready_r based on occupied, drain, and load
  ready_r := !occupied || drain || load
}
