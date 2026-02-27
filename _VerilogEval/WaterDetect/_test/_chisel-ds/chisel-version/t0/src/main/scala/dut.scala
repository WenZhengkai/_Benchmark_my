import chisel3._
import chisel3.util._

class dut extends Module {
  // I/O Ports
  val io = IO(new Bundle {
    val s = Input(UInt(3.W)) // Sensors s[3:1]
    val fr3 = Output(Bool()) // Nominal flow rate 3
    val fr2 = Output(Bool()) // Nominal flow rate 2
    val fr1 = Output(Bool()) // Nominal flow rate 1
    val dfr = Output(Bool()) // Supplemental flow valve
    val reset = Input(Bool()) // Synchronous reset
  })

  // Internal state to track the previous water level
  val prevLevel = RegInit(0.U(2.W)) // 0: Below s[1], 1: Between s[1] and s[2], 2: Between s[2] and s[3], 3: Above s[3]

  // Output registers
  val fr3Reg = RegInit(true.B)
  val fr2Reg = RegInit(true.B)
  val fr1Reg = RegInit(true.B)
  val dfrReg = RegInit(true.B)

  // Assign outputs
  io.fr3 := fr3Reg
  io.fr2 := fr2Reg
  io.fr1 := fr1Reg
  io.dfr := dfrReg

  // Logic to determine the current water level
  val currentLevel = Wire(UInt(2.W))
  currentLevel := MuxCase(0.U, Seq(
    (io.s === "b111".U) -> 3.U, // Above s[3]
    (io.s === "b011".U) -> 2.U, // Between s[3] and s[2]
    (io.s === "b001".U) -> 1.U, // Between s[2] and s[1]
    (io.s === "b000".U) -> 0.U  // Below s[1]
  ))

  // State machine logic
  when(io.reset) {
    // Reset to the state equivalent to the water level being low for a long time
    fr3Reg := true.B
    fr2Reg := true.B
    fr1Reg := true.B
    dfrReg := true.B
    prevLevel := 0.U
  }.otherwise {
    // Update flow rates based on the current water level
    switch(currentLevel) {
      is(3.U) { // Above s[3]
        fr3Reg := false.B
        fr2Reg := false.B
        fr1Reg := false.B
        dfrReg := false.B
      }
      is(2.U) { // Between s[3] and s[2]
        fr3Reg := false.B
        fr2Reg := false.B
        fr1Reg := true.B
        dfrReg := (prevLevel < currentLevel)
      }
      is(1.U) { // Between s[2] and s[1]
        fr3Reg := false.B
        fr2Reg := true.B
        fr1Reg := true.B
        dfrReg := (prevLevel < currentLevel)
      }
      is(0.U) { // Below s[1]
        fr3Reg := true.B
        fr2Reg := true.B
        fr1Reg := true.B
        dfrReg := true.B
      }
    }
    // Update the previous level
    prevLevel := currentLevel
  }
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
