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

  // 4-entry stack memory, 4-bit wide
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))

  // Stack pointer per spec:
  // SP = 4 indicates empty; valid "next free" scheme where top element is at SP when popping.
  // Push: write at (SP-1), then SP := SP-1
  // Pop : read at SP, clear it, then SP := SP+1
  val sp = RegInit(4.U(3.W)) // needs to represent 0..4

  val dataOutReg = RegInit(0.U(4.W))
  io.dataOut := dataOutReg

  // Flags derived from SP
  io.EMPTY := (sp === 4.U)
  io.FULL  := (sp === 0.U)

  when(io.EN) {
    when(reset.asBool) {
      sp := 4.U
      dataOutReg := 0.U
      for (i <- 0 until 4) {
        stack_mem(i) := 0.U
      }
    }.otherwise {
      when(!io.RW) { // write (push)
        when(!io.FULL) {
          val wIdx = sp - 1.U
          stack_mem(wIdx) := io.dataIn
          sp := sp - 1.U
        }
      }.otherwise { // read (pop)
        when(!io.EMPTY) {
          val rIdx = sp
          dataOutReg := stack_mem(rIdx)
          stack_mem(rIdx) := 0.U
          sp := sp + 1.U
        }
      }
    }
  }
}

/*
object dutMain extends App {
  emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
