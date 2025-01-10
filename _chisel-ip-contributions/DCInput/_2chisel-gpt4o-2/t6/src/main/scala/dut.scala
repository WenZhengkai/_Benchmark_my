import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(dataType))
    val deq = Decoupled(dataType)
  })

  // Registers
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(dataType.cloneType)

  // Wires
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Define the load and drain conditions
  drain := occupied && io.deq.ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // The data forwarding / handling logic
  when(load) {
    hold := io.enq.bits
    occupied := true.B
  }.elsewhen(drain) {
    occupied := false.B
  }

  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Control logic for ready_r and io.enq.ready
  ready_r := (!occupied && !load) || (drain && !load)
  io.enq.ready := ready_r
}
