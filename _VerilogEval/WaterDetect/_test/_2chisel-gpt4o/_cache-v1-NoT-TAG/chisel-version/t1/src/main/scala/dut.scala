// package waterdetect

import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W)) // Sensor inputs: s[3:1]
    val fr3 = Output(Bool()) // Nominal flow output 3
    val fr2 = Output(Bool()) // Nominal flow output 2
    val fr1 = Output(Bool()) // Nominal flow output 1
    val dfr = Output(Bool()) // Supplemental flow output
  })

  // Task 1: Enumerate States
  object WaterLevel extends ChiselEnum {
    val AboveS3, BetweenS3S2, BetweenS2S1, BelowS1 = Value
  }
  import WaterLevel._

  // Task 2: Current State Logic (Combinational)
  val currentState = WireDefault(WaterLevel.BelowS1) // Default to the lowest state
  when(io.s(2)) {
    currentState := WaterLevel.AboveS3 // s[3] asserted
  }.elsewhen(io.s(1)) {
    currentState := WaterLevel.BetweenS3S2 // s[2] asserted
  }.elsewhen(io.s(0)) {
    currentState := WaterLevel.BetweenS2S1 // s[1] asserted
  }

  // Task 3: State Registers and Reset
  val currentStateReg = RegInit(WaterLevel.BelowS1) // Current state register
  val previousStateReg = RegInit(WaterLevel.BelowS1) // Previous state register
  when(reset.asBool) {
    currentStateReg := WaterLevel.BelowS1
    previousStateReg := WaterLevel.BelowS1
  }.otherwise {
    previousStateReg := currentStateReg
    currentStateReg := currentState
  }

  // Task 4: Nominal Flow Outputs (fr3, fr2, fr1)
  io.fr3 := (currentStateReg === WaterLevel.BelowS1)
  io.fr2 := (currentStateReg === WaterLevel.BetweenS2S1) || (currentStateReg === WaterLevel.BelowS1)
  io.fr1 := (currentStateReg === WaterLevel.BetweenS3S2) || (currentStateReg === WaterLevel.BetweenS2S1) || (currentStateReg === WaterLevel.BelowS1)

  // Task 5: Supplemental Flow Output (dfr)
  val isLevelRising = currentStateReg < previousStateReg // Using enum ordering
  io.dfr := (currentStateReg === WaterLevel.BelowS1) || isLevelRising
}

/*
object dut extends App {
  println("Generating Verilog for dut...")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
