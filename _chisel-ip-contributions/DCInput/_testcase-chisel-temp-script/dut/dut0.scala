import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data.cloneType))
    val deq = DecoupledIO(data.cloneType)
  })

  // Register to track whether the module is ready to accept new data
  val ready_r = RegInit(true.B)
  
  // Register to track whether the internal buffer holds unsent data
  val occupied = RegInit(false.B)
  
  // Register to store the data when it is temporarily held
  val hold = Reg(data.cloneType)
  
  // Wire to determine if new data should be loaded
  val load = Wire(Bool())
  
  // Wire to determine if data should be drained (outputted)
  val drain = Wire(Bool())
  
  // Define drain condition: the module has data and downstream is ready
  drain := occupied && io.deq.ready
  
  // Define load condition: new data is available, module is ready, and either
  // downstream is not ready or we're already draining
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)
  
  // Set output data: if occupied, use stored data, otherwise pass through
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  
  // Set output valid: valid if there's data stored or valid input data
  io.deq.valid := occupied || (io.enq.valid && !load)
  
  // Set input ready signal based on internal ready state
  io.enq.ready := ready_r
  
  // Update internal state based on load and drain conditions
  when(load) {
    hold := io.enq.bits
    occupied := true.B
  }.elsewhen(drain) {
    occupied := false.B
  }
  
  // Update ready state based on occupied status, drain and load conditions
  ready_r := !occupied || drain
}
