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

  // Define water level states based on sensor readings
  val level_above_s3 = s1 && s2 && s3      // Above s[3]: all sensors asserted
  val level_between_s3_s2 = s1 && s2 && !s3 // Between s[3] and s[2]: s[1], s[2] asserted
  val level_between_s2_s1 = s1 && !s2       // Between s[2] and s[1]: only s[1] asserted
  val level_below_s1 = !s1                  // Below s[1]: no sensors asserted

  // Previous water level register to detect rising/falling transitions
  val prev_level = RegInit(0.U(2.W))
  
  // Current level encoding:
  // 0: below s[1]
  // 1: between s[2] and s[1]
  // 2: between s[3] and s[2]
  // 3: above s[3]
  val curr_level = Wire(UInt(2.W))
  curr_level := MuxCase(0.U, Seq(
    level_above_s3 -> 3.U,
    level_between_s3_s2 -> 2.U,
    level_between_s2_s1 -> 1.U,
    level_below_s1 -> 0.U
  ))

  // Detect if water level is rising (previous level was lower)
  val level_rising = curr_level > prev_level

  // Update previous level
  prev_level := curr_level

  // Default outputs
  val fr3_reg = RegInit(true.B)
  val fr2_reg = RegInit(true.B)
  val fr1_reg = RegInit(true.B)
  val dfr_reg = RegInit(true.B)

  // Determine nominal flow rates based on current water level
  when(level_above_s3) {
    // Above s[3]: No flow needed
    fr3_reg := false.B
    fr2_reg := false.B
    fr1_reg := false.B
    dfr_reg := false.B
  }.elsewhen(level_between_s3_s2) {
    // Between s[3] and s[2]: fr1 only
    fr3_reg := false.B
    fr2_reg := false.B
    fr1_reg := true.B
    // Add supplemental flow if level is rising
    dfr_reg := level_rising
  }.elsewhen(level_between_s2_s1) {
    // Between s[2] and s[1]: fr1, fr2
    fr3_reg := false.B
    fr2_reg := true.B
    fr1_reg := true.B
    // Add supplemental flow if level is rising
    dfr_reg := level_rising
  }.otherwise {
    // Below s[1]: Maximum flow (fr1, fr2, fr3)
    fr3_reg := true.B
    fr2_reg := true.B
    fr1_reg := true.B
    // Add supplemental flow if level is rising
    dfr_reg := level_rising
  }

  // Connect outputs
  io.fr3 := fr3_reg
  io.fr2 := fr2_reg
  io.fr1 := fr1_reg
  io.dfr := dfr_reg
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, Array("--target-dir", "generated"))
}
*/
