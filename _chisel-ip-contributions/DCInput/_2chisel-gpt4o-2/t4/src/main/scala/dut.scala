import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Internal registers and wires
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Define the drain condition
  drain := occupied && io.deq.ready

  // Define the load condition
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Handling the data output logic
  when (occupied) {
    io.deq.bits := hold
  } .otherwise {
    io.deq.bits := io.enq.bits
  }

  // Determine when to output data
  io.deq.valid := io.enq.valid || occupied

  // Control logic for loading data
  when (load) {
    hold := io.enq.bits
    occupied := true.B
  }

  // Control logic for draining data
  when (drain) {
    occupied := false.B
  }

  // Update readiness to accept new data
  ready_r := (!occupied && !load) || (drain && !load)
  io.enq.ready := ready_r
}

