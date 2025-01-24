import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Define registers for data storage
  val hold_0 = RegInit(0.U.asTypeOf(data))
  val hold_1 = RegInit(0.U.asTypeOf(data))

  // Control signals
  val push_vld = Wire(Bool())
  val pop_vld = Wire(Bool())
  val shift = Wire(Bool())
  val load = Wire(Bool())
  val sendSel = Wire(Bool())

  // Finite State Machine (FSM) states
  val s_0_0 :: s_1_0 :: s_0_1 :: s_2_1 :: Nil = Enum(4)
  val state = RegInit(s_0_0)

  // Task 2: Control Signal Logic
  push_vld := io.enq.valid && io.enq.ready
  pop_vld := io.deq.valid && io.deq.ready

  shift := (state === s_1_0 && pop_vld) || (state === s_2_1 && pop_vld)
  load := state === s_0_0 && push_vld

  io.enq.ready := state === s_0_0 || state === s_1_0
  io.deq.valid := state === s_1_0 || state === s_0_1 || state === s_2_1

  // Task 3: FSM State Transition Logic
  switch(state) {
    is(s_0_0) {
      when(push_vld) {
        state := s_1_0
      }
    }
    is(s_1_0) {
      when(push_vld && pop_vld) {
        state := s_1_0
      }.elsewhen(push_vld) {
        state := s_2_1
      }.elsewhen(pop_vld) {
        state := s_0_0
      }
    }
    is(s_0_1) {
      when(push_vld && pop_vld) {
        state := s_0_1
      }.elsewhen(push_vld) {
        state := s_1_0
      }.elsewhen(pop_vld) {
        state := s_0_0
      }
    }
    is(s_2_1) {
      when(pop_vld) {
        state := s_1_0
      }
    }
  }

  // Task 4: Data Holding and Transition Logic
  when(load) {
    hold_1 := io.enq.bits
  }
  when(shift) {
    hold_0 := hold_1
  }

  // Task 5: Output Data Muxing Logic
  sendSel := (state === s_0_1) || (state === s_2_1)
  io.deq.bits := Mux(sendSel, hold_1, hold_0)
}

// This code snippet integrates all tasks outlined in your specification document.
// To test and execute this design, further integration with a testbench is required.
