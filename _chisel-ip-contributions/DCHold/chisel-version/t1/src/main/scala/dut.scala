import chisel3._
import chisel3.util._

class dut[D <: Data](gen: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen))
    val deq = Decoupled(gen)
  })

  // Task 1: Define and Initialize Registers
  val pValid = RegInit(false.B)  // Indicates if there's valid data held
  val pData = Reg(gen)  // Stores the data when valid

  // Task 2: Implement Data Storage Logic
  when(io.enq.valid && !pValid) {
    pData := io.enq.bits
    pValid := true.B
  }

  // Task 3: Implement Data Release Logic
  when(io.deq.ready && pValid) {
    // Clear pValid indicating the data has been forwarded
    pValid := false.B
  }

  // Task 4: Output Assignments
  io.deq.valid := pValid
  io.deq.bits := pData
  io.enq.ready := !pValid  // Ready to accept new data if no data is currently held
}

