import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn  = Input(UInt(4.W))
    val RW      = Input(Bool()) // 1: read(pop), 0: write(push)
    val EN      = Input(Bool())
    val EMPTY   = Output(Bool())
    val FULL    = Output(Bool())
    val dataOut = Output(UInt(4.W))
  })

  // 4-entry stack memory, each entry is 4 bits
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  // SP ranges from 0 to 4:
  // 4 -> empty, 0 -> full
  val sp = RegInit(4.U(3.W))

  val dataOutReg = RegInit(0.U(4.W))

  val empty = (sp === 4.U)
  val full  = (sp === 0.U)

  when(io.EN) {
    when(reset.asBool) {
      sp := 4.U
      dataOutReg := 0.U
      for (i <- 0 until 4) {
        stack_mem(i) := 0.U
      }
    }.otherwise {
      // Write (push)
      when(!io.RW && !full) {
        stack_mem(sp - 1.U) := io.dataIn
        sp := sp - 1.U
      }
      // Read (pop)
      .elsewhen(io.RW && !empty) {
        dataOutReg := stack_mem(sp)
        stack_mem(sp) := 0.U
        sp := sp + 1.U
      }
    }
  }

  io.dataOut := dataOutReg
  io.EMPTY := (sp === 4.U)
  io.FULL  := (sp === 0.U)
}
