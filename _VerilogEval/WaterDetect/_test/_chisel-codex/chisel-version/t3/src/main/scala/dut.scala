import chisel3._
import chisel3.util._

class dut extends Module with RequireSyncReset {
  val io = IO(new Bundle {
    val s   = Input(UInt(3.W)) // s[3:1] mapped to bits [2:0]
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
  })

  // Valid physical sensor combinations:
  // 000 (below s1), 001 (between s2 and s1), 011 (between s3 and s2), 111 (above s3)
  private def decodeLevel(s: UInt): UInt = {
    MuxLookup(
      s,
      0.U(2.W), // safe default: treat invalid combos as "low"
      Seq(
        "b000".U -> 0.U(2.W),
        "b001".U -> 1.U(2.W),
        "b011".U -> 2.U(2.W),
        "b111".U -> 3.U(2.W)
      )
    )
  }

  val currLevel = decodeLevel(io.s)

  // Track previous level and last transition direction.
  // cameFromLower = 1 means previous level was lower than current level.
  val lastLevel     = RegInit(0.U(2.W)) // reset equivalent: low for long time
  val cameFromLower = RegInit(true.B)

  when(currLevel =/= lastLevel) {
    cameFromLower := lastLevel < currLevel
    lastLevel := currLevel
  }

  // Default outputs
  io.fr1 := false.B
  io.fr2 := false.B
  io.fr3 := false.B
  io.dfr := false.B

  // Nominal flow + supplemental logic
  switch(currLevel) {
    is(0.U) { // Below s1
      io.fr1 := true.B
      io.fr2 := true.B
      io.fr3 := true.B
      io.dfr := true.B // maximum flow includes supplemental valve
    }
    is(1.U) { // Between s2 and s1
      io.fr1 := true.B
      io.fr2 := true.B
      io.dfr := cameFromLower
    }
    is(2.U) { // Between s3 and s2
      io.fr1 := true.B
      io.dfr := cameFromLower
    }
    is(3.U) { // Above s3
      // all outputs remain 0
    }
  }

  // Active-high synchronous reset behavior:
  // force state/output equivalent to "low for a long time".
  when(reset.asBool) {
    io.fr1 := true.B
    io.fr2 := true.B
    io.fr3 := true.B
    io.dfr := true.B
  }
}
