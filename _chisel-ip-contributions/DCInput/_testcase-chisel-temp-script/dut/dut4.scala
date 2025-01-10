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

  // Load and Drain Logic
  drain := occupied && io.deq.ready
  load := io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Data Handling Logic
  when(load) {
    when(!occupied) {
      hold := io.enq.bits
    }
    occupied := true.B
  }

  when(drain) {
    occupied := false.B
  }

  // Output Logic
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := io.enq.valid || occupied

  // Ready Logic
  ready_r := !load && (!occupied || drain)

  // Handle ready signals of inputs/outputs
  io.enq.ready := ready_r
}
