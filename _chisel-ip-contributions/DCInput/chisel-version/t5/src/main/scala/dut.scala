import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Internal state
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data)

  // Combinational logic to determine load and drain conditions
  val load = io.enq.valid && ready_r && (!io.deq.ready || occupied)
  val drain = occupied && io.deq.ready

  // Data forwarding logic
  when(load) {
    hold := io.enq.bits
  }

  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := occupied || io.enq.valid

  // Control logic for ready and occupied states
  when(load) {
    occupied := true.B
  }.elsewhen(drain) {
    occupied := false.B
  }

  ready_r := !load && (!occupied || drain)
  io.enq.ready := ready_r
}


