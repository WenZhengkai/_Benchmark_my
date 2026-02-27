import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val CLK_in = Input(Bool())  // Input clock signal
    val RST = Input(Bool())    // Reset signal
    val CLK_50 = Output(Bool())  // Output clock signal at 50MHz
    val CLK_10 = Output(Bool())  // Output clock signal at 10MHz
    val CLK_1 = Output(Bool())   // Output clock signal at 1MHz
  })

  // Registers for output clocks
  val clk50 = RegInit(false.B)
  val clk10 = RegInit(false.B)
  val clk1 = RegInit(false.B)

  // Counters for clock division
  val cnt10 = RegInit(0.U(4.W))   // 4-bit counter for 10MHz
  val cnt100 = RegInit(0.U(7.W))  // 7-bit counter for 1MHz (0 to 49, hence 6 bits suffice)

  // CLK_50 generation
  when(io.RST) {
    clk50 := false.B
  } .otherwise {
    clk50 := ~clk50
  }

  // CLK_10 generation
  when(io.RST) {
    clk10 := false.B
    cnt10 := 0.U
  } .otherwise {
    when(cnt10 === 4.U) { // Half period of 10MHz clock is 5 cycles of 100MHz clock
      clk10 := ~clk10
      cnt10 := 0.U
    } .otherwise {
      cnt10 := cnt10 + 1.U
    }
  }

  // CLK_1 generation
  when(io.RST) {
    clk1 := false.B
    cnt100 := 0.U
  } .otherwise {
    when(cnt100 === 49.U) { // Half period of 1MHz clock is 50 cycles of 100MHz clock
      clk1 := ~clk1
      cnt100 := 0.U
    } .otherwise {
      cnt100 := cnt100 + 1.U
    }
  }

  // Connect outputs to registers
  io.CLK_50 := clk50
  io.CLK_10 := clk10
  io.CLK_1 := clk1
}

// Generate the Verilog code for simulation
/*
object FreqDivDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new FreqDiv())
}
*/
