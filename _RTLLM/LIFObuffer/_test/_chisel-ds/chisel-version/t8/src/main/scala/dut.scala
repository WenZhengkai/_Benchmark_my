import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W)) // 4-bit input data
    val RW = Input(Bool())        // Read/Write control signal
    val EN = Input(Bool())        // Enable signal
    val EMPTY = Output(Bool())    // Flag indicating if the buffer is empty
    val FULL = Output(Bool())     // Flag indicating if the buffer is full
    val dataOut = Output(UInt(4.W)) // 4-bit output data
  })

  // Internal stack memory and stack pointer
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W)))) // 4-entry stack memory
  val SP = RegInit(4.U(3.W)) // Stack pointer (0-4, 4 indicates empty)

  // Flags for EMPTY and FULL
  io.EMPTY := SP === 4.U
  io.FULL := SP === 0.U

  // Buffer operations on rising clock edge
  when(io.EN) {
    when(reset.asBool) {
      // Reset logic: clear stack and set SP to 4 (empty)
      stack_mem.foreach(_ := 0.U)
      SP := 4.U
    }.otherwise {
      when(!io.RW && !io.FULL) {
        // Write operation: push data onto the stack
        stack_mem(SP - 1.U) := io.dataIn
        SP := SP - 1.U
      }.elsewhen(io.RW && !io.EMPTY) {
        // Read operation: pop data from the stack
        io.dataOut := stack_mem(SP)
        stack_mem(SP) := 0.U // Clear the popped entry
        SP := SP + 1.U
      }
    }
  }
}
