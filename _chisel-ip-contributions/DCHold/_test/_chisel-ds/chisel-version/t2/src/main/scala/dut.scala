import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Internal Registers
  val pValid = RegInit(false.B) // Indicates whether valid data is being held
  val pData = Reg(data)         // Holds the data of type D

  // Data Storage and Flow Control Logic
  when(pValid) {
    // When data is being held, wait for deq.ready to unload it
    when(io.deq.ready) {
      pValid := false.B // Clear the valid flag
    }
  }.otherwise {
    // When no data is being held, accept new data from enq
    when(io.enq.valid) {
      pValid := true.B // Set the valid flag
      pData := io.enq.bits // Capture the incoming data
    }
  }

  // Output Assignments
  io.deq.valid := pValid // Indicate whether data is available for deq
  io.deq.bits := pData   // Provide the held data for deq
  io.enq.ready := !pValid // Indicate readiness to accept new data only when no data is being held
}

// Example instantiation with a specific data type
class Top extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(UInt(8.W)))
    val deq = Decoupled(UInt(8.W))
  })

  val dut = Module(new dut(UInt(8.W)))
  io.enq <> dut.io.enq
  io.deq <> dut.io.deq
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new Top, Array("--target-dir", "generated"))
}
*/
