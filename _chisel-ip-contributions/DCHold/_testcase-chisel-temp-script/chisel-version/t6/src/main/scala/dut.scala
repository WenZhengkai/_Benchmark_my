import chisel3._
import chisel3.util._

/** 
  * `DCHold` module: A ready/valid holding register.
  *
  * Design ensures no combinational paths and allows data transfers at most every other cycle.
  *
  * @param gen The data type parameter of the payload. 
  */
class dut[D <: Data](gen: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(gen)) // Input interface (producer -> enq)
    val deq = Decoupled(gen)         // Output interface (deq -> consumer)
  })

  // Registers to hold the state
  val pValid = RegInit(false.B)    // Controls if there is valid data in the holding register
  val pData = Reg(gen)             // Holds the current data

  // Data storage logic: Latch incoming data if enq.valid is true and pValid is false
  when(io.enq.valid && !pValid) {
    pData := io.enq.bits  // Store incoming data in the register
    pValid := true.B      // Mark the register as holding valid data
  }

  // Data release logic: Clear pValid if deq.ready is true and pValid is true
  when(io.deq.ready && pValid) {
    pValid := false.B     // Clear valid status as data is consumed
  }

  // Output interface assignments
  io.deq.valid := pValid       // Output valid signal mirrors the internal valid flag
  io.deq.bits := pData         // Output data comes from the stored register

  io.enq.ready := !pValid      // Ready to receive new data only if no valid data is being held
}
