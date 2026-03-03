import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(4.W))  // s[3:1], s[0] unused
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
  })

  // Extract individual sensor bits
  val s1 = io.s(1)
  val s2 = io.s(2)
  val s3 = io.s(3)

  // Create current sensor pattern
  val currentLevel = Cat(s3, s2, s1)

  // Register to store previous sensor pattern
  val prevLevel = RegInit(0.U(3.W))

  // Register outputs
  val fr3Reg = RegInit(true.B)
  val fr2Reg = RegInit(true.B)
  val fr1Reg = RegInit(true.B)
  val dfrReg = RegInit(true.B)

  // Update previous level
  prevLevel := currentLevel

  // Determine if water level is rising
  // Water is rising if current level > previous level (more sensors asserted)
  val isRising = currentLevel > prevLevel

  // Determine nominal flow rates based on current water level
  when(currentLevel === "b111".U) {
    // Above s[3]: All sensors asserted - No flow
    fr3Reg := false.B
    fr2Reg := false.B
    fr1Reg := false.B
    dfrReg := false.B
  }.elsewhen(currentLevel === "b011".U) {
    // Between s[3] and s[2]: s[1] and s[2] asserted - fr1 only
    fr3Reg := false.B
    fr2Reg := false.B
    fr1Reg := true.B
    dfrReg := isRising
  }.elsewhen(currentLevel === "b001".U) {
    // Between s[2] and s[1]: s[1] only asserted - fr1, fr2
    fr3Reg := false.B
    fr2Reg := true.B
    fr1Reg := true.B
    dfrReg := isRising
  }.elsewhen(currentLevel === "b000".U) {
    // Below s[1]: No sensors asserted - fr1, fr2, fr3
    fr3Reg := true.B
    fr2Reg := true.B
    fr1Reg := true.B
    dfrReg := true.B
  }.otherwise {
    // Invalid sensor combinations - maintain previous state
    // This handles cases like "b010", "b100", "b101", "b110"
    // Keep current register values
  }

  // Assign outputs
  io.fr3 := fr3Reg
  io.fr2 := fr2Reg
  io.fr1 := fr1Reg
  io.dfr := dfrReg
}

/*
object dut extends App {
  println("Generating the water reservoir controller hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
