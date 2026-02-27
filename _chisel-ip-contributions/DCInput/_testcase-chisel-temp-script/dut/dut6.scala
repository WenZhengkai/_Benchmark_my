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
  
  // Drain logic: we can drain data when we have data and downstream is ready
  drain := occupied && io.deq.ready
  
  // Load logic: we load data when valid input arrives, we're ready, and either 
  // downstream isn't ready or we're draining data simultaneously
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)
  
  // Data handling
  when (load) {
    hold := io.enq.bits
    occupied := true.B
  } .elsewhen (drain) {
    occupied := false.B
  }
  
  // When occupied, output the stored data, otherwise pass through input data
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  
  // Output is valid when either we have stored data or input is valid
  io.deq.valid := occupied || io.enq.valid
  
  // Ready signal logic: we're ready when we're not occupied or we're draining data
  ready_r := !occupied || drain
  io.enq.ready := ready_r
}
