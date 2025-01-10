import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data.cloneType))
    val deq = DecoupledIO(data.cloneType)
  })

  // Internal register and wire definitions
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Define the conditions for load and drain
  drain := occupied && io.deq.ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Data forwarding logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Control logic
  when(load) {
    hold := io.enq.bits
    occupied := true.B
  }.elsewhen(drain) {
    occupied := false.B
  }

  ready_r := (!occupied || drain) && !load
  io.enq.ready := ready_r
}
