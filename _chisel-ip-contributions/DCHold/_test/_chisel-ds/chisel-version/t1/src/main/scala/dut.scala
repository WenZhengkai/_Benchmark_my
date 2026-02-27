import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Internal registers
  val pValid = RegInit(false.B)
  val pData = Reg(data)

  // Data Storage and Flow Control Logic
  when(pValid) {
    // When data is held, wait for deq.ready to unload
    when(io.deq.ready) {
      pValid := false.B
    }
  }.otherwise {
    // When no data is held, accept new data if enq.valid is asserted
    when(io.enq.valid) {
      pValid := true.B
      pData := io.enq.bits
    }
  }

  // Output Assignments
  io.deq.valid := pValid
  io.deq.bits := pData
  io.enq.ready := !pValid
}

/*
object dut extends App {
  // Example instantiation with a UInt data type
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(UInt(8.W)), args)
}
*/
