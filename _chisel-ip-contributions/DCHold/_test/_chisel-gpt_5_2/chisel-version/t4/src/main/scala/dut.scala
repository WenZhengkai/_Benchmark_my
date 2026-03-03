import chisel3._
import chisel3.util._

/** Ready/valid holding register (1-entry skid/holding buffer).
  *
  * - No combinational path from enq -> deq (data is registered).
  * - Accepts new data only when empty (so at most every other cycle if
  *   producer/consumer alternate fill/drain).
  */
class dut[D <: Data](gen: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(gen))
    val deq = DecoupledIO(gen)
  })

  // Internal state
  val pValid = RegInit(false.B)
  val pData  = Reg(gen.cloneType)

  // Default outputs
  io.enq.ready := !pValid
  io.deq.valid := pValid
  io.deq.bits  := pData

  // Handshakes
  val enqFire = io.enq.valid && io.enq.ready
  val deqFire = io.deq.valid && io.deq.ready

  // Capture incoming data when empty and producer presents valid
  when(enqFire) {
    pData  := io.enq.bits
    pValid := true.B
  }

  // Unload/clear when consumer is ready and data is valid
  when(deqFire) {
    pValid := false.B
  }
}
