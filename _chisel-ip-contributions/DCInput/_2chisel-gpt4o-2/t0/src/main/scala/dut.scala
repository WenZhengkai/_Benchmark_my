import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data.cloneType))
    val deq = DecoupledIO(data.cloneType)
  })

  // Registers and Wires
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Calculating load and drain conditions
  drain := occupied && io.deq.ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Data Forwarding Logic
  when(occupied) {
    io.deq.bits := hold
  } .otherwise {
    io.deq.bits := io.enq.bits
  }

  io.deq.valid := io.enq.valid || occupied

  // Control Logic
  when (load) {
    occupied := true.B
    hold := io.enq.bits
  } .elsewhen (drain) {
    occupied := false.B
  }

  ready_r := (!occupied && !load) || (drain && !load)
  io.enq.ready := ready_r
}

