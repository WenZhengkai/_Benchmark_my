import chisel3._

class dut extends Module {
  val io = IO(new Bundle {
    val CLK_in = Input(Clock())
    val RST = Input(Bool())
    val CLK_50 = Output(Bool())
    val CLK_10 = Output(Bool())
    val CLK_1 = Output(Bool())
  })

  // Register declarations for the outputs
  val clk50Reg = RegInit(false.B)
  val clk10Reg = RegInit(false.B)
  val clk1Reg = RegInit(false.B)

  // Registers for counters used in division
  val cnt10 = RegInit(0.U(4.W)) // 4 bits are enough for counting up to 5 (0-4)
  val cnt100 = RegInit(0.U(7.W)) // 7 bits are enough for counting up to 50 (0-49)

  // Clock division logic

  // CLK_50 generation: Divide by 2
  when (io.RST) {
    clk50Reg := false.B
  } .elsewhen (RegNext(io.CLK_in.asBool())) { // Capture edge of CLK_in
    clk50Reg := ~clk50Reg
  }

  // CLK_10 generation: Divide by 10
  when (io.RST) {
    clk10Reg := false.B
    cnt10 := 0.U
  } .elsewhen (RegNext(io.CLK_in.asBool())) {
    when (cnt10 === 4.U) { // Toggling on 5th cycle: Divide by 10
      clk10Reg := ~clk10Reg
      cnt10 := 0.U
    } .otherwise {
      cnt10 := cnt10 + 1.U
    }
  }

  // CLK_1 generation: Divide by 100
  when (io.RST) {
    clk1Reg := false.B
    cnt100 := 0.U
  } .elsewhen (RegNext(io.CLK_in.asBool())) {
    when (cnt100 === 49.U) { // Toggling on 50th cycle: Divide by 100
      clk1Reg := ~clk1Reg
      cnt100 := 0.U
    } .otherwise {
      cnt100 := cnt100 + 1.U
    }
  }

  // Connect output ports to their respective registers
  io.CLK_50 := clk50Reg
  io.CLK_10 := clk10Reg
  io.CLK_1 := clk1Reg
}

// Generate the Verilog code for the design
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
