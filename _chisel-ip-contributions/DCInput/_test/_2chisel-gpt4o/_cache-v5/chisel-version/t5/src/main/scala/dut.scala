import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data.cloneType)) // Incoming data interface
    val deq = Decoupled(data.cloneType)          // Outgoing data interface
  })

  // Registers
  val ready_r = RegInit(true.B)    // Indicates when the module can accept new data
  val occupied = RegInit(false.B)  // Indicates if there is data held
  val hold = Reg(data.cloneType)   // Stores data temporarily

  // Wires for data handling and control logic
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Load condition
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Drain condition
  drain := occupied && io.deq.ready

  // Determine when the module is ready to accept new data
  ready_r := !occupied || drain || load

  // Data handling logic
  when(load) {
    hold := io.enq.bits
  }

  // Occupied logic, marks the status of internal buffer
  when(load) {
    occupied := true.B
  } .elsewhen(drain) {
    occupied := false.B
  }

  // Connect output interface
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Connect input interface's ready signal
  io.enq.ready := ready_r
}
