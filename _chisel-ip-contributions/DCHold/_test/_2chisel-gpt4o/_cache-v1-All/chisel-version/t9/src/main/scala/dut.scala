import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(dataType))
    val deq = Decoupled(dataType)
  })

  // Task 1: Define and Initialize Registers
  val pValid = RegInit(false.B)
  val pData = Reg(dataType)

  // Task 2: Implement Data Storage Logic
  when(io.enq.valid && !pValid) {
    // Latch incoming data
    pData := io.enq.bits
    pValid := true.B
  }

  // Task 3: Implement Data Release Logic
  when(io.deq.ready && pValid) {
    // Unload data
    pValid := false.B
  }

  // Task 4: Output Assignments
  io.deq.valid := pValid
  io.deq.bits := pData
  io.enq.ready := !pValid
}
