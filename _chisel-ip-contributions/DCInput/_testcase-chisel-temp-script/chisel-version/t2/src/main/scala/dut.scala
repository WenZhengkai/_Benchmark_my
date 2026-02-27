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

  // Data forwarding logic
  drain := occupied && io.deq.ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Data handling logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Control logic
  when(load) {
    occupied := true.B
    hold := io.enq.bits
  }.elsewhen(drain) {
    occupied := false.B
  }

  // Ready signal logic
  ready_r := !occupied || drain
  io.enq.ready := ready_r
}
