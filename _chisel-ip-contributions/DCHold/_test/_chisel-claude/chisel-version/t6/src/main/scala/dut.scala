import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data.cloneType))
    val deq = DecoupledIO(data.cloneType)
  })
  
  // Internal registers for valid status and data storage
  val pValid = RegInit(false.B)
  val pData = Reg(data.cloneType)
  
  // Default assignments
  io.enq.ready := !pValid
  io.deq.valid := pValid
  io.deq.bits := pData
  
  // State transition logic
  when(io.enq.valid && io.enq.ready) {
    pValid := true.B
    pData := io.enq.bits
  }.elsewhen(io.deq.valid && io.deq.ready) {
    pValid := false.B
  }
}
