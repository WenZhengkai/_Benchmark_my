import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data.cloneType))
    val deq = DecoupledIO(data.cloneType)
  })

  // Registers and initial states
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)

  // Combinational wires for conditions
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Logic to determine load condition
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Logic to determine drain condition
  drain := occupied && io.deq.ready

  // Data handling and forwarding logic
  when(occupied) {
    io.deq.bits := hold
  }.otherwise {
    io.deq.bits := io.enq.bits
  }

  io.deq.valid := io.enq.valid || occupied

  // Control logic for load and drain operations
  when(load) {
    occupied := true.B
    hold := io.enq.bits
  }

  when(drain) {
    occupied := false.B
  }

  // Update `ready_r`
  ready_r := !occupied || drain || load
  io.enq.ready := ready_r
}

