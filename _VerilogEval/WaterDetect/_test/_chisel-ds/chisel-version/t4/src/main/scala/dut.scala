import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W)) // 3-bit input for sensors s[3:1]
    val fr3 = Output(Bool()) // Output for fr3
    val fr2 = Output(Bool()) // Output for fr2
    val fr1 = Output(Bool()) // Output for fr1
    val dfr = Output(Bool()) // Output for dfr
    val reset = Input(Bool()) // Synchronous reset
  })

  // Internal state to track the previous water level
  val prevLevel = RegInit(0.U(2.W)) // 2 bits to represent previous level

  // Reset logic
  when(io.reset) {
    io.fr3 := true.B
    io.fr2 := true.B
    io.fr1 := true.B
    io.dfr := true.B
    prevLevel := 0.U
  }.otherwise {
    // Default outputs
    io.fr3 := false.B
    io.fr2 := false.B
    io.fr1 := false.B
    io.dfr := false.B

    // Determine current water level based on sensors
    val currentLevel = WireDefault(0.U(2.W))
    when(io.s(2) && io.s(1) && io.s(0)) { // Above s[3]
      currentLevel := 3.U
    }.elsewhen(io.s(1) && io.s(0)) { // Between s[3] and s[2]
      currentLevel := 2.U
    }.elsewhen(io.s(0)) { // Between s[2] and s[1]
      currentLevel := 1.U
    }.otherwise { // Below s[1]
      currentLevel := 0.U
    }

    // Logic to determine outputs based on current and previous levels
    switch(currentLevel) {
      is(3.U) { // Above s[3]
        io.fr3 := false.B
        io.fr2 := false.B
        io.fr1 := false.B
        io.dfr := false.B
      }
      is(2.U) { // Between s[3] and s[2]
        io.fr1 := true.B
        when(prevLevel < currentLevel) {
          io.dfr := true.B
        }
      }
      is(1.U) { // Between s[2] and s[1]
        io.fr1 := true.B
        io.fr2 := true.B
        when(prevLevel < currentLevel) {
          io.dfr := true.B
        }
      }
      is(0.U) { // Below s[1]
        io.fr1 := true.B
        io.fr2 := true.B
        io.fr3 := true.B
        io.dfr := true.B
      }
    }

    // Update previous level
    prevLevel := currentLevel
  }
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
