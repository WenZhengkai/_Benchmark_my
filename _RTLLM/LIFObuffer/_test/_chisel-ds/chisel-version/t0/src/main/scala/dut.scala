import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))
    val RW = Input(Bool())
    val EN = Input(Bool())
    val EMPTY = Output(Bool())
    val FULL = Output(Bool())
    val dataOut = Output(UInt(4.W))
  })

  // Internal signals
  val stackMem = RegInit(VecInit(Seq.fill(4)(0.U(4.W)))) // 4-entry stack memory
  val stackPtr = RegInit(4.U(3.W)) // Stack pointer (0-4)
  val empty = Wire(Bool())
  val full = Wire(Bool())

  // Default outputs
  io.EMPTY := false.B
  io.FULL := false.B
  io.dataOut := 0.U

  // Update empty and full flags
  empty := stackPtr === 4.U
  full := stackPtr === 0.U

  // Main logic
  when(io.EN) {
    when(reset.asBool()) {
      // Reset logic
      stackMem := VecInit(Seq.fill(4)(0.U(4.W)))
      stackPtr := 4.U
      io.EMPTY := true.B
      io.FULL := false.B
    }.otherwise {
      // Normal operation
      when(!io.RW && !full) {
        // Write operation (push)
        stackMem(stackPtr - 1.U) := io.dataIn
        stackPtr := stackPtr - 1.U
      }.elsewhen(io.RW && !empty) {
        // Read operation (pop)
        io.dataOut := stackMem(stackPtr)
        stackMem(stackPtr) := 0.U // Clear the popped entry
        stackPtr := stackPtr + 1.U
      }
      // Update flags
      io.EMPTY := empty
      io.FULL := full
    }
  }
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
