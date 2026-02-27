import chisel3._
import chisel3.util._

class HoldingRegister[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data.cloneType))
    val deq = DecoupledIO(data.cloneType)
  })

  // Create registers to hold state
  val pValid = RegInit(false.B)
  val pData = Reg(data.cloneType)

  // Input ready is true when we don't have valid data stored
  io.enq.ready := !pValid

  // Output valid mirrors our stored valid state
  io.deq.valid := pValid
  io.deq.bits := pData

  // State transitions
  when(io.enq.ready && io.enq.valid) {
    // Capture new data when we're ready and input is valid
    pData := io.enq.bits
    pValid := true.B
  }.elsewhen(io.deq.ready && io.deq.valid) {
    // Clear valid flag when output is consumed
    pValid := false.B
  }
}

// Object definition to allow instantiation from other modules
object HoldingRegister {
  def apply[D <: Data](enq: DecoupledIO[D]): DecoupledIO[D] = {
    val holder = Module(new HoldingRegister(enq.bits.cloneType))
    holder.io.enq <> enq
    holder.io.deq
  }
}
