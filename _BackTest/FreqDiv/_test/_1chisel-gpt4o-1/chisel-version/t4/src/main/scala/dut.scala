import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val CLK_in = Input(Bool())     // Input clock signal
    val RST = Input(Bool())       // Reset signal
    val CLK_50 = Output(Bool())   // Clock signal at 50 MHz
    val CLK_10 = Output(Bool())   // Clock signal at 10 MHz
    val CLK_1 = Output(Bool())    // Clock signal at 1 MHz
  })

  // Registers for output clocks
  val clk50 = RegInit(false.B)
  val clk10 = RegInit(false.B)
  val clk1  = RegInit(false.B)

  // Counters for clk10 and clk1 divisions
  val cnt10 = RegInit(0.U(4.W))   // 4-bit counter for dividing by 10 (0 to 9)
  val cnt100 = RegInit(0.U(7.W))  // 7-bit counter for dividing by 100 (0 to 99)

  // CLK_50 logic
  when(io.RST) {
    clk50 := false.B
  } .otherwise {
    clk50 := ~clk50 // Toggle the CLK_50 every positive edge of CLK_in
  }

  // CLK_10 logic
  when(io.RST) {
    clk10 := false.B
    cnt10 := 0.U
  } .elsewhen(cnt10 === 4.U) { // If counter reaches 4 (half-period for divide by 10)
    clk10 := ~clk10 // Toggle CLK_10
    cnt10 := 0.U    // Reset counter
  } .otherwise {
    cnt10 := cnt10 + 1.U // Increment counter
  }

  // CLK_1 logic
  when(io.RST) {
    clk1 := false.B
    cnt100 := 0.U
  } .elsewhen(cnt100 === 49.U) { // If counter reaches 49 (half-period for divide by 100)
    clk1 := ~clk1 // Toggle CLK_1
    cnt100 := 0.U // Reset counter
  } .otherwise {
    cnt100 := cnt100 + 1.U // Increment counter
  }

  // Connecting registers to output ports
  io.CLK_50 := clk50
  io.CLK_10 := clk10
  io.CLK_1 := clk1
}

// Generate the Verilog code
/*
object FreqDivGen extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new FreqDiv, Array("--target-dir", "generated"))
}
*/
