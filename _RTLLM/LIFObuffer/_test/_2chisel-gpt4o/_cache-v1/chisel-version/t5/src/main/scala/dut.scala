
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

  // Stack memory and stack pointer
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  val SP = RegInit(4.U(3.W)) // Using 3 bits for stack pointer to address 5 positions (0-4)

  // Output wires
  io.dataOut := 0.U // Default output

  // Flags
  io.EMPTY := (SP === 4.U)
  io.FULL := (SP === 0.U)

  // When enabled...
  when(io.EN) {
    // Check for a reset (initialize stack)
    when(reset.asBool) {
      SP := 4.U
      stack_mem := VecInit(Seq.fill(4)(0.U(4.W)))
    } .otherwise {
      when(io.RW) {
        // Read operation (pop), if not empty
        when(!io.EMPTY) {
          io.dataOut := stack_mem(SP)
          stack_mem(SP) := 0.U
          SP := SP + 1.U
        }
      } .otherwise {
        // Write operation (push), if not full
        when(!io.FULL) {
          SP := SP - 1.U
          stack_mem(SP - 1.U) := io.dataIn
        }
      }
    }
  }
}
