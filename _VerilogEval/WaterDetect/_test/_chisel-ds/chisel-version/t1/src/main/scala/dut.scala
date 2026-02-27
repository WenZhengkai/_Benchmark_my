import chisel3._
import chisel3.util._

class dut extends Module {
  // I/O Ports
  val io = IO(new Bundle {
    val s = Input(UInt(3.W)) // Sensors s[3:1]
    val fr3 = Output(Bool()) // Nominal flow rate valve 3
    val fr2 = Output(Bool()) // Nominal flow rate valve 2
    val fr1 = Output(Bool()) // Nominal flow rate valve 1
    val dfr = Output(Bool()) // Supplemental flow rate valve
    val reset = Input(Bool()) // Synchronous reset
  })

  // Internal state to track the previous water level
  val prevLevel = RegInit(0.U(2.W)) // 2 bits to represent 4 levels

  // State machine logic
  when(io.reset) {
    // Reset state: all outputs asserted (equivalent to low water level)
    io.fr3 := true.B
    io.fr2 := true.B
    io.fr1 := true.B
    io.dfr := true.B
    prevLevel := 0.U
  }.otherwise {
    // Determine the current water level based on sensors
    val currentLevel = Wire(UInt(2.W))
    currentLevel := MuxCase(
      3.U, // Default: above s[3]
      Seq(
        (io.s === "b000".U) -> 0.U, // Below s[1]
        (io.s === "b001".U) -> 1.U, // Between s[2] and s[1]
        (io.s === "b011".U) -> 2.U  // Between s[3] and s[2]
      )
    )

    // Update flow rate outputs based on current level
    io.fr3 := currentLevel === 0.U
    io.fr2 := currentLevel <= 1.U
    io.fr1 := currentLevel <= 2.U

    // Determine if the supplemental flow valve should be opened
    io.dfr := prevLevel < currentLevel

    // Update the previous level
    prevLevel := currentLevel
  }
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
