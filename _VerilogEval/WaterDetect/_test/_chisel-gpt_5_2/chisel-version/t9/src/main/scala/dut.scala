// See README/spec for behavior.
// Chisel 3.x

import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s   = Input(UInt(3.W))  // s(2)=s[3] top, s(1)=s[2] mid, s(0)=s[1] low
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
    val resetSync = Input(Bool()) // active-high synchronous reset
  })

  // Water level states inferred from sensors.
  // We assume physically valid sensor patterns:
  // 111 (above top), 011 (between top & mid), 001 (between mid & low), 000 (below low)
  val ST_ABOVE_TOP :: ST_BETWEEN_TOP_MID :: ST_BETWEEN_MID_LOW :: ST_BELOW_LOW :: Nil =
    Enum(4)

  def decodeLevel(s: UInt): UInt = {
    MuxLookup(s, ST_BELOW_LOW, Seq(
      "b111".U -> ST_ABOVE_TOP,
      "b011".U -> ST_BETWEEN_TOP_MID,
      "b001".U -> ST_BETWEEN_MID_LOW,
      "b000".U -> ST_BELOW_LOW
    ))
  }

  // Remember previous *level* at the last sensor-change event.
  val prevLevel = RegInit(ST_BELOW_LOW)
  val lastS     = RegInit("b000".U(3.W))

  val curLevel = decodeLevel(io.s)

  // Track last sensor-change; on change, record the previous level.
  when(io.resetSync) {
    prevLevel := ST_BELOW_LOW
    lastS     := "b000".U
  }.otherwise {
    when(io.s =/= lastS) {
      prevLevel := decodeLevel(lastS)
      lastS     := io.s
    }
  }

  // Nominal outputs by current water level (table in spec)
  val nom_fr1 = WireDefault(false.B)
  val nom_fr2 = WireDefault(false.B)
  val nom_fr3 = WireDefault(false.B)

  switch(curLevel) {
    is(ST_ABOVE_TOP) { // 111
      nom_fr1 := false.B; nom_fr2 := false.B; nom_fr3 := false.B
    }
    is(ST_BETWEEN_TOP_MID) { // 011
      nom_fr1 := true.B;  nom_fr2 := false.B; nom_fr3 := false.B
    }
    is(ST_BETWEEN_MID_LOW) { // 001
      nom_fr1 := true.B;  nom_fr2 := true.B;  nom_fr3 := false.B
    }
    is(ST_BELOW_LOW) { // 000
      nom_fr1 := true.B;  nom_fr2 := true.B;  nom_fr3 := true.B
    }
  }

  // Supplemental flow valve (dfr):
  // If the last sensor change indicates the previous level was lower than the current level,
  // assert dfr (i.e., level rose across a sensor boundary).
  val rising = prevLevel < curLevel
  val nom_dfr = rising

  // Synchronous reset requires "no sensors asserted, and all four outputs asserted".
  when(io.resetSync) {
    io.fr1 := true.B
    io.fr2 := true.B
    io.fr3 := true.B
    io.dfr := true.B
  }.otherwise {
    io.fr1 := nom_fr1
    io.fr2 := nom_fr2
    io.fr3 := nom_fr3
    io.dfr := nom_dfr
  }
}
