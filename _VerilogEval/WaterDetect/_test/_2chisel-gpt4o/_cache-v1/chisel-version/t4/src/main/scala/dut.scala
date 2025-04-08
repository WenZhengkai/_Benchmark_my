import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s    = Input(UInt(3.W)) // 3 sensor inputs
    val fr3  = Output(Bool())   // Flow rate 3 control signal
    val fr2  = Output(Bool())   // Flow rate 2 control signal
    val fr1  = Output(Bool())   // Flow rate 1 control signal
    val dfr  = Output(Bool())   // Supplemental flow rate control signal
  })

  // State register to track previous water level
  val prevSensors = RegInit(0.U(3.W)) // Active high reset, initial state is 0
  val resetSignal = this.reset.asBool

  // Default outputs
  io.fr3 := false.B
  io.fr2 := false.B
  io.fr1 := false.B
  io.dfr := false.B

  // Synchronous reset logic
  when(resetSignal) {
    prevSensors := 0.U // Reset the previous sensors state
    io.fr3 := true.B
    io.fr2 := true.B
    io.fr1 := true.B
    io.dfr := true.B
  }.otherwise {
    // Update previous sensor state on every clock cycle
    prevSensors := io.s

    // Water level detection logic
    switch(io.s) {
      is("b111".U) { // Above s[3] (s[3], s[2], and s[1] asserted)
        // No outputs should be asserted
        io.fr3 := false.B
        io.fr2 := false.B
        io.fr1 := false.B
        io.dfr := false.B
      }
      is("b011".U) { // Between s[3] and s[2] (s[2] and s[1] asserted)
        io.fr3 := false.B
        io.fr2 := false.B
        io.fr1 := true.B
        when(prevSensors < io.s) { // If water level went up
          io.dfr := true.B
        }.otherwise {
          io.dfr := false.B
        }
      }
      is("b001".U) { // Between s[2] and s[1] (only s[1] asserted)
        io.fr3 := false.B
        io.fr2 := true.B
        io.fr1 := true.B
        when(prevSensors < io.s) { // If water level went up
          io.dfr := true.B
        }.otherwise {
          io.dfr := false.B
        }
      }
      is("b000".U) { // Below s[1] (no sensors asserted)
        io.fr3 := true.B
        io.fr2 := true.B
        io.fr1 := true.B
        io.dfr := false.B // Nominal maximum flow rate, dfr is off
      }
    }
  }
}
