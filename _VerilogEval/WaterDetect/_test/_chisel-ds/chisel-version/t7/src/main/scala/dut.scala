import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W)) // Sensors s[3:1]
    val fr3 = Output(Bool()) // Nominal flow valve 3
    val fr2 = Output(Bool()) // Nominal flow valve 2
    val fr1 = Output(Bool()) // Nominal flow valve 1
    val dfr = Output(Bool()) // Supplemental flow valve
    val reset = Input(Bool()) // Synchronous reset
  })

  // Define states for the water level
  val state = RegInit(0.U(2.W))
  val prevState = RegInit(0.U(2.W))

  // State encoding
  val STATE_ABOVE_S3 = 0.U(2.W)
  val STATE_BETWEEN_S3_S2 = 1.U(2.W)
  val STATE_BETWEEN_S2_S1 = 2.U(2.W)
  val STATE_BELOW_S1 = 3.U(2.W)

  // Output registers
  io.fr3 := false.B
  io.fr2 := false.B
  io.fr1 := false.B
  io.dfr := false.B

  // State transition logic
  when(io.reset) {
    state := STATE_BELOW_S1
    prevState := STATE_BELOW_S1
    io.fr3 := true.B
    io.fr2 := true.B
    io.fr1 := true.B
    io.dfr := true.B
  }.otherwise {
    // Update previous state
    prevState := state

    // Determine current state based on sensor inputs
    switch(io.s) {
      is("b111".U) { state := STATE_ABOVE_S3 }
      is("b110".U) { state := STATE_BETWEEN_S3_S2 }
      is("b100".U) { state := STATE_BETWEEN_S2_S1 }
      is("b000".U) { state := STATE_BELOW_S1 }
    }

    // Output logic based on current state
    switch(state) {
      is(STATE_ABOVE_S3) {
        io.fr3 := false.B
        io.fr2 := false.B
        io.fr1 := false.B
        io.dfr := false.B
      }
      is(STATE_BETWEEN_S3_S2) {
        io.fr3 := false.B
        io.fr2 := false.B
        io.fr1 := true.B
        io.dfr := (prevState < state)
      }
      is(STATE_BETWEEN_S2_S1) {
        io.fr3 := false.B
        io.fr2 := true.B
        io.fr1 := true.B
        io.dfr := (prevState < state)
      }
      is(STATE_BELOW_S1) {
        io.fr3 := true.B
        io.fr2 := true.B
        io.fr1 := true.B
        io.dfr := true.B
      }
    }
  }
}

// Generate Verilog
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), args)
}
*/
