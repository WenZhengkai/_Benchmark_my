import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))       // Sensor inputs (3-bit wide vector)
    val fr3 = Output(Bool())       // Flow rate control output 3
    val fr2 = Output(Bool())       // Flow rate control output 2
    val fr1 = Output(Bool())       // Flow rate control output 1
    val dfr = Output(Bool())       // Supplemental flow valve output
  })

  // State variables
  val prevS = RegInit(0.U(3.W))    // Register to store previous state of sensors

  // Default values for outputs
  val fr3 = RegInit(true.B)        // Default value of fr3 as part of reset functionality
  val fr2 = RegInit(true.B)        // Default value of fr2 as part of reset functionality
  val fr1 = RegInit(true.B)        // Default value of fr1 as part of reset functionality
  val dfr = RegInit(true.B)        // Default value of dfr as part of reset functionality

  // Connect internal registers to output
  io.fr3 := fr3
  io.fr2 := fr2
  io.fr1 := fr1
  io.dfr := dfr

  // Flow rate control logic
  when (reset.asBool()) {
    // Synchronous reset: set outputs to defaults
    fr3 := true.B
    fr2 := true.B
    fr1 := true.B
    dfr := true.B
    prevS := 0.U
  } .otherwise {
    // Logic to update flow rates based on water levels
    switch(io.s) {
      is("b111".U) {
        fr3 := false.B
        fr2 := false.B
        fr1 := false.B
      }
      is("b011".U) {
        fr3 := false.B
        fr2 := false.B
        fr1 := true.B
      }
      is("b001".U) {
        fr3 := false.B
        fr2 := true.B
        fr1 := true.B
      }
      is("b000".U) {
        fr3 := true.B
        fr2 := true.B
        fr1 := true.B
      }
    }

    // Logic for supplemental flow valve output (dfr)
    when(io.s > prevS) {
      dfr := true.B
    } .otherwise {
      dfr := false.B
    }

    // Update previous sensor state
    prevS := io.s
  }
}

// Generate the Verilog code for the module (for synthesis or simulation)
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
