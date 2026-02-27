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
  val stackDepth = 4
  val stackMem = RegInit(VecInit(Seq.fill(stackDepth)(0.U(4.W))))
  val stackPtr = RegInit(stackDepth.U(log2Ceil(stackDepth + 1).W))
  val empty = RegInit(true.B)
  val full = RegInit(false.B)

  // Reset logic
  when(reset.asBool) {
    stackMem.foreach(_ := 0.U)
    stackPtr := stackDepth.U
    empty := true.B
    full := false.B
  }.otherwise {
    when(io.EN) {
      when(!io.RW && !full) { // Write operation (push)
        stackPtr := stackPtr - 1.U
        stackMem(stackPtr) := io.dataIn
        empty := false.B
        full := stackPtr === 1.U
      }.elsewhen(io.RW && !empty) { // Read operation (pop)
        io.dataOut := stackMem(stackPtr)
        stackMem(stackPtr) := 0.U
        stackPtr := stackPtr + 1.U
        full := false.B
        empty := stackPtr === (stackDepth - 1).U
      }
    }
  }

  // Output assignments
  io.EMPTY := empty
  io.FULL := full
  io.dataOut := stackMem(stackPtr)
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
