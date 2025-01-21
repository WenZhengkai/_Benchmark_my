import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))  // Input interface for incoming data
    val deq = DecoupledIO(data)           // Output interface for processed data
  })

  // Register to indicate if the module can accept new data
  val ready_r = RegInit(true.B)
  // Register to indicate if the internal data buffer holds unsent data
  val occupied = RegInit(false.B)
  // Register to hold the data when it is temporarily stored
  val hold = Reg(data)

  // Wire to determine if new data should be loaded into the module
  val load = Wire(Bool())
  // Wire to determine if data should be drained (output) from the module
  val drain = Wire(Bool())

  // Data forwarding logic
  drain := occupied && io.deq.ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Data handling logic
  when(occupied) {
    io.deq.bits := hold
  }.otherwise {
    io.deq.bits := io.enq.bits
  }
  io.deq.valid := io.enq.valid || occupied

  // Control logic
  when(load) {
    hold := io.enq.bits
    occupied := true.B
  }.elsewhen(drain) {
    occupied := false.B
  }

  // Update ready_r
  ready_r := !occupied || drain || load

  // Connect the ready signal of enq interface
  io.enq.ready := ready_r
}

