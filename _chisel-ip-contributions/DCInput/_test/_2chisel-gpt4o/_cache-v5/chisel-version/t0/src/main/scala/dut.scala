import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Registers to hold the internal state
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)

  // Combinational logic for load and drain
  val load = io.enq.valid && ready_r && (!io.deq.ready || (occupied && io.deq.ready))
  val drain = occupied && io.deq.ready

  // Handle data forwarding logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)

  // Control `deq.valid` based on presence of valid input or stored data
  io.deq.valid := io.enq.valid || occupied

  // Update the ready signal
  ready_r := !occupied || drain || load

  // Manage the state and storage based on load and drain logic
  when(load) {
    hold := io.enq.bits
    occupied := true.B
  }.elsewhen(drain) {
    occupied := false.B
  }

  // Update ready signal for the input interface
  io.enq.ready := ready_r
}
