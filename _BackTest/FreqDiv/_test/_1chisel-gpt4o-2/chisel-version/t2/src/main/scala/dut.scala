import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val CLK_in = Input(Clock())  // Input clock signal
    val RST = Input(Bool())     // Reset signal
    val CLK_50 = Output(Bool()) // Output clock divided by 2
    val CLK_10 = Output(Bool()) // Output clock divided by 10
    val CLK_1 = Output(Bool())  // Output clock divided by 100
  })

  // Register for the divided-by-2 clock (CLK_50)
  val clk50 = RegInit(false.B)

  // Counter and register for the divided-by-10 clock (CLK_10)
  val cnt10 = RegInit(0.U(4.W)) // 4-bit counter
  val clk10 = RegInit(false.B)

  // Counter and register for the divided-by-100 clock (CLK_1)
  val cnt100 = RegInit(0.U(7.W)) // 7-bit counter
  val clk1 = RegInit(false.B)

  // Logic for CLK_50 (divide-by-2)
  when(io.RST) {
    clk50 := false.B
  }.otherwise {
    clk50 := ~clk50
  }

  // Logic for CLK_10 (divide-by-10)
  when(io.RST) {
    cnt10 := 0.U
    clk10 := false.B
  }.elsewhen(cnt10 === 4.U) {
    clk10 := ~clk10
    cnt10 := 0.U
  }.otherwise {
    cnt10 := cnt10 + 1.U
  }

  // Logic for CLK_1 (divide-by-100)
  when(io.RST) {
    cnt100 := 0.U
    clk1 := false.B
  }.elsewhen(cnt100 === 49.U) {
    clk1 := ~clk1
    cnt100 := 0.U
  }.otherwise {
    cnt100 := cnt100 + 1.U
  }

  // Connect registers to output ports
  io.CLK_50 := clk50
  io.CLK_10 := clk10
  io.CLK_1 := clk1
}

// Generate Verilog for the module
/*
object DutMain extends App {
  println("Generating the Verilog for Dut...")
  (new chisel3.stage.ChiselStage).emitVerilog(new Dut)
}
*/
