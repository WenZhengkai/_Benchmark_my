import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W)) // Sensors s[3:1]
    val fr3 = Output(Bool()) // Nominal flow rate 3
    val fr2 = Output(Bool()) // Nominal flow rate 2
    val fr1 = Output(Bool()) // Nominal flow rate 1
    val dfr = Output(Bool()) // Supplemental flow valve
    val reset = Input(Bool()) // Active-high synchronous reset
  })

  // State machine to track the previous water level
  val prevLevel = RegInit(0.U(2.W)) // 2 bits to represent 4 states

  // Default outputs
  io.fr3 := false.B
  io.fr2 := false.B
  io.fr1 := false.B
  io.dfr := false.B

  // Handle reset
  when(io.reset) {
    prevLevel := 0.U // Reset to the state equivalent to low water level
    io.fr3 := true.B
    io.fr2 := true.B
    io.fr1 := true.B
    io.dfr := true.B
  }.otherwise {
    // Determine the current water level based on sensors
    val currentLevel = Wire(UInt(2.W))
    currentLevel := MuxCase(3.U, Seq(
      (io.s === "b111".U) -> 3.U, // Above s[3]
      (io.s === "b011".U) -> 2.U, // Between s[3] and s[2]
      (io.s === "b001".U) -> 1.U, // Between s[2] and s[1]
      (io.s === "b000".U) -> 0.U  // Below s[1]
    ))

    // Determine the nominal flow rate outputs
    switch(currentLevel) {
      is(3.U) { // Above s[3]
        io.fr3 := false.B
        io.fr2 := false.B
        io.fr1 := false.B
      }
      is(2.U) { // Between s[3] and s[2]
        io.fr3 := false.B
        io.fr2 := false.B
        io.fr1 := true.B
      }
      is(1.U) { // Between s[2] and s[1]
        io.fr3 := false.B
        io.fr2 := true.B
        io.fr1 := true.B
      }
      is(0.U) { // Below s[1]
        io.fr3 := true.B
        io.fr2 := true.B
        io.fr1 := true.B
      }
    }

    // Determine if the Supplemental flow valve should be opened
    when(currentLevel > prevLevel) {
      io.dfr := true.B
    }

    // Update the previous level
    prevLevel := currentLevel
  }
}

// Generate Verilog
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
