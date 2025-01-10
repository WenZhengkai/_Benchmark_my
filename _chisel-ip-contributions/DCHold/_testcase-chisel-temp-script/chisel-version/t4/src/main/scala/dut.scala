import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data.cloneType))
    val deq = Decoupled(data.cloneType)
  })

  // Registers to hold valid data and the data itself
  val pValid = RegInit(false.B)
  val pData = Reg(data.cloneType)

  // Input control logic
  when(io.enq.fire()) {
    pData := io.enq.bits
    pValid := true.B
  } .elsewhen(io.deq.fire()) {
    pValid := false.B
  }

  // Output assignments
  io.deq.valid := pValid
  io.deq.bits := pData
  io.enq.ready := !pValid
}
