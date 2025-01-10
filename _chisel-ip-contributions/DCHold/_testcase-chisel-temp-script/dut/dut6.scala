import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Registers for holding valid data and the data word itself
  val pValid = RegInit(false.B)
  val pData = Reg(data.cloneType)

  // Output assignments
  io.deq.valid := pValid
  io.deq.bits := pData

  // Logic to manage handshake and data transfer
  when(io.enq.valid && !pValid) {
    // Capture data from enq and mark the data as valid
    pData := io.enq.bits
    pValid := true.B
  }.elsewhen(io.deq.ready && pValid) {
    // Clear the valid data when deq is ready to accept it
    pValid := false.B
  }

  // ready signal for enq indicating data can be received when no valid data is held
  io.enq.ready := !pValid
}


