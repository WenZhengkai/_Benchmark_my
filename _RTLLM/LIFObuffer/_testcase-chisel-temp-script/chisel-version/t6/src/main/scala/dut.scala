import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Input ports
    val dataIn  = Input(UInt(4.W))  // 4-bit input data
    val RW      = Input(UInt(1.W)) // Read/Write control: 0 = Write, 1 = Read
    val EN      = Input(Bool())    // Enable signal

    // Output ports
    val EMPTY   = Output(Bool())    // Buffer empty flag
    val FULL    = Output(Bool())    // Buffer full flag
    val dataOut = Output(UInt(4.W)) // 4-bit output data
  })

  // Internal memory: 4 entries, each 4-bit wide
  val stack_mem = RegInit(VecInit(Seq.fill(4)(0.U(4.W))))

  // Stack pointer: 3-bit wide (0-4, top of the stack pointer for 'EMPTY' detection)
  val SP = RegInit(4.U(3.W))  // Start with stack pointer set to 4 (empty)

  // EMPTY and FULL flags
  io.EMPTY := (SP === 4.U) // `EMPTY` flag when stack pointer equals 4
  io.FULL  := (SP === 0.U) // `FULL` flag when stack pointer equals 0

  // Default dataOut value (in case of no operation)
  io.dataOut := 0.U

  // Main operational logic
  when(reset.asBool) {
    // Reset behavior: clear stack memory and set SP to 4
    for (i <- 0 until 4) {
      stack_mem(i) := 0.U
    }
    SP := 4.U
  } .elsewhen(io.EN) {
    when(io.RW === 0.U && !io.FULL) { // Write operation logic
      SP := SP - 1.U // Move stack pointer downward for push
      stack_mem(SP - 1.U) := io.dataIn // Store data into top of stack
    } .elsewhen(io.RW === 1.U && !io.EMPTY) { // Read operation logic
      io.dataOut := stack_mem(SP) // Read data at current SP
      stack_mem(SP) := 0.U        // Optionally clear the data in stack
      SP := SP + 1.U              // Move stack pointer upward for pop
    }
  }
}

// Generate Verilog for the `dut`
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
