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

  // Internal signals
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  val SP = RegInit(4.U(3.W)) // Stack Pointer, initialized to 4 (empty)
  val EMPTY = RegInit(true.B)
  val FULL = RegInit(false.B)

  // Update EMPTY and FULL flags
  EMPTY := SP === 4.U
  FULL := SP === 0.U

  // Buffer operations on rising edge of clock
  when(io.EN) {
    when(reset.asBool) {
      // Reset logic
      SP := 4.U
      stack_mem.foreach(_ := 0.U)
      EMPTY := true.B
      FULL := false.B
    }.otherwise {
      when(!io.RW && !FULL) {
        // Write operation (push)
        stack_mem(SP - 1.U) := io.dataIn
        SP := SP - 1.U
      }.elsewhen(io.RW && !EMPTY) {
        // Read operation (pop)
        io.dataOut := stack_mem(SP)
        stack_mem(SP) := 0.U
        SP := SP + 1.U
      }
    }
  }

  // Output assignments
  io.EMPTY := EMPTY
  io.FULL := FULL
  io.dataOut := stack_mem(SP)
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
