import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s    = Input(UInt(3.W))   // Sensor inputs [3:1]
    val fr3  = Output(Bool())     // Nominal flow rate output (lowest)
    val fr2  = Output(Bool())     // Nominal flow rate output
    val fr1  = Output(Bool())     // Nominal flow rate output (highest)
    val dfr  = Output(Bool())     // Supplemental flow valve control
    val reset = Input(Bool())     // Active-high synchronous reset
  })

  // Registers to hold the flow rate outputs and their state
  val fr3_reg = RegInit(false.B)
  val fr2_reg = RegInit(false.B)
  val fr1_reg = RegInit(false.B)
  val dfr_reg = RegInit(false.B)

  // Memory for storing previous sensor input to determine last state
  val prev_s = RegNext(io.s)

  // Default outputs
  io.fr3 := false.B
  io.fr2 := false.B
  io.fr1 := false.B
  io.dfr := false.B

  // Active-high reset logic: all outputs should be asserted
  when(io.reset) {
    fr3_reg := true.B
    fr2_reg := true.B
    fr1_reg := true.B
    dfr_reg := true.B
  } .otherwise {
    // Logic to determine flow rate and supplemental flow based on sensor input
    switch(io.s) {
      is("b111".U) { // Above s[3]: No flow
        fr3_reg := false.B
        fr2_reg := false.B
        fr1_reg := false.B
        dfr_reg := false.B
      }
      is("b011".U) { // Between s[3] and s[2]: Nominal flow rate fr1
        fr3_reg := false.B
        fr2_reg := false.B
        fr1_reg := true.B
        dfr_reg := (io.s > prev_s) // If the previous level was lower, assert dfr
      }
      is("b001".U) { // Between s[2] and s[1]: Nominal flow rates fr1 and fr2
        fr3_reg := false.B
        fr2_reg := true.B
        fr1_reg := true.B
        dfr_reg := (io.s > prev_s) // If the previous level was lower, assert dfr
      }
      is("b000".U) { // Below s[1]: Max flow (fr1, fr2, fr3 all asserted)
        fr3_reg := true.B
        fr2_reg := true.B
        fr1_reg := true.B
        dfr_reg := true.B
      }
    }
  }

  // Assign the internal registers to module outputs
  io.fr3 := fr3_reg
  io.fr2 := fr2_reg
  io.fr1 := fr1_reg
  io.dfr := dfr_reg
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut())
}
*/
