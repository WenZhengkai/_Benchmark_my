import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W)) // 3-bit input for sensors s[3:1]
    val fr3 = Output(Bool()) // Flow rate control output 3
    val fr2 = Output(Bool()) // Flow rate control output 2
    val fr1 = Output(Bool()) // Flow rate control output 1
    val dfr = Output(Bool()) // Supplemental flow valve control
    val reset = Input(Bool()) // Active-high synchronous reset
  })

  // Internal state to track the previous water level
  val prevLevel = RegInit(0.U(2.W)) // 2 bits to represent previous level (0: below s[1], 1: between s[1] and s[2], 2: between s[2] and s[3], 3: above s[3])

  // Default outputs
  io.fr3 := false.B
  io.fr2 := false.B
  io.fr1 := false.B
  io.dfr := false.B

  // Logic to determine the current water level
  val currentLevel = Wire(UInt(2.W))
  currentLevel := MuxCase(0.U, Seq(
    (io.s === "b111".U) -> 3.U, // Above s[3]
    (io.s === "b011".U) -> 2.U, // Between s[3] and s[2]
    (io.s === "b001".U) -> 1.U, // Between s[2] and s[1]
    (io.s === "b000".U) -> 0.U  // Below s[1]
  ))

  // Logic to update outputs based on the current and previous water levels
  when(io.reset) {
    // Reset state: all outputs asserted, equivalent to water level being low for a long time
    io.fr3 := true.B
    io.fr2 := true.B
    io.fr1 := true.B
    io.dfr := true.B
    prevLevel := 0.U
  }.otherwise {
    // Normal operation
    switch(currentLevel) {
      is(3.U) { // Above s[3]
        io.fr3 := false.B
        io.fr2 := false.B
        io.fr1 := false.B
        io.dfr := false.B
      }
      is(2.U) { // Between s[3] and s[2]
        io.fr3 := false.B
        io.fr2 := false.B
        io.fr1 := true.B
        io.dfr := prevLevel < currentLevel
      }
      is(1.U) { // Between s[2] and s[1]
        io.fr3 := false.B
        io.fr2 := true.B
        io.fr1 := true.B
        io.dfr := prevLevel < currentLevel
      }
      is(0.U) { // Below s[1]
        io.fr3 := true.B
        io.fr2 := true.B
        io.fr1 := true.B
        io.dfr := true.B
      }
    }
    // Update the previous level for the next cycle
    prevLevel := currentLevel
  }
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
