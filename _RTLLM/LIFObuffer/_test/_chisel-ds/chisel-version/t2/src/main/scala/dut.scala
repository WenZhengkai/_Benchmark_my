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
  val stackPtr = RegInit(4.U(3.W)) // Stack pointer, initialized to 4 (empty)
  val emptyFlag = stackPtr === 4.U
  val fullFlag = stackPtr === 0.U

  // Output flags
  io.EMPTY := emptyFlag
  io.FULL := fullFlag

  // Default output
  io.dataOut := 0.U

  // Buffer operations
  when(io.EN) {
    when(reset.asBool) {
      // Reset logic
      stackMem.foreach(_ := 0.U) // Clear stack memory
      stackPtr := 4.U // Reset stack pointer
    }.otherwise {
      when(!io.RW && !fullFlag) {
        // Write operation (push)
        stackMem(stackPtr - 1.U) := io.dataIn
        stackPtr := stackPtr - 1.U
      }.elsewhen(io.RW && !emptyFlag) {
        // Read operation (pop)
        io.dataOut := stackMem(stackPtr)
        stackMem(stackPtr) := 0.U // Clear the popped entry
        stackPtr := stackPtr + 1.U
      }
    }
  }
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
