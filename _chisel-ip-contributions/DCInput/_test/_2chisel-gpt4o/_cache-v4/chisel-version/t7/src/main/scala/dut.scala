import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data)) // Input interface for incoming data
    val deq = Decoupled(data)          // Output interface for processed data
  })

  // Registers and Wires for internal logic
  val ready_r = RegInit(true.B)        // Register to indicate readiness to accept new data
  val occupied = RegInit(false.B)      // Register to indicate buffer occupation status
  val hold = Reg(data.cloneType)       // Register for temporarily holding data
  val load = Wire(Bool())              // Wire for load condition checking
  val drain = Wire(Bool())             // Wire for drain condition checking

  // Data Forwarding Logic
  drain := occupied && io.deq.ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Data Handling Logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Control Logic
  when(load) {
    hold := io.enq.bits
    occupied := true.B
  } .elsewhen(drain) {
    occupied := false.B
  }

  ready_r := !load && (!occupied || drain)
  io.enq.ready := ready_r
}

