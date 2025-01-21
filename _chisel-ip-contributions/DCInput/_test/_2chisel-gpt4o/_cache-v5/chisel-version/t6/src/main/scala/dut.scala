import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data.cloneType))
    val deq = DecoupledIO(data.cloneType)
  })

  // Registers and wires
  val ready_r = RegInit(true.B)
  val occupied = RegInit(false.B)
  val hold = Reg(data.cloneType)
  
  val drain = io.deq.ready && occupied
  val load = io.enq.valid && ready_r && (!io.deq.ready || drain)

  // Data forwarding logic
  when(drain) {
    occupied := false.B
  }.elsewhen(load) {
    occupied := true.B
    hold := io.enq.bits
  }

  ready_r := !occupied || drain || load

  // Data output handling
  io.deq.bits := Mux(occupied, hold, io.enq.bits)
  io.deq.valid := occupied || io.enq.valid

  // Input ready signal is controlled using ready_r
  io.enq.ready := ready_r
}
