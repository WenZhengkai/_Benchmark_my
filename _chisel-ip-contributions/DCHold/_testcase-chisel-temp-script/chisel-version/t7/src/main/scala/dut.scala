import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Task 1: Define and Initialize Registers
  // Register to hold validity of current data
  val pValid = RegInit(false.B)
  // Register to hold current data; left uninitialized
  val pData = Reg(data)

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
  // Connect pValid to deq's valid signal
  io.deq.valid := pValid
  // Connect pData to deq's bits when valid
  io.deq.bits := pData
  // enq is ready to accept new data when no valid data is being held
  io.enq.ready := !pValid
}
