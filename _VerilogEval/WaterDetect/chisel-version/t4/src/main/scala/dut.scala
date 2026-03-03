import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s   = Input(UInt(3.W))   // {s3,s2,s1}
    val rst = Input(Bool())      // active-high synchronous reset

    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
  })

  // Level encoding:
  // 0 -> below s1      (000)
  // 1 -> between s2/s1 (001)
  // 2 -> between s3/s2 (011)
  // 3 -> above s3      (111)
  // For invalid patterns, use PopCount as a reasonable fallback.
  val currLevel = Wire(UInt(2.W))
  currLevel := PopCount(io.s)

  // Track last sampled level and level before the last sensor change.
  val lastLevel         = RegInit(0.U(2.W))
  val prevLevelAtChange = RegInit(0.U(2.W))

  // Effective previous level for direction detection, including the cycle
  // when a new sensor transition is first observed.
  val effectivePrev = Wire(UInt(2.W))
  effectivePrev := Mux(currLevel =/= lastLevel, lastLevel, prevLevelAtChange)

  when(io.rst) {
    // Reset to "water low for a long time":
    // equivalent internal state = no sensors asserted for long time.
    lastLevel := 0.U
    prevLevelAtChange := 0.U
  }.otherwise {
    when(currLevel =/= lastLevel) {
      prevLevelAtChange := lastLevel
      lastLevel := currLevel
    }
  }

  // Nominal flow defaults
  io.fr1 := false.B
  io.fr2 := false.B
  io.fr3 := false.B
  io.dfr := false.B

  // Output logic
  when(io.rst) {
    // During synchronous reset cycle, force all outputs asserted.
    io.fr1 := true.B
    io.fr2 := true.B
    io.fr3 := true.B
    io.dfr := true.B
  }.otherwise {
    switch(currLevel) {
      is(3.U) { // above s3
        io.fr1 := false.B
        io.fr2 := false.B
        io.fr3 := false.B
        io.dfr := false.B
      }
      is(2.U) { // between s3 and s2
        io.fr1 := true.B
        io.fr2 := false.B
        io.fr3 := false.B
        io.dfr := effectivePrev < currLevel
      }
      is(1.U) { // between s2 and s1
        io.fr1 := true.B
        io.fr2 := true.B
        io.fr3 := false.B
        io.dfr := effectivePrev < currLevel
      }
      is(0.U) { // below s1
        io.fr1 := true.B
        io.fr2 := true.B
        io.fr3 := true.B
        io.dfr := true.B
      }
    }
  }
}
