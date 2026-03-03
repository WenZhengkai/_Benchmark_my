import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn  = Input(UInt(4.W))
    val RW      = Input(Bool())   // 0: write(push), 1: read(pop)
    val EN      = Input(Bool())

    val EMPTY   = Output(Bool())
    val FULL    = Output(Bool())
    val dataOut = Output(UInt(4.W))
  })

  // 4-entry stack, each entry is 4 bits
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  // SP = 4 means empty, SP = 0 means full
  val sp        = RegInit(4.U(3.W))
  val dataOutReg = RegInit(0.U(4.W))

  io.dataOut := dataOutReg
  io.EMPTY   := (sp === 4.U)
  io.FULL    := (sp === 0.U)

  when(io.EN) {
    when(reset.asBool) {
      sp := 4.U
      dataOutReg := 0.U
      for (i <- 0 until 4) {
        stack_mem(i) := 0.U
      }
    }.otherwise {
      when(!io.RW && !io.FULL) {
        // push
        val nextSp = sp - 1.U
        stack_mem(nextSp) := io.dataIn
        sp := nextSp
      }.elsewhen(io.RW && !io.EMPTY) {
        // pop
        dataOutReg := stack_mem(sp)
        stack_mem(sp) := 0.U
        sp := sp + 1.U
      }
    }
  }
}

// Optional Verilog generation
/*
object dutGen extends App {
  emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
