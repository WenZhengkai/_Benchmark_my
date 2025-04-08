
import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))
    val RW = Input(Bool()) // read/write control signal
    val EN = Input(Bool()) // enable signal
    val dataOut = Output(UInt(4.W))
    val EMPTY = Output(Bool())
    val FULL = Output(Bool())
  })

  val stack_mem = Reg(Vec(4, UInt(4.W))) // LIFO stack memory
  val SP = RegInit(4.U(3.W)) // Stack Pointer initialized to 4 (empty)

  // Reset behavior: clear the stack and set pointer to 4
  when (reset.asBool()) {
    SP := 4.U
    for (i <- 0 until 4) {
      stack_mem(i) := 0.U
    }
  }.elsewhen(io.EN) {
    when (io.RW === false.B) { // Write operation
      when (SP =/= 0.U) { // Check if not full
        SP := SP - 1.U
        stack_mem(SP - 1.U) := io.dataIn
      }
    }.elsewhen(io.RW === true.B) { // Read operation
      when (SP =/= 4.U) { // Check if not empty
        io.dataOut := stack_mem(SP)
        stack_mem(SP) := 0.U
        SP := SP + 1.U
      }
    }
  }.otherwise {
    io.dataOut := 0.U
  }

  // Output flags
  io.EMPTY := (SP === 4.U)
  io.FULL := (SP === 0.U)
}
