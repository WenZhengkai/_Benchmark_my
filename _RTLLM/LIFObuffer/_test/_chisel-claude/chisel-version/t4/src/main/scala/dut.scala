import chisel3._
import chisel3.util._

class LIFO extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))
    val RW = Input(Bool()) // 1 for read, 0 for write
    val EN = Input(Bool())
    
    val EMPTY = Output(Bool())
    val FULL = Output(Bool())
    val dataOut = Output(UInt(4.W))
  })
  
  // Define stack memory and stack pointer
  val stackDepth = 4
  val stackWidth = 4
  
  val stack_mem = RegInit(VecInit(Seq.fill(stackDepth)(0.U(stackWidth.W))))
  val sp = RegInit(stackDepth.U(3.W)) // Stack pointer (3 bits to represent 0-4)
  
  // Default output values
  io.dataOut := 0.U
  io.EMPTY := (sp === stackDepth.U)
  io.FULL := (sp === 0.U)
  
  // Buffer operations logic
  when(io.EN) {
    when(reset.asBool) {
      // Reset logic
      sp := stackDepth.U
      for (i <- 0 until stackDepth) {
        stack_mem(i) := 0.U
      }
    }.otherwise {
      when(!io.RW && !io.FULL) {
        // Write operation (push) - when RW is 0 and buffer is not full
        sp := sp - 1.U
        stack_mem(sp - 1.U) := io.dataIn
      }.elsewhen(io.RW && !io.EMPTY) {
        // Read operation (pop) - when RW is 1 and buffer is not empty
        io.dataOut := stack_mem(sp)
        stack_mem(sp) := 0.U
        sp := sp + 1.U
      }
    }
  }
}

// Top-level module as specified
class dut extends Module {
  val io = IO(new Bundle {
    val dataIn = Input(UInt(4.W))
    val RW = Input(Bool())
    val EN = Input(Bool())
    
    val EMPTY = Output(Bool())
    val FULL = Output(Bool())
    val dataOut = Output(UInt(4.W))
  })
  
  val lifo = Module(new LIFO())
  
  // Connect top-level ports to LIFO module
  lifo.io.dataIn := io.dataIn
  lifo.io.RW := io.RW
  lifo.io.EN := io.EN
  
  io.EMPTY := lifo.io.EMPTY
  io.FULL := lifo.io.FULL
  io.dataOut := lifo.io.dataOut
}
