import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn  = Input(UInt(4.W))
    val RW      = Input(Bool())   // 1 = read(pop), 0 = write(push)
    val EN      = Input(Bool())
    val EMPTY   = Output(Bool())
    val FULL    = Output(Bool())
    val dataOut = Output(UInt(4.W))
  })

  // 4 entries of 4-bit
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))

  // Stack pointer: 4 means empty, 0 means full (next push would underflow)
  val sp = RegInit(4.U(3.W))

  val dataOutReg = RegInit(0.U(4.W))
  io.dataOut := dataOutReg

  io.EMPTY := (sp === 4.U)
  io.FULL  := (sp === 0.U)

  when(io.EN) {
    when(reset.asBool) {
      sp := 4.U
      dataOutReg := 0.U
      for (i <- 0 until 4) { stack_mem(i) := 0.U }
    }.otherwise {
      when(!io.RW) { // write (push)
        when(!io.FULL) {
          val idx = sp - 1.U
          stack_mem(idx) := io.dataIn
          sp := sp - 1.U
        }
      }.otherwise { // read (pop)
        when(!io.EMPTY) {
          val idx = sp
          dataOutReg := stack_mem(idx)
          stack_mem(idx) := 0.U
          sp := sp + 1.U
        }
      }
    }
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
