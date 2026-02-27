import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W)) // 4-bit input data
    val RW = Input(Bool()) // Read/Write control signal (1 for read, 0 for write)
    val EN = Input(Bool()) // Enable signal
    val EMPTY = Output(Bool()) // Flag indicating if the buffer is empty
    val FULL = Output(Bool()) // Flag indicating if the buffer is full
    val dataOut = Output(UInt(4.W)) // 4-bit output data
  })

  // Internal stack memory (4 entries, each 4 bits wide)
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  val SP = RegInit(4.U(3.W)) // Stack pointer (3 bits to represent 0-4)
  val reset = WireDefault(false.B) // Reset signal (not exposed in IO)

  // Flags for EMPTY and FULL
  io.EMPTY := SP === 4.U
  io.FULL := SP === 0.U

  // Default output
  io.dataOut := 0.U

  when(reset) {
    // Reset logic: clear stack memory and set SP to 4 (empty)
    stack_mem.foreach(_ := 0.U)
    SP := 4.U
  }.otherwise {
    when(io.EN) {
      when(!io.RW && !io.FULL) {
        // Write operation (push): decrement SP and store data
        SP := SP - 1.U
        stack_mem(SP - 1.U) := io.dataIn
      }.elsewhen(io.RW && !io.EMPTY) {
        // Read operation (pop): increment SP and output data
        io.dataOut := stack_mem(SP)
        stack_mem(SP) := 0.U // Clear the popped entry
        SP := SP + 1.U
      }
    }
  }
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
