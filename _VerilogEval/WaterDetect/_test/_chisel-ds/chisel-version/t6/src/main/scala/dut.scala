import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W)) // Sensors s[3:1]
    val fr3 = Output(Bool()) // Flow rate output 3
    val fr2 = Output(Bool()) // Flow rate output 2
    val fr1 = Output(Bool()) // Flow rate output 1
    val dfr = Output(Bool()) // Supplemental flow valve
    val reset = Input(Bool()) // Synchronous reset
  })

  // Internal state to track the previous water level
  val prevLevel = RegInit(0.U(2.W)) // 0: Below s[1], 1: Between s[1] and s[2], 2: Between s[2] and s[3], 3: Above s[3]

  // Default outputs
  io.fr3 := false.B
  io.fr2 := false.B
  io.fr1 := false.B
  io.dfr := false.B

  // Reset logic
  when(io.reset) {
    prevLevel := 0.U // Reset to "Below s[1]" state
    io.fr3 := true.B
    io.fr2 := true.B
    io.fr1 := true.B
    io.dfr := true.B
  }.otherwise {
    // Determine the current water level based on sensor inputs
    val currentLevel = Wire(UInt(2.W))
    currentLevel := 0.U // Default to "Below s[1]"

    when(io.s(1)) {
      currentLevel := 1.U // "Between s[1] and s[2]"
    }
    when(io.s(2)) {
      currentLevel := 2.U // "Between s[2] and s[3]"
    }
    when(io.s(3)) {
      currentLevel := 3.U // "Above s[3]"
    }

    // Determine flow rate outputs based on current level
    switch(currentLevel) {
      is(0.U) { // Below s[1]
        io.fr3 := true.B
        io.fr2 := true.B
        io.fr1 := true.B
      }
      is(1.U) { // Between s[1] and s[2]
        io.fr1 := true.B
        io.fr2 := true.B
      }
      is(2.U) { // Between s[2] and s[3]
        io.fr1 := true.B
      }
      is(3.U) { // Above s[3]
        // No outputs asserted
      }
    }

    // Determine if the supplemental flow valve should be opened
    when(currentLevel > prevLevel) {
      io.dfr := true.B
    }

    // Update the previous level
    prevLevel := currentLevel
  }
}
