
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

  // Parameters
  val DEPTH = 4

  // Memory and stack pointer
  val stack_mem = RegInit(VecInit(Seq.fill(DEPTH)(0.U(4.W))))
  val sp = RegInit(DEPTH.U(log2Ceil(DEPTH + 1).W))

  // Initial flag status
  io.EMPTY := (sp === DEPTH.U)
  io.FULL := (sp === 0.U)
  io.dataOut := 0.U

  // Synchronous operations on clock edge
  when(io.EN) {
    when(reset.asBool()) {
      // On reset, clear the stack and set stack pointer
      sp := DEPTH.U
      for (i <- 0 until DEPTH) {
        stack_mem(i) := 0.U
      }
    }.elsewhen(io.RW) {
      // Read operation
      when(!io.EMPTY) {
        io.dataOut := stack_mem(sp)
        stack_mem(sp) := 0.U
        sp := sp + 1.U
      }
    }.otherwise {
      // Write operation
      when(!io.FULL) {
        sp := sp - 1.U
        stack_mem(sp) := io.dataIn
      }
    }
  }
}
