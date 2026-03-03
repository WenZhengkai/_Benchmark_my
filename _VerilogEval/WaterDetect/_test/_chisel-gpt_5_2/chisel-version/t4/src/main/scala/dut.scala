import chisel3._
import chisel3.util._

/**
  * Water reservoir flow controller
  *
  * Inputs:
  *   s(2:0) corresponds to sensors s[3:1] in the spec:
  *     s(2) = s3 (highest)
  *     s(1) = s2
  *     s(0) = s1 (lowest)
  *
  * Outputs:
  *   fr3, fr2, fr1 : nominal flow valves
  *   dfr           : supplemental flow valve (opened when level rose since last sensor change)
  *
  * Reset (active-high, synchronous):
  *   sets state as if water level had been low for a long time:
  *     no sensors asserted (tracked prevSensors = 0)
  *     all four outputs asserted
  */
class dut extends Module {
  val io = IO(new Bundle {
    val s   = Input(UInt(3.W))  // s[3:1] as {s3,s2,s1} -> io.s(2)=s3, io.s(1)=s2, io.s(0)=s1
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
    val resetSync = Input(Bool()) // active-high synchronous reset
  })

  // Track sensors at last change (to determine whether level rose or fell).
  val prevSensors = RegInit(0.U(3.W))

  val sensorsChanged = io.s =/= prevSensors

  // Update prevSensors only when a change occurs (or on reset).
  when(io.resetSync) {
    prevSensors := 0.U
  }.elsewhen(sensorsChanged) {
    prevSensors := io.s
  }

  // Determine nominal flow based on current sensors asserted.
  // Encoding per spec:
  // 111 -> above s3 -> none
  // 011 -> between s3 and s2 -> fr1
  // 001 -> between s2 and s1 -> fr1, fr2
  // 000 -> below s1 -> fr1, fr2, fr3
  val nominal_fr1 = WireDefault(false.B)
  val nominal_fr2 = WireDefault(false.B)
  val nominal_fr3 = WireDefault(false.B)

  switch(io.s) {
    is("b111".U) { // Above s3
      nominal_fr1 := false.B; nominal_fr2 := false.B; nominal_fr3 := false.B
    }
    is("b011".U) { // Between s3 and s2
      nominal_fr1 := true.B;  nominal_fr2 := false.B; nominal_fr3 := false.B
    }
    is("b001".U) { // Between s2 and s1
      nominal_fr1 := true.B;  nominal_fr2 := true.B;  nominal_fr3 := false.B
    }
    is("b000".U) { // Below s1
      nominal_fr1 := true.B;  nominal_fr2 := true.B;  nominal_fr3 := true.B
    }
    // Any other combination is physically unlikely; choose a safe-ish behavior:
    // treat "more sensors asserted" as "higher water" by using popcount mapping.
    // popcount 3->none, 2->fr1, 1->fr1+fr2, 0->fr1+fr2+fr3
    default {
      val pc = PopCount(io.s)
      nominal_fr1 := pc <= 2.U
      nominal_fr2 := pc <= 1.U
      nominal_fr3 := pc === 0.U
    }
  }

  // Supplemental valve behavior:
  // If the sensor change indicates previous level was lower than current level,
  // open supplemental flow valve (dfr).
  //
  // Since higher level => more sensors asserted, compare number of asserted sensors.
  val prevCount = PopCount(prevSensors)
  val currCount = PopCount(io.s)
  val roseSinceLastChange = sensorsChanged && (currCount > prevCount)

  // Outputs with synchronous reset requirement:
  // reset -> all four outputs asserted.
  when(io.resetSync) {
    io.fr1 := true.B
    io.fr2 := true.B
    io.fr3 := true.B
    io.dfr := true.B
  }.otherwise {
    io.fr1 := nominal_fr1
    io.fr2 := nominal_fr2
    io.fr3 := nominal_fr3
    io.dfr := roseSinceLastChange
  }
}
