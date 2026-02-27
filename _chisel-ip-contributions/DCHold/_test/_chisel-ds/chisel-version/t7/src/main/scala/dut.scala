import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Internal Registers
  val pValid = RegInit(false.B)
  val pData = Reg(data)

  // Data Storage and Flow Control Logic
  when(pValid) {
    // When pValid is true, wait for deq.ready to unload the data
    when(io.deq.ready) {
      pValid := false.B
    }
  }.otherwise {
    // When pValid is false, accept new data if enq.valid is asserted
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

// Example instantiation for testing
/*
object dut extends App {
  // Define a test data type (e.g., UInt of 8 bits)
  val testData = UInt(8.W)
  // Generate Verilog code for the dut module
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(testData), args)
}
*/
