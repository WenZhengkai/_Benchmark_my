import chisel3._
import chisel3.util.DecoupledIO

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // Internal registers
  val pValid = RegInit(false.B)
  val pData = Reg(data)

  // Data storage and flow control logic
  // When enq fires (enq.valid && enq.ready) and pValid is false, capture data
  when(io.enq.fire && !pValid) {
    pData := io.enq.bits
    pValid := true.B
  }

  // When deq fires (deq.valid && deq.ready), clear the valid flag
  when(io.deq.fire) {
    pValid := false.B
  }

  // Handle the case when both enq and deq fire simultaneously
  when(io.enq.fire && io.deq.fire) {
    pData := io.enq.bits
    pValid := true.B
  }

  // Output assignments
  io.deq.valid := pValid
  io.deq.bits := pData
  io.enq.ready := !pValid
}

/*
object dut extends App {
  println("Generating Verilog for dut module...")
  (new chisel3.stage.ChiselStage).emitVerilog(
    new dut(UInt(8.W)),
    Array("--target-dir", "generated")
  )
}
*/
