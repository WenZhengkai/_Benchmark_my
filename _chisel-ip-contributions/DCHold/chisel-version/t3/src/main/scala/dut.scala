import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data.cloneType))
    val deq = Decoupled(data.cloneType)
  })

  // Task 1: Define and Initialize Registers
  val pValid = RegInit(false.B) // Register to hold validity status
  val pData = Reg(data.cloneType) // Register to hold the data

  // Task 2: Implement Data Storage Logic
  when(io.enq.valid && !pValid) {
    pData := io.enq.bits
    pValid := true.B
  }

  // Task 3: Implement Data Release Logic
  when(io.deq.ready && pValid) {
    pValid := false.B
  }

  // Task 4: Output Assignments
  io.deq.valid := pValid
  io.deq.bits := pData
  io.enq.ready := !pValid
}

