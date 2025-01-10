import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(dataType)) // Enqueue interface
    val deq = Decoupled(dataType)          // Dequeue interface
  })

  // State Definitions
  val s_0_0 :: s_1_0 :: s_0_1 :: s_2_1 :: Nil = Enum(4)
  val state = RegInit(s_0_0)

  // Registers for holding data
  val hold_0 = Reg(dataType)
  val hold_1 = Reg(dataType)

  // Control Signal Computation
  val shift = (state === s_0_1 && io.deq.ready && io.deq.valid)
  val load = io.enq.valid && (state === s_0_0 || state === s_1_0 || state === s_0_1)
  val sendSel = (state === s_1_0 || state === s_2_1)

  // Output Data Muxing
  io.deq.bits := Mux(sendSel, hold_1, hold_0)

  // Valid and Ready Signals
  io.enq.ready := (state === s_0_0 || state === s_1_0)
  io.deq.valid := (state === s_1_0 || state === s_0_1 || state === s_2_1)

  // State Transition Logic
  switch(state) {
    is(s_0_0) {
      when(load) {
        hold_1 := io.enq.bits
        state := s_0_1
      }
    }
    is(s_1_0) {
      when(io.deq.ready) {
        state := s_0_0
      }
    }
    is(s_0_1) {
      when(io.deq.ready) {
        state := s_1_0
      }.elsewhen(load) {
        hold_0 := hold_1
        hold_1 := io.enq.bits
        state := s_2_1
      }
    }
    is(s_2_1) {
      when(io.deq.ready) {
        hold_0 := hold_1
        state := s_1_0
      }
    }
  }
}

