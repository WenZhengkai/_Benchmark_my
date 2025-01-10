import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data.cloneType))
    val deq = Decoupled(data.cloneType)
  })

  // Register to track if the module is ready to accept new data
  val ready_r = RegInit(true.B)
  // Register to store if there's unsent data in the buffer
  val occupied = RegInit(false.B)
  // Register to hold the data temporarily
  val hold = Reg(data.cloneType)

  // Combinational wire to decide if new data should be loaded
  val load = Wire(Bool())
  // Combinational wire to decide if the data should be forwarded
  val drain = Wire(Bool())

  // Determine when to load new data
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Determine when to drain data
  drain := occupied && io.deq.ready

  // Output data logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Register logic for hold and occupied signals
  when(load) {
    hold := io.enq.bits
    occupied := true.B
  }
  when(drain) {
    occupied := false.B
  }

  // Update ready_r based on load, drain, and occupied signals
  when(!load) {
    ready_r := !occupied || drain
  }

  // Update the ready signal for the input
  io.enq.ready := ready_r
}

