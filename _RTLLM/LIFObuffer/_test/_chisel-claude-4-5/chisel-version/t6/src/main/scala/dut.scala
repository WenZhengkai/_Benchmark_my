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

  // Stack memory array - 4 entries of 4-bit data
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))
  
  // Stack pointer - initialized to 4 (empty state)
  val SP = RegInit(4.U(3.W))
  
  // Output data register
  val dataOut_reg = RegInit(0.U(4.W))

  when(reset.asBool) {
    // Reset: clear stack, set SP to 4, initialize memory to 0
    SP := 4.U
    stack_mem := VecInit(Seq.fill(4)(0.U(4.W)))
    dataOut_reg := 0.U
  } .elsewhen(io.EN) {
    when(!io.RW && !io.FULL) {
      // Write operation (push) - only if not full
      SP := SP - 1.U
      stack_mem(SP - 1.U) := io.dataIn
    } .elsewhen(io.RW && !io.EMPTY) {
      // Read operation (pop) - only if not empty
      dataOut_reg := stack_mem(SP)
      stack_mem(SP) := 0.U
      SP := SP + 1.U
    }
  }

  // Update EMPTY and FULL flags based on stack pointer
  io.EMPTY := (SP === 4.U)
  io.FULL := (SP === 0.U)
  
  // Output data
  io.dataOut := dataOut_reg
}

// Generator object for creating Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
