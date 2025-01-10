import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Registers for the internal logic
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)

  // Wires for load and drain conditions
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Defining load and drain conditions
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)
  drain := occupied && io.deq.ready

  // Manage the data forwarding logic
  when(occupied) {
    io.deq.bits := hold
  } .otherwise {
    io.deq.bits := io.enq.bits
  }

  // Output validity logic
  io.deq.valid := io.enq.valid || occupied

  // Control logic for occupancy and data capturing
  when(load) {
    hold := io.enq.bits
    occupied := true.B
  } .elsewhen(drain) {
    occupied := false.B
  }

  // Control logic for ready signal
  ready_r := !load && (!occupied || drain)
  io.enq.ready := ready_r
}


