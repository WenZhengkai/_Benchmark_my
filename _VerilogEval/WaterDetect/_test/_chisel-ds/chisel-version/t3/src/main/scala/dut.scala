import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))  // Sensors s[3:1]
    val fr3 = Output(Bool())  // Nominal flow rate valve 3
    val fr2 = Output(Bool())  // Nominal flow rate valve 2
    val fr1 = Output(Bool())  // Nominal flow rate valve 1
    val dfr = Output(Bool())  // Supplemental flow valve
    val reset = Input(Bool()) // Active-high synchronous reset
  })

  // Define states for the water level
  val state = RegInit(0.U(2.W)) // 0: Below s[1], 1: Between s[1] and s[2], 2: Between s[2] and s[3], 3: Above s[3]

  // Define previous state to detect level changes
  val prevState = RegInit(0.U(2.W))

  // Update state based on sensor inputs
  when(io.reset) {
    state := 0.U // Reset to "Below s[1]"
    prevState := 0.U
  }.otherwise {
    prevState := state
    state := MuxCase(state, Seq(
      (io.s === "b000".U) -> 0.U, // Below s[1]
      (io.s === "b001".U) -> 1.U, // Between s[1] and s[2]
      (io.s === "b011".U) -> 2.U, // Between s[2] and s[3]
      (io.s === "b111".U) -> 3.U  // Above s[3]
    ))
  }

  // Determine flow rate outputs based on state
  io.fr1 := Mux(state === 0.U, true.B, Mux(state === 1.U, true.B, Mux(state === 2.U, true.B, false.B)))
  io.fr2 := Mux(state === 0.U, true.B, Mux(state === 1.U, true.B, false.B))
  io.fr3 := Mux(state === 0.U, true.B, false.B)

  // Determine Supplemental flow valve (dfr) based on state change
  io.dfr := (state > prevState)
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
