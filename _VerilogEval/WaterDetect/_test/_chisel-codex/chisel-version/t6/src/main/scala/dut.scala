import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s    = Input(UInt(3.W)) // s[3:1] packed as s(2)=s3, s(1)=s2, s(0)=s1
    val srst = Input(Bool())    // active-high synchronous reset

    val fr3  = Output(Bool())
    val fr2  = Output(Bool())
    val fr1  = Output(Bool())
    val dfr  = Output(Bool())
  })

  // Level encoding:
  // 3: above s3  (111)
  // 2: between s3 and s2 (110)
  // 1: between s2 and s1 (100)
  // 0: below s1  (000)
  val sensedLevel = MuxLookup(io.s, 0.U(2.W), Seq(
    "b111".U -> 3.U(2.W),
    "b110".U -> 2.U(2.W),
    "b100".U -> 1.U(2.W),
    "b000".U -> 0.U(2.W)
  ))

  // Track current level and the previous level before the last sensor change.
  val currentLevel = RegInit(0.U(2.W))
  val prevLevel    = RegInit(0.U(2.W))

  when(io.srst) {
    // Reset to "low for a long time": no sensors asserted, all outputs asserted.
    currentLevel := 0.U
    prevLevel    := 0.U
  }.elsewhen(sensedLevel =/= currentLevel) {
    prevLevel    := currentLevel
    currentLevel := sensedLevel
  }

  // Nominal flow outputs from current level.
  io.fr1 := currentLevel =/= 3.U
  io.fr2 := currentLevel <= 1.U
  io.fr3 := currentLevel === 0.U

  // Supplemental flow:
  // - Always on at lowest level (maximum flow).
  // - For middle levels, on when previous level was lower than current level.
  io.dfr := (currentLevel === 0.U) ||
            (((currentLevel === 1.U) || (currentLevel === 2.U)) && (prevLevel < currentLevel))
}
