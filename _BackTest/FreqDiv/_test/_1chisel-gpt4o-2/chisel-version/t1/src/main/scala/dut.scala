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

  // Registers for the output signals
  val clk50Reg = RegInit(false.B)
  val clk10Reg = RegInit(false.B)
  val clk1Reg = RegInit(false.B)

  // Counters for generating CLK_10 and CLK_1
  val cnt10 = RegInit(0.U(4.W)) // 4-bit counter
  val cnt100 = RegInit(0.U(7.W)) // 7-bit counter (to count up to 49)

  // Generate CLK_50 (Divide by 2)
  withClockAndReset(io.CLK_in, io.RST) {
    clk50Reg := Mux(io.RST, false.B, ~clk50Reg)
  }

  // Generate CLK_10 (Divide by 10)
  withClockAndReset(io.CLK_in, io.RST) {
    when(io.RST) {
      clk10Reg := false.B
      cnt10 := 0.U
    }.otherwise {
      when(cnt10 === 4.U) {
        clk10Reg := ~clk10Reg
        cnt10 := 0.U
      }.otherwise {
        cnt10 := cnt10 + 1.U
      }
    }
  }

  // Generate CLK_1 (Divide by 100)
  withClockAndReset(io.CLK_in, io.RST) {
    when(io.RST) {
      clk1Reg := false.B
      cnt100 := 0.U
    }.otherwise {
      when(cnt100 === 49.U) {
        clk1Reg := ~clk1Reg
        cnt100 := 0.U
      }.otherwise {
        cnt100 := cnt100 + 1.U
      }
    }
  }

  // Connect the outputs
  io.CLK_50 := clk50Reg
  io.CLK_10 := clk10Reg
  io.CLK_1 := clk1Reg
}

/*
object Dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new Dut(), Array("--target-dir", "generated"))
}
*/
