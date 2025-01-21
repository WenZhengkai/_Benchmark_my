import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Registers
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)

  // Wires for load and drain logic
  val load = Wire(Bool())
  val drain = Wire(Bool())

  // Load logic
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Drain logic
  drain := occupied && io.deq.ready

  // Data forwarding logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)

  // Valid signal for output
  io.deq.valid := io.enq.valid || occupied

  // Control logic for ready and occupied conditions
  when (load) {
    hold := io.enq.bits
    occupied := true.B
  } .elsewhen (drain) {
    occupied := false.B
  }

  // Ready condition logic
  ready_r := !load && (!occupied || drain)

  // Connect ready signal to input interface
  io.enq.ready := ready_r
}

