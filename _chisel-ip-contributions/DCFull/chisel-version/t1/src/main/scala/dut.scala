import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data)) // Enqueue interface (input)
    val deq = Decoupled(data)         // Dequeue interface (output)
  })

  // Internal Registers
  val hold_0     = RegInit(0.U.asTypeOf(data)) // Data Register 0
  val hold_1     = RegInit(0.U.asTypeOf(data)) // Data Register 1
  val state      = RegInit(0.U(2.W))           // State Register

  // State Definitions
  val s_0_0 = 0.U // Empty
  val s_1_0 = 1.U // One entry (hold_0 filled)
  val s_0_1 = 2.U // One entry (hold_1 filled)
  val s_2_1 = 3.U // Two entries (both hold_0 and hold_1 filled)

  // Control Signals
  val push_vld = io.enq.valid
  val pop_vld  = io.deq.ready
  val shift    = Wire(Bool())
  val load     = Wire(Bool())
  val sendSel  = Wire(Bool()) // Selector for output driving from hold_0 or hold_1

  // Control Signal Logic
  shift := (state === s_2_1 && pop_vld) || (state === s_1_0 && pop_vld)
  load  := (state === s_0_0 && push_vld) ||
           (state === s_1_0 && push_vld) ||
           (state === s_0_1 && push_vld && pop_vld) // simultaneous load and pop
  sendSel := state === s_0_1 || state === s_2_1

  // Finite State Machine (FSM) Logic
  switch(state) {
    is(s_0_0) {
      when(push_vld) { state := s_1_0 }
    }
    is(s_1_0) {
      when(push_vld && pop_vld) { state := s_1_0 }
        .elsewhen(push_vld)      { state := s_2_1 }
        .elsewhen(pop_vld)       { state := s_0_0 }
    }
    is(s_0_1) {
      when(push_vld && pop_vld) { state := s_1_0 }
        .elsewhen(push_vld)      { state := s_2_1 }
        .elsewhen(pop_vld)       { state := s_0_0 }
    }
    is(s_2_1) {
      when(pop_vld) { state := s_0_1 }
    }
  }

  // Data Handling Logic
  when(load) {
    when(state === s_0_0) {
      hold_0 := io.enq.bits
    }.elsewhen(state === s_1_0 && push_vld) {
      hold_1 := io.enq.bits
    }.elsewhen(state === s_0_1 && push_vld && pop_vld) {
      hold_0 := hold_1
      hold_1 := io.enq.bits
    }
  }

  when(shift) {
    hold_0 := hold_1
  }

  // Output Logic
  io.deq.bits  := Mux(sendSel, hold_1, hold_0)
  io.deq.valid := state === s_1_0 || state === s_0_1 || state === s_2_1
  io.enq.ready := state === s_0_0 || state === s_1_0 || state === s_0_1

  // Debugging (Optional)
  // printf(p"State: $state, EnqReady: ${io.enq.ready}, DeqValid: ${io.deq.valid}\n")
}
