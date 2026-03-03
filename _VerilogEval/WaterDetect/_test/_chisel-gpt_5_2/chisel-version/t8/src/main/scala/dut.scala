// SPDX-License-Identifier: Unlicense
// Chisel 3.x

import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s   = Input(UInt(3.W))   // use bits [2:0] for s[3:1] respectively
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
    val rst = Input(Bool())      // active-high synchronous reset
  })

  // Map io.s bits to sensor names (s1 lowest, s3 highest)
  val s1 = io.s(0)
  val s2 = io.s(1)
  val s3 = io.s(2)

  // Encode water level from sensors (assuming physically consistent patterns):
  // 3: above s3  => 111
  // 2: between s3 and s2 => 011
  // 1: between s2 and s1 => 001
  // 0: below s1 => 000
  val level = Wire(UInt(2.W))
  when(s3) {
    level := 3.U
  }.elsewhen(s2) {
    level := 2.U
  }.elsewhen(s1) {
    level := 1.U
  }.otherwise {
    level := 0.U
  }

  // Track previous level to determine direction of last sensor change.
  // On a rising level (prev < curr), open supplemental valve dfr.
  val prevLevel = RegInit(0.U(2.W)) // reset to "below s1 for a long time"
  val rising    = level > prevLevel

  // Update prevLevel synchronously; on reset, force "low for a long time".
  when(io.rst) {
    prevLevel := 0.U
  }.otherwise {
    prevLevel := level
  }

  // Nominal flow outputs based on current level
  val n_fr1 = WireDefault(false.B)
  val n_fr2 = WireDefault(false.B)
  val n_fr3 = WireDefault(false.B)

  switch(level) {
    is(3.U) { // above s3: none
      n_fr1 := false.B; n_fr2 := false.B; n_fr3 := false.B
    }
    is(2.U) { // between s3 and s2: fr1
      n_fr1 := true.B;  n_fr2 := false.B; n_fr3 := false.B
    }
    is(1.U) { // between s2 and s1: fr1, fr2
      n_fr1 := true.B;  n_fr2 := true.B;  n_fr3 := false.B
    }
    is(0.U) { // below s1: fr1, fr2, fr3
      n_fr1 := true.B;  n_fr2 := true.B;  n_fr3 := true.B
    }
  }

  // Outputs: nominal + supplemental (dfr) when last change indicates rising
  // Reset behavior: "no sensors asserted, and all four outputs asserted"
  when(io.rst) {
    io.fr1 := true.B
    io.fr2 := true.B
    io.fr3 := true.B
    io.dfr := true.B
  }.otherwise {
    io.fr1 := n_fr1
    io.fr2 := n_fr2
    io.fr3 := n_fr3
    io.dfr := rising
  }
}
