import chisel3._
import chisel3.util._

object dutState extends ChiselEnum {
  val A, B, C, D = Value // State enumeration: A, B, C, D
}

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))  // 3-bit input request signals
    val g = Output(UInt(3.W)) // 3-bit output grant signals
  })

  // Default output
  io.g := 0.U // Initialize output grants to 0

  // State register with initial state `A`
  val stateReg = RegInit(dutState.A)

  // State transition logic using switch
  switch(stateReg) {
    is(dutState.A) {
      // Default outputs for state A
      io.g := 0.U
      // Priority-based transitions from state A
      when(io.r(0)) {
        stateReg := dutState.B // Transition to state B if r(0) is high
      }.elsewhen(io.r(1)) {
        stateReg := dutState.C // Transition to state C if r(1) is high
      }.elsewhen(io.r(2)) {
        stateReg := dutState.D // Transition to state D if r(2) is high
      }.otherwise {
        stateReg := dutState.A // Stay in state A if no requests are high
      }
    }

    is(dutState.B) {
      // Grant access to device 0 in state B
      io.g := "b010".U // Set g(0) = 1
      // State B transitions
      when(io.r(0)) {
        stateReg := dutState.B // Stay in state B while r(0) is high
      }.otherwise {
        stateReg := dutState.A // Transition back to state A if r(0) is low
      }
    }

    is(dutState.C) {
      // Grant access to device 1 in state C
      io.g := "b010".U // Set g(1) = 1
      // State C transitions
      when(io.r(1)) {
        stateReg := dutState.C // Stay in state C while r(1) is high
      }.otherwise {
        stateReg := dutState.A // Transition back to state A if r(1) is low
      }
    }

    is(dutState.D) {
      // Grant access to device 2 in state D
      io.g := "b100".U // Set g(2) = 1
      // State D transitions
      when(io.r(2)) {
        stateReg := dutState.D // Stay in state D while r(2) is high
      }.otherwise {
        stateReg := dutState.A // Transition back to state A if r(2) is low
      }
    }
  }
}

/*
object dutDriver extends App {
  println("Generating Verilog for dut...")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
