import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data.cloneType))
    val deq = Decoupled(data.cloneType)
  })

  val pValid = RegInit(false.B)
  val pData  = Reg(data.cloneType)

  when(!pValid && io.enq.valid) {
    pData  := io.enq.bits
    pValid := true.B
  }.elsewhen(pValid && io.deq.ready) {
    pValid := false.B
  }

  io.enq.ready := !pValid
  io.deq.valid := pValid
  io.deq.bits  := pData
}

// Optional elaboration entry point
/*
object dutMain extends App {
  emitVerilog(new dut(UInt(32.W)))
}
*/
