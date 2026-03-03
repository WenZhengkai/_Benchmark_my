import chisel3._

class dut extends Module {
  val io = IO(new Bundle {
    val s   = Input(UInt(3.W)) // s(2)=s[3], s(1)=s[2], s(0)=s[1]
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
  })

  // Water level encoding:
  // 0: below s[1], 1: between s[2] and s[1], 2: between s[3] and s[2], 3: above s[3]
  val levelNow = Wire(UInt(2.W))
  levelNow := Mux(io.s(2), 3.U, Mux(io.s(1), 2.U, Mux(io.s(0), 1.U, 0.U)))

  // Track current level and the level before the last sensor change.
  // Reset state: "low for a long time" => no sensors asserted.
  val currentLevel = RegInit(0.U(2.W))
  val prevLevel    = RegInit(0.U(2.W))

  when(levelNow =/= currentLevel) {
    prevLevel    := currentLevel
    currentLevel := levelNow
  }

  // Nominal flow outputs from current water level
  io.fr1 := (currentLevel <= 2.U)
  io.fr2 := (currentLevel <= 1.U)
  io.fr3 := (currentLevel === 0.U)

  // Supplemental flow:
  // - always on at lowest level (maximum flow),
  // - off above highest sensor,
  // - for middle levels, on if last change was upward (prev < current).
  io.dfr := Mux(
    currentLevel === 0.U,
    true.B,
    Mux(currentLevel === 3.U, false.B, prevLevel < currentLevel)
  )
}
