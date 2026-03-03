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
  val prevLevel = RegInit(0.U(2.W))  // 0: below s1, 1: between s2-s1, 2: between s3-s2, 3: above s3
  
  // Determine current water level based on sensors
  val currLevel = Wire(UInt(2.W))
  currLevel := MuxCase(0.U, Seq(
    (s1 && s2 && s3) -> 3.U,  // Above s[3]
    (s1 && s2 && !s3) -> 2.U, // Between s[3] and s[2]
    (s1 && !s2) -> 1.U,       // Between s[2] and s[1]
    (!s1) -> 0.U              // Below s[1]
  ))

  // Determine if water level is rising (previous < current)
  val isRising = prevLevel < currLevel

  // Update previous level
  prevLevel := currLevel

  // Determine nominal flow rates based on current level
  val nominalFr1 = Wire(Bool())
  val nominalFr2 = Wire(Bool())
  val nominalFr3 = Wire(Bool())

  nominalFr1 := MuxCase(false.B, Seq(
    (currLevel === 0.U) -> true.B,  // Below s[1]: fr1, fr2, fr3
    (currLevel === 1.U) -> true.B,  // Between s[2] and s[1]: fr1, fr2
    (currLevel === 2.U) -> true.B,  // Between s[3] and s[2]: fr1
    (currLevel === 3.U) -> false.B  // Above s[3]: none
  ))

  nominalFr2 := MuxCase(false.B, Seq(
    (currLevel === 0.U) -> true.B,  // Below s[1]: fr1, fr2, fr3
    (currLevel === 1.U) -> true.B,  // Between s[2] and s[1]: fr1, fr2
    (currLevel === 2.U) -> false.B, // Between s[3] and s[2]: fr1
    (currLevel === 3.U) -> false.B  // Above s[3]: none
  ))

  nominalFr3 := MuxCase(false.B, Seq(
    (currLevel === 0.U) -> true.B,  // Below s[1]: fr1, fr2, fr3
    (currLevel === 1.U) -> false.B, // Between s[2] and s[1]: fr1, fr2
    (currLevel === 2.U) -> false.B, // Between s[3] and s[2]: fr1
    (currLevel === 3.U) -> false.B  // Above s[3]: none
  ))

  // Determine if supplemental flow (dfr) should be active
  // dfr is active when water level is rising
  val supplementalFlow = isRising

  // Assign outputs
  io.fr1 := nominalFr1
  io.fr2 := nominalFr2
  io.fr3 := nominalFr3
  io.dfr := supplementalFlow

  // Handle reset: equivalent to water level being low for a long time
  // No sensors asserted (currLevel = 0), all outputs asserted
  when(reset.asBool) {
    prevLevel := 0.U
  }
}

/*
object dutDriver extends App {
  emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
