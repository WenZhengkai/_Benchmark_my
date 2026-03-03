import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val dataIn  = Input(UInt(4.W))
    val RW      = Input(Bool())
    val EN      = Input(Bool())
    val EMPTY   = Output(Bool())
    val FULL    = Output(Bool())
    val dataOut = Output(UInt(4.W))
  })

  // Stack memory array - 4 entries of 4-bit width
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  
  // Stack pointer - tracks current position (4 = empty, 0 = full)
  val SP = RegInit(4.U(3.W))
  
  // Output data register
  val dataOut_reg = RegInit(0.U(4.W))

  // Default assignments
  io.dataOut := dataOut_reg
  io.EMPTY := (SP === 4.U)
  io.FULL := (SP === 0.U)

  when(io.EN) {
    when(reset.asBool) {
      // Reset: clear stack, set SP to 4 (empty), initialize all memory to 0
      SP := 4.U
      stack_mem := VecInit(Seq.fill(4)(0.U(4.W)))
      dataOut_reg := 0.U
    }.otherwise {
      when(!io.RW) {
        // Write operation (push)
        when(!io.FULL) {
          val write_addr = SP - 1.U
          stack_mem(write_addr) := io.dataIn
          SP := write_addr
        }
      }.otherwise {
        // Read operation (pop)
        when(!io.EMPTY) {
          dataOut_reg := stack_mem(SP)
          stack_mem(SP) := 0.U
          SP := SP + 1.U
        }
      }
    }
  }
}

// Generate Verilog
/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
