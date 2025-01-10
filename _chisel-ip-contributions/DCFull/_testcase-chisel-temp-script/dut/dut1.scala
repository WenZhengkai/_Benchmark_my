import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(dataType))
    val deq = Decoupled(dataType)
  })

  // State definitions
  val s_0_0 :: s_1_0 :: s_0_1 :: s_2_1 :: Nil = Enum(4)
  val state = RegInit(s_0_0)

  // Registers to hold data
  val hold_0 = Reg(dataType)
  val hold_1 = Reg(dataType)

  // Default assignments
  io.deq.valid := false.B
  io.deq.bits := DontCare
  io.enq.ready := false.B

  // Control signals
  val shift = Wire(Bool())
  val load = Wire(Bool())
  val sendSel = Wire(Bool())

  // State machine logic with transitions
  switch(state) {
    is(s_0_0) {
      io.enq.ready := true.B
      when(io.enq.fire()) {
        hold_1 := io.enq.bits
        state := s_1_0
      }
    }
    is(s_1_0) {
      io.deq.valid := true.B
      io.deq.bits := hold_1
      when(io.deq.ready) {
        state := s_0_0
      }
      when(io.enq.fire() && io.deq.ready) {
        hold_1 := io.enq.bits
        state := s_1_0
      }.elsewhen(io.enq.fire()) {
        hold_0 := hold_1
        hold_1 := io.enq.bits
        state := s_2_1
      }
    }
    is(s_0_1) {
      io.deq.valid := true.B
      io.deq.bits := hold_0
      when(io.deq.fire()) {
        state := s_0_0
      }.elsewhen(io.enq.fire()) {
        hold_1 := io.enq.bits
        state := s_1_0
      }
    }
    is(s_2_1) {
      io.deq.valid := true.B
      io.deq.bits := hold_0
      when(io.deq.fire() && !io.enq.fire()) {
        hold_0 := hold_1
        state := s_0_1
      }.elsewhen(io.deq.fire() && io.enq.fire()) {
        hold_0 := hold_1
        hold_1 := io.enq.bits
        state := s_2_1
      }
    }
  }
}


