import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val CLK_in = Input(Clock())
    val RST = Input(Bool())
    val CLK_50 = Output(Bool())
    val CLK_10 = Output(Bool())
    val CLK_1 = Output(Bool())
  })

  withClockAndReset(io.CLK_in, io.RST) {
    // CLK_50 generation
    val clk_50_reg = RegInit(false.B)
    clk_50_reg := !clk_50_reg
    io.CLK_50 := clk_50_reg

    // CLK_10 generation
    val clk_10_reg = RegInit(false.B)
    val cnt_10 = RegInit(0.U(3.W))
    when(cnt_10 === 4.U) {
      clk_10_reg := !clk_10_reg
      cnt_10 := 0.U
    }.otherwise {
      cnt_10 := cnt_10 + 1.U
    }
    io.CLK_10 := clk_10_reg

    // CLK_1 generation
    val clk_1_reg = RegInit(false.B)
    val cnt_100 = RegInit(0.U(6.W))
    when(cnt_100 === 49.U) {
      clk_1_reg := !clk_1_reg
      cnt_100 := 0.U
    }.otherwise {
      cnt_100 := cnt_100 + 1.U
    }
    io.CLK_1 := clk_1_reg
  }
}

// Optional: Object to generate Verilog
object dutVerilog extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}