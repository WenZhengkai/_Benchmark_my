import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn  = Input(UInt(4.W))
    val RW      = Input(Bool()) // 1 = read(pop), 0 = write(push)
    val EN      = Input(Bool())

    val EMPTY   = Output(Bool())
    val FULL    = Output(Bool())
    val dataOut = Output(UInt(4.W))
  })

  // 4 deep stack, 4-bit wide
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))

  // Stack pointer convention per spec:
  // SP == 4 => empty
  // SP == 0 => full
  // Push: write to (SP-1), then SP := SP-1
  // Pop : read from SP, clear it, then SP := SP+1
  val sp = RegInit(4.U(3.W)) // needs to represent 0..4

  val empty = (sp === 4.U)
  val full  = (sp === 0.U)

  io.EMPTY := empty
  io.FULL  := full

  val dataOutReg = RegInit(0.U(4.W))
  io.dataOut := dataOutReg

  when (reset.asBool) {
    sp := 4.U
    dataOutReg := 0.U
    for (i <- 0 until 4) {
      stack_mem(i) := 0.U
    }
  } .elsewhen (io.EN) {
    when (!io.RW) {
      // WRITE (push)
      when (!full) {
        val wrIdx = sp - 1.U
        stack_mem(wrIdx) := io.dataIn
        sp := sp - 1.U
      }
    } .otherwise {
      // READ (pop)
      when (!empty) {
        val rdIdx = sp
        dataOutReg := stack_mem(rdIdx)
        stack_mem(rdIdx) := 0.U
        sp := sp + 1.U
      }
    }
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
