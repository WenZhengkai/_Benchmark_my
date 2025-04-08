import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))      // Sensors input [3:1]
    val fr3 = Output(Bool())      // Flow rate 3
    val fr2 = Output(Bool())      // Flow rate 2
    val fr1 = Output(Bool())      // Flow rate 1
    val dfr = Output(Bool())      // Supplemental flow rate
  })

  // State registers to track current and previous water levels
  val prevLevel = RegInit(0.U(2.W))
  val currLevel = WireDefault(0.U(2.W))

  // Decode current water level based on sensor inputs
  when(io.s === "b111".U) {            // All sensors active (Above s[3])
    currLevel := 3.U
  }.elsewhen(io.s === "b011".U) {      // s[2] and s[1] active (Between s[3] and s[2])
    currLevel := 2.U
  }.elsewhen(io.s === "b001".U) {      // s[1] active (Between s[2] and s[1])
    currLevel := 1.U
  }.elsewhen(io.s === "b000".U) {      // No sensors active (Below s[1])
    currLevel := 0.U
  }

  // Reset signal is synchronous and active-high
  val reset = RegInit(false.B)
  when(reset.asBool()) {
    // Reset state: Assume water level is low for a long time
    io.fr3 := true.B
    io.fr2 := true.B
    io.fr1 := true.B
    io.dfr := true.B
    prevLevel := 0.U
  }.otherwise {
    // Default flow rate outputs based on the current water level
    switch(currLevel) {
      is(3.U) { // Above s[3]: No flow rates asserted
        io.fr3 := false.B
        io.fr2 := false.B
        io.fr1 := false.B
        io.dfr := false.B
      }
      is(2.U) { // Between s[3] and s[2]: fr1 nominal flow rate
        io.fr3 := false.B
        io.fr2 := false.B
        io.fr1 := true.B
        io.dfr := false.B
      }
      is(1.U) { // Between s[2] and s[1]: fr1 and fr2 nominal flow rates
        io.fr3 := false.B
        io.fr2 := true.B
        io.fr1 := true.B
        io.dfr := false.B
      }
      is(0.U) { // Below s[1]: All flow rates asserted
        io.fr3 := true.B
        io.fr2 := true.B
        io.fr1 := true.B
        io.dfr := false.B
      }
    }
    
    // Add supplemental flow (dfr) based on the rising water level
    when(prevLevel < currLevel) {
      io.dfr := true.B // Open supplemental flow valve
    }
    prevLevel := currLevel // Update previous level
  }
}

// Generate Verilog output (helper to generate verilog code)
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
