import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Internal Registers
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)

  // Load and Drain Conditions
  val load = io.enq.valid && ready_r && (!io.deq.ready || occupied)
  val drain = occupied && io.deq.ready

  // Data Forwarding Logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Control Logic
  when(load) {
    ready_r := false.B
    occupied := true.B
    hold := io.enq.bits
  }.elsewhen(drain) {
    occupied := false.B
  }

  ready_r := !occupied || drain
  io.enq.ready := ready_r
}
