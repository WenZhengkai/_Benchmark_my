import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Internal registers
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)

  // Combinational wires
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Determine the load and drain conditions
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)
  drain := occupied && io.deq.ready

  // Data forwarding logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Control logic
  when(load) {
    hold := io.enq.bits
    occupied := true.B
  }
  when(drain) {
    occupied := false.B
  }

  // Ready logic
  ready_r := !load && (!occupied || drain)
  io.enq.ready := ready_r
}

