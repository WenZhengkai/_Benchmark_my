import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(dataType))
    val deq = DecoupledIO(dataType)
  })

  // Task 1: Define and Initialize Registers
  val pValid = RegInit(false.B) // Register to indicate if valid data is held
  val pData = Reg(dataType) // Register for holding the data

  // Task 2: Implement Data Storage Logic
  when (io.enq.valid && !pValid && io.enq.ready) {
    pData := io.enq.bits
    pValid := true.B
  }

  // Task 3: Implement Data Release Logic
  when (io.deq.ready && pValid) {
    pValid := false.B
  }

  // Task 4: Output Assignments
  io.deq.valid := pValid
  io.deq.bits := pData
  io.enq.ready := !pValid
}
