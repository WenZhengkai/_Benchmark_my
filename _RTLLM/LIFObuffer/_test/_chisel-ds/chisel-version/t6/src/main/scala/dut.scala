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
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W)))) // Stack memory with 4 entries
  val SP = RegInit(4.U(3.W)) // Stack pointer (3 bits to represent 0-4)
  val EMPTY = Wire(Bool())
  val FULL = Wire(Bool())

  // Initialize outputs
  io.EMPTY := EMPTY
  io.FULL := FULL
  io.dataOut := 0.U

  // Logic for EMPTY and FULL flags
  EMPTY := SP === 4.U
  FULL := SP === 0.U

  // Buffer operations
  when(io.EN) {
    when(reset.asBool) {
      // Reset logic
      SP := 4.U
      stack_mem.foreach(_ := 0.U)
    }.otherwise {
      when(!io.RW && !FULL) {
        // Write operation (push)
        SP := SP - 1.U
        stack_mem(SP - 1.U) := io.dataIn
      }.elsewhen(io.RW && !EMPTY) {
        // Read operation (pop)
        io.dataOut := stack_mem(SP)
        stack_mem(SP) := 0.U
        SP := SP + 1.U
      }
    }
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
