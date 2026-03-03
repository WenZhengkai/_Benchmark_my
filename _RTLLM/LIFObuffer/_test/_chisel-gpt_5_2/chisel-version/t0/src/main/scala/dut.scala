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

  // 4 entries of 4-bit each
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))

  // Stack pointer semantics per spec:
  // SP = 4 => empty
  // SP = 0 => full
  val sp = RegInit(4.U(3.W))

  val dataOutReg = RegInit(0.U(4.W))
  io.dataOut := dataOutReg

  // Flags derived from SP
  io.EMPTY := (sp === 4.U)
  io.FULL  := (sp === 0.U)

  when(io.EN) {
    when(reset.asBool) {
      // Clear stack and reset SP to 4 (empty)
      sp := 4.U
      dataOutReg := 0.U
      for (i <- 0 until 4) {
        stack_mem(i) := 0.U
      }
    }.otherwise {
      // Push: RW=0 and not full
      when(!io.RW && !io.FULL) {
        val newSp = sp - 1.U
        stack_mem(newSp) := io.dataIn
        sp := newSp
      }
      // Pop: RW=1 and not empty
      .elsewhen(io.RW && !io.EMPTY) {
        val idx = sp
        dataOutReg := stack_mem(idx)
        stack_mem(idx) := 0.U
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
