
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

  // Stack size and width
  val stackDepth = 4
  val stackWidth = 4

  // Stack memory and stack pointer
  val stack_mem = Reg(Vec(stackDepth, UInt(stackWidth.W)))
  val SP = RegInit(stackDepth.U(log2Ceil(stackDepth + 1).W)) // Pointer starts at 4 (0, 1, 2, 3 are valid)

  // Reset condition
  when(reset.asBool()) {
    SP := stackDepth.U
    stack_mem.foreach(_ := 0.U)
  } .elsewhen(io.EN) {
    when(io.RW) { // Read operation
      when(SP =/= stackDepth.U) {
        io.dataOut := stack_mem(SP)
        stack_mem(SP) := 0.U
        SP := SP + 1.U
      } .otherwise {
        io.dataOut := 0.U // No valid data to read
      }
    } .otherwise { // Write operation
      when(SP =/= 0.U) {
        SP := SP - 1.U
        stack_mem(SP - 1.U) := io.dataIn
      }
    }
  } .otherwise {
    io.dataOut := 0.U
  }

  // Flags
  io.EMPTY := (SP === stackDepth.U)
  io.FULL := (SP === 0.U)

  // Output defaults
  io.dataOut := 0.U
}
