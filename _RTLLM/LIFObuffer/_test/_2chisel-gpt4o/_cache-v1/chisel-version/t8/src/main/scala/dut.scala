
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

  // Define the stack memory and stack pointer
  val stackMem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  val sp = RegInit(4.U(3.W)) // Stack pointer initialization, 3 bits to cover 0 to 4

  // Reset logic
  when (reset.asBool) {
    sp := 4.U
    for (i <- 0 until 4) {
      stackMem(i) := 0.U
    }
  } .otherwise {
    when(io.EN) {
      when(io.RW === false.B && !io.FULL) { // Write operation
        when(sp > 0.U) {
          sp := sp - 1.U
          stackMem(sp - 1.U) := io.dataIn
        }
      } .elsewhen(io.RW === true.B && !io.EMPTY) { // Read operation
        io.dataOut := stackMem(sp)
        when(sp < 4.U) {
          stackMem(sp) := 0.U // Clear the memory
          sp := sp + 1.U
        }
      }
    }
  }

  // Output Logic
  io.EMPTY := (sp === 4.U)
  io.FULL := (sp === 0.U)
  io.dataOut := 0.U // Default output value, updated only on read

  // Ensure dataOut is only set during a successful read operation.
  when(io.RW === true.B && io.EN && !io.EMPTY) {
    io.dataOut := stackMem(sp)
  }
}

