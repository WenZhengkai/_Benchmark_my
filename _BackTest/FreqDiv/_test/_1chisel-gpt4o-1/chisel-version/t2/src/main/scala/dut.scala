import chisel3._

class dut extends Module {
  val io = IO(new Bundle {
    val CLK_in = Input(Bool())    // Input clock signal
    val RST = Input(Bool())      // Reset signal
    val CLK_50 = Output(Bool())  // Output clock (50 MHz)
    val CLK_10 = Output(Bool())  // Output clock (10 MHz)
    val CLK_1 = Output(Bool())   // Output clock (1 MHz)
  })

  // Register definitions
  val CLK_50 = RegInit(false.B)
  val CLK_10 = RegInit(false.B)
  val CLK_1 = RegInit(false.B)

  val cnt_10 = RegInit(0.U(4.W))    // Counter for CLK_10 (0 to 4)
  val cnt_100 = RegInit(0.U(7.W))   // Counter for CLK_1 (0 to 49)

  // CLK_50 generation: Toggle every CLK_in high edge
  when(io.RST) {
    CLK_50 := false.B
  }.otherwise {
    CLK_50 := ~CLK_50
  }

  // CLK_10 generation: Toggle every 5 CLK_in cycles
  when(io.RST) {
    CLK_10 := false.B
    cnt_10 := 0.U
  }.otherwise {
    when(cnt_10 === 4.U) {
      CLK_10 := ~CLK_10
      cnt_10 := 0.U
    }.otherwise {
      cnt_10 := cnt_10 + 1.U
    }
  }

  // CLK_1 generation: Toggle every 50 CLK_in cycles
  when(io.RST) {
    CLK_1 := false.B
    cnt_100 := 0.U
  }.otherwise {
    when(cnt_100 === 49.U) {
      CLK_1 := ~CLK_1
      cnt_100 := 0.U
    }.otherwise {
      cnt_100 := cnt_100 + 1.U
    }
  }

  // Connecting outputs
  io.CLK_50 := CLK_50
  io.CLK_10 := CLK_10
  io.CLK_1 := CLK_1
}

// Generate the Verilog
/*
object FreqDivDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new FreqDiv)
}
*/
