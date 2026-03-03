import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s   = Input(UInt(3.W)) // s(2)=s3 (highest), s(1)=s2, s(0)=s1
    val rst = Input(Bool())    // active-high synchronous reset

    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
  })

  // Convert sensor pattern to one of 4 water levels:
  // 3: above s3, 2: between s3/s2, 1: between s2/s1, 0: below s1
  // This also behaves sensibly for invalid patterns by using highest asserted sensor.
  val level = Wire(UInt(2.W))
  when(io.s(2)) {
    level := 3.U
  }.elsewhen(io.s(1)) {
    level := 2.U
  }.elsewhen(io.s(0)) {
    level := 1.U
  }.otherwise {
    level := 0.U
  }

  // State: last stable level and direction of the last level change
  val lastLevel       = RegInit(0.U(2.W))  // equivalent to "no sensors asserted"
  val lastChangeWasUp = RegInit(false.B)

  // Active-high synchronous reset to "low for a long time" equivalent state
  when(io.rst) {
    lastLevel       := 0.U
    lastChangeWasUp := false.B
  }.elsewhen(level =/= lastLevel) {
    lastChangeWasUp := level > lastLevel // previous level lower than current
    lastLevel       := level
  }

  // Defaults
  io.fr1 := false.B
  io.fr2 := false.B
  io.fr3 := false.B
  io.dfr := false.B

  // Force reset output behavior: all four outputs asserted
  when(io.rst) {
    io.fr1 := true.B
    io.fr2 := true.B
    io.fr3 := true.B
    io.dfr := true.B
  }.otherwise {
    switch(level) {
      is(3.U) { // Above s3: no flow
        io.fr1 := false.B
        io.fr2 := false.B
        io.fr3 := false.B
        io.dfr := false.B
      }
      is(2.U) { // Between s3 and s2: nominal fr1 (+dfr if last change was upward)
        io.fr1 := true.B
        io.fr2 := false.B
        io.fr3 := false.B
        io.dfr := lastChangeWasUp
      }
      is(1.U) { // Between s2 and s1: nominal fr1,fr2 (+dfr if last change was upward)
        io.fr1 := true.B
        io.fr2 := true.B
        io.fr3 := false.B
        io.dfr := lastChangeWasUp
      }
      is(0.U) { // Below s1: maximum flow (all asserted)
        io.fr1 := true.B
        io.fr2 := true.B
        io.fr3 := true.B
        io.dfr := true.B
      }
    }
  }
}
