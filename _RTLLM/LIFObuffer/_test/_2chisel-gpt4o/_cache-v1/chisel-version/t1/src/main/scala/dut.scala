
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

  // The stack memory array
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  
  // Stack pointer; initializes to 4 to indicate empty buffer
  val SP = RegInit(4.U(3.W))
  
  // Reset condition clears the stack and sets SP
  when (reset.asBool() || io.EN === false.B) {
    stack_mem := VecInit(Seq.fill(4)(0.U(4.W)))
    SP := 4.U
  } .otherwise {
    when (io.EN) {
      when (io.RW) {
        // Read operation: pop data from stack
        when (SP =/= 4.U) {
          io.dataOut := stack_mem(SP)
          stack_mem(SP) := 0.U
          SP := SP + 1.U
        } .otherwise {
          io.dataOut := 0.U // If attempting to read when empty
        }
      } .otherwise {
        // Write operation: push data onto stack
        when (SP =/= 0.U) {
          SP := SP - 1.U
          stack_mem(SP - 1.U) := io.dataIn
        }
      }
    }
  }

  // IO output for EMPTY and FULL flags
  io.EMPTY := (SP === 4.U)
  io.FULL := (SP === 0.U)
}
