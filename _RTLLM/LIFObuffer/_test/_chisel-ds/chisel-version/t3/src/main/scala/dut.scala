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
  val stackPtr = RegInit(stackDepth.U(log2Ceil(stackDepth + 1).W))

  val empty = stackPtr === stackDepth.U
  val full = stackPtr === 0.U

  io.EMPTY := empty
  io.FULL := full

  when(io.EN) {
    when(reset.asBool()) {
      // Reset logic
      stackPtr := stackDepth.U
      stackMem.foreach(_ := 0.U)
    }.otherwise {
      when(!io.RW && !full) {
        // Write operation (push)
        stackPtr := stackPtr - 1.U
        stackMem(stackPtr - 1.U) := io.dataIn
      }.elsewhen(io.RW && !empty) {
        // Read operation (pop)
        io.dataOut := stackMem(stackPtr)
        stackMem(stackPtr) := 0.U
        stackPtr := stackPtr + 1.U
      }
    }
  }.otherwise {
    io.dataOut := 0.U
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), args)
}
*/
