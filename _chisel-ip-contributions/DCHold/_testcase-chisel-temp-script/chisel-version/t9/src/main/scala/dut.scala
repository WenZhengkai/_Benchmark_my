import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(dataType))
    val deq = DecoupledIO(dataType)
  })

  // Registers to hold data and valid state
  val pValid = RegInit(false.B)
  val pData = Reg(dataType)

  // Enqueue logic
  when(io.enq.fire()) {
    pData := io.enq.bits
    pValid := true.B
  }

  // Dequeue logic
  when(io.deq.fire()) {
    pValid := false.B
  }

  // Output signal assignments
  io.deq.valid := pValid
  io.deq.bits := pData
  io.enq.ready := !pValid
}

