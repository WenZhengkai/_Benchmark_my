import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val rst  = Input(Bool())      // active-high synchronous reset
    val s    = Input(UInt(3.W))   // s(2)=s[3], s(1)=s[2], s(0)=s[1]

    val fr3  = Output(Bool())
    val fr2  = Output(Bool())
    val fr1  = Output(Bool())
    val dfr  = Output(Bool())
  })

  // Level encoding:
  // 0: below s[1]      -> 000
  // 1: between s[2],s[1] -> 100
  // 2: between s[3],s[2] -> 110
  // 3: above s[3]      -> 111
  def decodeLevel(s: UInt): UInt = {
    MuxLookup(
      s,
      0.U(2.W), // default for illegal patterns
      Seq(
        "b000".U -> 0.U(2.W),
        "b100".U -> 1.U(2.W),
        "b110".U -> 2.U(2.W),
        "b111".U -> 3.U(2.W)
      )
    )
  }

  val sensorLevel = decodeLevel(io.s)

  // Track current level and level before the most recent sensor change
  val currLevel = RegInit(0.U(2.W))
  val prevLevel = RegInit(0.U(2.W))

  when(io.rst) {
    // Reset to "low for a long time":
    // no sensors asserted (level 0), all outputs asserted
    currLevel := 0.U
    prevLevel := 0.U
  }.otherwise {
    when(sensorLevel =/= currLevel) {
      prevLevel := currLevel
      currLevel := sensorLevel
    }
  }

  // Nominal flow outputs from current level
  io.fr1 := (currLevel <= 2.U)
  io.fr2 := (currLevel <= 1.U)
  io.fr3 := (currLevel === 0.U)

  // Supplemental flow:
  // - always on at lowest level (maximum flow)
  // - always off at highest level
  // - in middle levels, on if level rose since last sensor change
  val roseSinceLastChange = prevLevel < currLevel
  io.dfr := Mux(currLevel === 0.U, true.B,
            Mux(currLevel === 3.U, false.B, roseSinceLastChange))
}
