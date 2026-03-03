import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(4.W))  // s[3:1], s[0] is unused
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
  })

  // Extract individual sensor bits
  val s1 = io.s(1)
  val s2 = io.s(2)
  val s3 = io.s(3)

  // Register to store previous water level
  val prevLevel = RegInit(0.U(2.W))
  
  // Current water level encoding:
  // 0: Below s[1] (no sensors asserted)
  // 1: Between s[2] and s[1] (only s[1] asserted)
  // 2: Between s[3] and s[2] (s[1] and s[2] asserted)
  // 3: Above s[3] (all sensors asserted)
  
  val currentLevel = Wire(UInt(2.W))
  currentLevel := MuxCase(0.U, Seq(
    (s1 && s2 && s3) -> 3.U,
    (s1 && s2 && !s3) -> 2.U,
    (s1 && !s2) -> 1.U,
    (!s1) -> 0.U
  ))

  // Determine if water level is rising (previous level was lower than current)
  val levelRising = currentLevel > prevLevel

  // Update previous level register
  prevLevel := currentLevel

  // Determine nominal flow rates based on current water level
  val nominalFr1 = Wire(Bool())
  val nominalFr2 = Wire(Bool())
  val nominalFr3 = Wire(Bool())

  nominalFr1 := MuxCase(false.B, Seq(
    (currentLevel === 0.U) -> true.B,  // Below s[1]
    (currentLevel === 1.U) -> true.B,  // Between s[2] and s[1]
    (currentLevel === 2.U) -> true.B   // Between s[3] and s[2]
  ))

  nominalFr2 := MuxCase(false.B, Seq(
    (currentLevel === 0.U) -> true.B,  // Below s[1]
    (currentLevel === 1.U) -> true.B   // Between s[2] and s[1]
  ))

  nominalFr3 := (currentLevel === 0.U)  // Only below s[1]

  // Supplemental flow valve (dfr) is opened when level is rising
  // and we're not at the highest level
  val supplementalFlow = levelRising && (currentLevel =/= 3.U)

  // Output assignments
  io.fr1 := nominalFr1
  io.fr2 := nominalFr2
  io.fr3 := nominalFr3
  io.dfr := supplementalFlow

  // Handle reset: equivalent to water level being low for a long time
  // (no sensors asserted, all outputs asserted, and previous level was also low)
  when(reset.asBool) {
    prevLevel := 0.U
  }
}

/*
object dut extends App {
  println("Generating Verilog for Water Reservoir Controller...")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
