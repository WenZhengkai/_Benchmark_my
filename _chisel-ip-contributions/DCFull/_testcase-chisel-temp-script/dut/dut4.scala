import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Task 1: Define Module Internal Components
  // Registers to hold data
  val hold_0 = Reg(data)
  val hold_1 = Reg(data)

  // FSM state definitions
  val s_0_0 :: s_1_0 :: s_0_1 :: s_2_1 :: Nil = Enum(4)
  val state = RegInit(s_0_0)

  // Control signals
  val shift = Wire(Bool())
  val load = Wire(Bool())
  val sendSel = Wire(Bool())
  val push_vld = Wire(Bool())
  val pop_vld = Wire(Bool())

  // Task 2: Implement Control Signal Logic
  // Calculate push and pop validity based on enqueue and dequeue interfaces
  push_vld := io.enq.valid && io.enq.ready
  pop_vld := io.deq.valid && io.deq.ready

  // Determine shift and load signals based on state and IO readiness
  shift := (state === s_1_0 && push_vld) || (state === s_2_1 && pop_vld)
  load := io.enq.valid && (state === s_0_0 || state === s_1_0 || (state === s_0_1 && !pop_vld))

  // Task 3: FSM State Transition Logic
  // Define state transitions
  switch(state) {
    is(s_0_0) {
      when(push_vld) {
        state := s_1_0
      }
    }
    is(s_1_0) {
      when(push_vld && !pop_vld) {
        state := s_2_1
      }.elsewhen(pop_vld && !push_vld) {
        state := s_0_1
      }
    }
    is(s_0_1) {
      when(push_vld && !pop_vld) {
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
  // Manage data shifting and loading
  when(load) {
    hold_1 := io.enq.bits
  }
  when(shift) {
    hold_0 := hold_1
  }

  // Task 5: Output Data Muxing Logic
  // Select data to output from hold registers
  sendSel := Mux(state === s_2_1 || state === s_0_1, true.B, false.B)
  io.deq.bits := Mux(sendSel, hold_1, hold_0)

  // Task 6: Interface and Connection Logic
  // Define valid and ready signals
  io.enq.ready := (state === s_0_0 || state === s_0_1 || state === s_1_0)
  io.deq.valid := (state === s_1_0 || state === s_0_1 || state === s_2_1)
}

