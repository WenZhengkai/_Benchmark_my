
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
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  val SP = RegInit(4.U(3.W))  // 3 bits needed to represent 0 to 4

  // Update EMPTY and FULL flags
  io.EMPTY := (SP === 4.U)
  io.FULL := (SP === 0.U)

  // Default output for dataOut
  io.dataOut := 0.U

  // Process on rising edge of clock if EN is high
  when(io.EN) {
    when(io.RW) { // Read operation
      when(!io.EMPTY) {
        io.dataOut := stack_mem(SP)
        stack_mem(SP) := 0.U // Clear the popped position (optional)
        SP := SP + 1.U
      }
    } .otherwise { // Write operation
      when(!io.FULL) {
        SP := SP - 1.U
        stack_mem(SP - 1.U) := io.dataIn
      }
    }
  }
}
