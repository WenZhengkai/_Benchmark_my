
import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn  = Input(UInt(4.W))
    val RW      = Input(Bool())
    val EN      = Input(Bool())
    val EMPTY   = Output(Bool())
    val FULL    = Output(Bool())
    val dataOut = Output(UInt(4.W))
  })

  // Stack memory to hold 4 entries of 4-bit data
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  val SP = RegInit(4.U(3.W)) // Stack Pointer, initialized to 4 (empty)

  // Update EMPTY and FULL flags
  io.EMPTY := (SP === 4.U)
  io.FULL  := (SP === 0.U)

  // Output data - Default to zero unless reading
  io.dataOut := 0.U

  // Sequential logic on positive clock edge
  when (io.EN) {
    when (reset.asBool) {
      // Clear stack and set SP to initial empty state
      stack_mem.foreach(_ := 0.U)
      SP := 4.U
    }.otherwise {
      when (io.RW === false.B && !io.FULL) {
        // Write operation: Push data onto stack
        SP := SP - 1.U
        stack_mem(SP - 1.U) := io.dataIn
      } .elsewhen (io.RW === true.B && !io.EMPTY) {
        // Read operation: Pop data from stack
        io.dataOut := stack_mem(SP)
        stack_mem(SP) := 0.U // Clear data at the current SP
        SP := SP + 1.U
      }
    }
  }
}
