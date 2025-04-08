
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

  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  val SP = RegInit(4.U(3.W)) // Stack Pointer initialized to 4 to indicate empty buffer

  // Flags
  io.EMPTY := (SP === 4.U)
  io.FULL := (SP === 0.U)

  io.dataOut := 0.U // Default output value

  when (io.EN) {
    when (reset.asBool) {
      SP := 4.U
      for (i <- 0 until 4) {
        stack_mem(i) := 0.U
      }
    } .otherwise {
      when (io.RW) { // Read operation
        when (!io.EMPTY) {
          io.dataOut := stack_mem(SP)
          stack_mem(SP) := 0.U // Clear the pop location
          SP := SP + 1.U
        }
      } .otherwise { // Write operation
        when (!io.FULL) {
          SP := SP - 1.U
          stack_mem(SP) := io.dataIn
        }
      }
    }
  }
}
