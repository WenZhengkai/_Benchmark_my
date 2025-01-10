import chisel3._
import chisel3.util._

// DCHold Module: A ready/valid holding register for data word retention
class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Internal register to hold state and data
  val pValid = RegInit(false.B)
  val pData = Reg(data.cloneType)

  // State transition logic based on handshake signals
  when(io.enq.valid && !pValid) {
    pData := io.enq.bits
    pValid := true.B
  } .elsewhen(io.deq.ready && pValid) {
    pValid := false.B
  }

  // Ready and Valid assignments for interfaces
  io.enq.ready := !pValid
  io.deq.valid := pValid
  io.deq.bits := pData
}

