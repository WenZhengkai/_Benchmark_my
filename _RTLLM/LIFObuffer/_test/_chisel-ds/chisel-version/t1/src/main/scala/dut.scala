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

  val stackDepth = 4
  val stackMem = RegInit(VecInit(Seq.fill(stackDepth)(0.U(4.W))))
  val stackPointer = RegInit(stackDepth.U(log2Ceil(stackDepth + 1).W))
  val resetSignal = reset.asBool

  // Initialize outputs
  io.EMPTY := false.B
  io.FULL := false.B
  io.dataOut := 0.U

  // Update EMPTY and FULL flags
  io.EMPTY := stackPointer === stackDepth.U
  io.FULL := stackPointer === 0.U

  when(resetSignal) {
    // Reset logic
    stackMem.foreach(_ := 0.U)
    stackPointer := stackDepth.U
  }.elsewhen(io.EN) {
    when(!io.RW && !io.FULL) {
      // Write operation (push)
      stackMem(stackPointer - 1.U) := io.dataIn
      stackPointer := stackPointer - 1.U
    }.elsewhen(io.RW && !io.EMPTY) {
      // Read operation (pop)
      io.dataOut := stackMem(stackPointer)
      stackMem(stackPointer) := 0.U
      stackPointer := stackPointer + 1.U
    }
  }
}

/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
