import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val CLK_in = Input(Bool()) // Input clock signal
    val RST = Input(Bool())    // Reset signal
    val CLK_50 = Output(Bool()) // Output clock divided by 2
    val CLK_10 = Output(Bool()) // Output clock divided by 10
    val CLK_1 = Output(Bool())  // Output clock divided by 100
  })

  // Registers for output clocks
  val CLK_50_reg = RegInit(false.B) // CLK_50 signal register
  val CLK_10_reg = RegInit(false.B) // CLK_10 signal register
  val CLK_1_reg = RegInit(false.B)  // CLK_1 signal register

  // Counters
  val cnt_10 = RegInit(0.U(4.W))   // Counter for CLK_10 (0 to 4)
  val cnt_100 = RegInit(0.U(7.W))  // Counter for CLK_1 (0 to 49)

  // CLK_50 generation
  when(io.RST) {
    CLK_50_reg := false.B
  } .elsewhen(io.CLK_in) {
    CLK_50_reg := ~CLK_50_reg
  }

  // CLK_10 generation
  when(io.RST) {
    cnt_10 := 0.U
    CLK_10_reg := false.B
  } .elsewhen(io.CLK_in) {
    when(cnt_10 === 4.U) {
      CLK_10_reg := ~CLK_10_reg
      cnt_10 := 0.U
    } .otherwise {
      cnt_10 := cnt_10 + 1.U
    }
  }

  // CLK_1 generation
  when(io.RST) {
    cnt_100 := 0.U
    CLK_1_reg := false.B
  } .elsewhen(io.CLK_in) {
    when(cnt_100 === 49.U) {
      CLK_1_reg := ~CLK_1_reg
      cnt_100 := 0.U
    } .otherwise {
      cnt_100 := cnt_100 + 1.U
    }
  }

  // Connect output ports
  io.CLK_50 := CLK_50_reg
  io.CLK_10 := CLK_10_reg
  io.CLK_1 := CLK_1_reg
}

/*
object dut extends App {
  println("Generating the Chisel HDL for dut...")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
