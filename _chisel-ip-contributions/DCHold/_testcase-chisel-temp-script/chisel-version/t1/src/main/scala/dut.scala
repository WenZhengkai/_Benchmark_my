import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Internal Registers
  val pValid = RegInit(false.B)
  val pData = Reg(data.cloneType)

  // Define the flow of data
  // When enqueuing data
  when(io.enq.valid && !pValid) {
    pData := io.enq.bits
    pValid := true.B
  }

  // When dequeuing data
  when(io.deq.ready && pValid) {
    pValid := false.B
  }

  // Output logic
  io.deq.valid := pValid
  io.deq.bits := pData
  io.enq.ready := !pValid
}

