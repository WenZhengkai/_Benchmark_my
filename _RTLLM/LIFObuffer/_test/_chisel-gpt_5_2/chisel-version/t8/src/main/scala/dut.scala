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

  // Stack pointer: 4 means empty; 0 means full (next push would be illegal)
  val sp = RegInit(4.U(3.W))

  val dataOutReg = RegInit(0.U(4.W))
  io.dataOut := dataOutReg

  // Flags derived from SP
  io.EMPTY := (sp === 4.U)
  io.FULL  := (sp === 0.U)

  when (io.EN) {
    when (reset.asBool) {
      sp := 4.U
      dataOutReg := 0.U
      for (i <- 0 until 4) { stack_mem(i) := 0.U }
    } .otherwise {
      when (!io.RW) { // write (push)
        when (!io.FULL) {
          // push to location (sp - 1), then decrement sp
          val nextSp = sp - 1.U
          stack_mem(nextSp) := io.dataIn
          sp := nextSp
        }
      } .otherwise { // read (pop)
        when (!io.EMPTY) {
          // pop from location sp, then clear it and increment sp
          dataOutReg := stack_mem(sp)
          stack_mem(sp) := 0.U
          sp := sp + 1.U
        }
      }
    }
  }
}

/*
object dutVerilog extends App {
  emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
