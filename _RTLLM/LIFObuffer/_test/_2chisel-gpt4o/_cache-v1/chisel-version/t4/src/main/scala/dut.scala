
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

  // Stack memory with 4 entries of 4 bits each
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  
  // Stack pointer
  val SP = RegInit(4.U(3.W)) // Using 3 bits to account for positions 0-4

  when(io.EN) {
    when(reset.asBool) {
      // Reset condition: clearing stack, setting stack pointer to 4
      SP := 4.U
      stack_mem.foreach { mem => mem := 0.U }
    }.otherwise {
      when(io.RW) {
        // Read operation
        when(SP =/= 4.U) {
          io.dataOut := stack_mem(SP)
          stack_mem(SP) := 0.U // Clear the read memory
          SP := SP + 1.U
        }
      }.otherwise {
        // Write operation
        when(SP =/= 0.U) {
          SP := SP - 1.U
          stack_mem(SP) := io.dataIn
        }
      }
    }
  }

  // Update EMPTY and FULL flags
  io.EMPTY := (SP === 4.U)
  io.FULL := (SP === 0.U)

  // Default output (in case of no read)
  io.dataOut := 0.U
}
