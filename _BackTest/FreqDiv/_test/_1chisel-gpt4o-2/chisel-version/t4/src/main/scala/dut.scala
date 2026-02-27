import chisel3._

class dut extends Module {
  val io = IO(new Bundle {
    val CLK_in = Input(Clock())
    val RST = Input(Bool())
    val CLK_50 = Output(Bool())
    val CLK_10 = Output(Bool())
    val CLK_1 = Output(Bool())
  })

  // Registers to hold the state of CLK signals and counters
  val clk50Reg = RegInit(false.B) // CLK_50 register
  val clk10Reg = RegInit(false.B) // CLK_10 register
  val clk1Reg = RegInit(false.B)  // CLK_1 register
  val cnt10 = RegInit(0.U(4.W))   // 4-bit counter for CLK_10
  val cnt100 = RegInit(0.U(7.W))  // 7-bit counter for CLK_1

  // Default outputs
  io.CLK_50 := clk50Reg
  io.CLK_10 := clk10Reg
  io.CLK_1 := clk1Reg

  // Process for CLK_50: Toggle every cycle
  withClockAndReset(io.CLK_in, io.RST) {
    when(io.RST) {
      clk50Reg := false.B
    }.otherwise {
      clk50Reg := ~clk50Reg
    }
  }

  // Process for CLK_10: Toggle on every 5 cycles
  withClockAndReset(io.CLK_in, io.RST) {
    when(io.RST) {
      clk10Reg := false.B
      cnt10 := 0.U
    }.otherwise {
      when(cnt10 === 4.U) { // 0 to 4 (5 cycles)
        clk10Reg := ~clk10Reg
        cnt10 := 0.U
      }.otherwise {
        cnt10 := cnt10 + 1.U
      }
    }
  }

  // Process for CLK_1: Toggle on every 50 cycles
  withClockAndReset(io.CLK_in, io.RST) {
    when(io.RST) {
      clk1Reg := false.B
      cnt100 := 0.U
    }.otherwise {
      when(cnt100 === 49.U) { // 0 to 49 (50 cycles)
        clk1Reg := ~clk1Reg
        cnt100 := 0.U
      }.otherwise {
        cnt100 := cnt100 + 1.U
      }
    }
  }
}

/*
object Dut extends App {
  // Generate Verilog code
  (new chisel3.stage.ChiselStage).emitVerilog(new Dut())
}
*/
