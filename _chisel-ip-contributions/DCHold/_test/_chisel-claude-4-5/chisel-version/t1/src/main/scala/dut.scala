import chisel3._
import chisel3.util.DecoupledIO

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Registers
  val pValid = RegInit(false.B)
  val pData = Reg(data)

  // Data Storage and Flow Control Logic
  when(io.enq.fire && !pValid) {
    // Capture incoming data when enq handshake occurs and no data is held
    pData := io.enq.bits
    pValid := true.B
  }.elsewhen(io.deq.fire && pValid) {
    // Clear valid flag when deq handshake occurs
    pValid := false.B
  }

  // Handle simultaneous enq and deq
  when(io.enq.fire && io.deq.fire) {
    // If both fire simultaneously, capture new data and maintain valid
    pData := io.enq.bits
    pValid := true.B
  }

  // Output Assignments
  io.deq.valid := pValid
  io.deq.bits := pData
  io.enq.ready := !pValid
}

// Optional: Object for easier instantiation
object dut {
  def apply[D <: Data](data: D): dut[D] = {
    new dut(data)
  }
}
