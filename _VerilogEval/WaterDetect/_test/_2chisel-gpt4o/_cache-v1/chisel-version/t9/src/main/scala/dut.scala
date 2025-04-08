import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))  // Water level sensors s[3:1]
    val reset = Input(Bool()) // Active-high synchronous reset
    val fr1 = Output(Bool())  // Nominal flow rate signal 1
    val fr2 = Output(Bool())  // Nominal flow rate signal 2
    val fr3 = Output(Bool())  // Nominal flow rate signal 3
    val dfr = Output(Bool())  // Supplemental flow rate signal
  })

  // FSM state definition
  object States extends ChiselEnum {
    val Low, MidLow, MidHigh, High = Value
  }

  val currentState = RegInit(States.Low) // Initial state set to "Low"
  val previousState = RegInit(States.Low) // Tracks previous state transitions
  
  // Default output values
  io.fr1 := false.B
  io.fr2 := false.B
  io.fr3 := false.B
  io.dfr := false.B

  // State Transition Logic
  switch(currentState) {
    is(States.Low) {
      when(io.s === "b000".U) { // Below s[1], no sensors are asserted
        io.fr1 := true.B
        io.fr2 := true.B
        io.fr3 := true.B
        previousState := States.Low
      }
      .otherwise {
        when(io.s(0))==shortit
警告：dut9.scala格式异常
