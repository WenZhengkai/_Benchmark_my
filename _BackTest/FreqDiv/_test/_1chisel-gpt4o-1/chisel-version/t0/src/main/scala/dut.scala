import chisel3._

class dut extends Module {
  val io = IO(new Bundle {
    val CLK_in = Input(Bool())          // Input clock signal
    val RST = Input(Bool())            // Reset signal
    val CLK_50 = Output(Bool())        // Output clock signal: divided by 2
    val CLK_10 = Output(Bool())        // Output clock signal: divided by 10
    val CLK_1 = Output(Bool())         // Output clock signal: divided by 100
  })

  // Registers to hold output clocks
  val reg_CLK_50 = RegInit(false.B)
  val reg_CLK_10 = RegInit(false.B)
  val reg_CLK_1 = RegInit(false.B)

  // Counters for division
  val cnt_10 = RegInit(0.U(4.W))       // 4-bit counter for CLK_10
  val cnt_100 = RegInit(0.U(7.W))      // 7-bit counter for CLK_1

  // CLK_50 generation: Toggles every clock cycle
  when (io.RST) {
    reg_CLK_50 := false.B              // Reset CLK_50 to 0
  }.otherwise {
    reg_CLK_50 := ~reg_CLK_50          // Toggle CLK_50
  }

  // CLK_10 generation
  when (io.RST) {
    reg_CLK_10 := false.B              // Reset CLK_10 to 0
    cnt_10 := 0.U                      // Reset counter
  }.otherwise {
    when (cnt_10 === 4.U) {            // When counter reaches 4
      reg_CLK_10 := ~reg_CLK_10        // Toggle CLK_10
      cnt_10 := 0.U                    // Reset counter
    }.otherwise {
      cnt_10 := cnt_10 + 1.U           // Increment counter
    }
  }

  // CLK_1 generation
  when (io.RST) {
    reg_CLK_1 := false.B               // Reset CLK_1 to 0
    cnt_100 := 0.U                     // Reset counter
  }.otherwise {
    when (cnt_100 === 49.U) {          // When counter reaches 49
      reg_CLK_1 := ~reg_CLK_1          // Toggle CLK_1
      cnt_100 := 0.U                   // Reset counter
    }.otherwise {
      cnt_100 := cnt_100 + 1.U         // Increment counter
    }
  }

  // Connect internal signals to module outputs
  io.CLK_50 := reg_CLK_50
  io.CLK_10 := reg_CLK_10
  io.CLK_1 := reg_CLK_1
}

// Generate the Verilog code for the module
/*
object dutDriver extends App {
  chisel3.Driver.execute(args, () => new dut())
}
*/
