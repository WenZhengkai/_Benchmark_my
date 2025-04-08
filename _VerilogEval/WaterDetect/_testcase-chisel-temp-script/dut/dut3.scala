import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W)) // 3 sensors representing the water level
    val fr3 = Output(Bool()) // Nominal flow rate 3
    val fr2 = Output(Bool()) // Nominal flow rate 2
    val fr1 = Output(Bool()) // Nominal flow rate 1
    val dfr = Output(Bool()) // Supplemental flow rate
    val reset = Input(Bool()) // Active-high synchronous reset
  })

  // State variables to track previous sensor state
  val prevS = RegInit(0.U(3.W)) // Store the previous sensor states

  // Defaults for output signals
  io.fr3 := false.B
  io.fr2 := false.B
  io.fr1 := false.B
  io.dfr := false.B

  // Define the active-high reset behavior
  when(io.reset) {
    io.fr3 := true.B
    io.fr2 := true.B
    io.fr1 := true.B
    io.dfr := true.B
  }.otherwise {
    // Logic for determining flow rates based on the sensor levels
    when(io.s === "b111".U) { // Above sensor s[3]
      // Turn off all flow rates (none asserted)
      io.fr3 := false.B
      io.fr2 := false.B
      io.fr1 := false.B
      io.dfr := false.B
    }.elsewhen(io.s === "b011".U) { // Between s[3] and s[2]
      // Assert nominal flow rate fr1
      io.fr3 := false.B
      io.fr2 := false.B
      io.fr1 := true.B
      // Determine if supplemental flow rate should be asserted
      io.dfr := prevS < io.s
    }.elsewhen(io.s === "b001".U) { // Between s[2] and s[1]
      // Assert nominal flow rates fr1 and fr2
      io.fr3 := false.B
      io.fr2 := true.B
      io.fr1 := true.B
      // Determine if supplemental flow rate should be asserted
      io.dfr := prevS < io.s
    }.elsewhen(io.s === "b000".U) { // Below sensor s[1]
      // Assert all nominal flow rates fr1, fr2, and fr3
      io.fr3 := true.B
      io.fr2 := true.B
      io.fr1 := true.B
      // Assert supplemental flow rate
      io.dfr := true.B
    }
  }

  // Update state: Store the current sensors as "previous" for next clock cycle
  prevS := io.s
}

// Generate Verilog for this module
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
