import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(chiselTypeOf(data)))
    val deq = DecoupledIO(chiselTypeOf(data))
  })

  // Internal registers
  val pValid = RegInit(false.B)
  val pData = Reg(chiselTypeOf(data))

  // Input interface logic - only ready when not holding valid data
  io.enq.ready := !pValid

  // Output interface logic - valid when holding valid data
  io.deq.valid := pValid
  io.deq.bits := pData

  // State and data management
  when(io.enq.fire) {
    // When enqueuing new data
    pValid := true.B
    pData := io.enq.bits
  }.elsewhen(io.deq.fire) {
    // When dequeuing data
    pValid := false.B
  }
}
