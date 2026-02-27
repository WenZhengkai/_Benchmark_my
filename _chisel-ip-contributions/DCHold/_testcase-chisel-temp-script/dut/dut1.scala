import chisel3._
import chisel3.util._

/** A ready/valid holding register that holds a data word until successfully unloaded
  * via the deq interface. No combinational paths through this module. Can accept
  * data at most every other cycle due to internal state.
  *
  * @param data The data type to be passed through this module
  */
class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data.cloneType))
    val deq = DecoupledIO(data.cloneType)
  })
  
  // Internal state registers
  val pValid = RegInit(false.B)
  val pData = Reg(data.cloneType)
  
  // Default values
  io.deq.valid := pValid
  io.deq.bits := pData
  io.enq.ready := !pValid
  
  // When we can accept data (pValid is false) and valid data is presented
  when(io.enq.valid && !pValid) {
    pData := io.enq.bits
    pValid := true.B
  }
  
  // When data is being dequeued (pValid is true and downstream is ready)
  when(pValid && io.deq.ready) {
    pValid := false.B
  }
}
