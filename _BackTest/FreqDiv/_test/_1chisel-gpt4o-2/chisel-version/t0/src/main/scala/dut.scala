import chisel3._

class dut extends Module {
  val io = IO(new Bundle {
    val CLK_in = Input(Bool())   // Input clock signal
    val RST = Input(Bool())     // Reset signal
    val CLK_50 = Output(Bool()) // Output clock signal @ 50MHz
    val CLK_10 = Output(Bool()) // Output clock signal @ 10MHz
    val CLK_1 = Output(Bool())  // Output clock signal @ 1MHz
  })

  // Registers to hold clock signals
  val clk_50 = RegInit(false.B)
  val clk_10 = RegInit(false.B)
  val clk_1 = RegInit(false.B)

  // Counters
  val cnt_10 = RegInit(0.U(3.W))   // 3 bits (to count 0 to 4 for CLK_10)
  val cnt_100 = RegInit(0.U(6.W))  // 6 bits (to count 0 to 49 for CLK_1)

  // CLK_50 generation
  when(io.RST) {
    clk_50 := false.B
  } .elsewhen(io.CLK_in) {
    clk_50 := ~clk_50   // Toggle CLK_50 signal
  }

  // CLK_10 generation
  when(io.RST) {
    clk_10 := false.B
    cnt_10 := 0.U
  } .elsewhen(io.CLK_in) {
    when(cnt_10 === 4.U) {
      clk_10 := ~clk_10 // Toggle CLK_10 signal
      cnt_10 := 0.U     // Reset counter
    } .otherwise {
      cnt_10 := cnt_10 + 1.U // Increment counter
    }
  }

  // CLK_1 generation
  when(io.RST) {
    clk_1 := false.B
    cnt_100 := 0.U
  } .elsewhen(io.CLK_in) {
    when(cnt_100 === 49.U) {
      clk_1 := ~clk_1  // Toggle CLK_1 signal
      cnt_100 := 0.U   // Reset counter
    } .otherwise {
      cnt_100 := cnt_100 + 1.U // Increment counter
    }
  }

  // Connect outputs
  io.CLK_50 := clk_50
  io.CLK_10 := clk_10
  io.CLK_1 := clk_1
}

/*
object FrequencyDivider extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new FrequencyDivider())
}
*/
