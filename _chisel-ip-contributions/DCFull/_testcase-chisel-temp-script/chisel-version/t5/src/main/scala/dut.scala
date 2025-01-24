import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data)) // Input enqueue interface
    val deq = Decoupled(data)         // Output dequeue interface
  })

  // Task 1: Define Module Internal Components
  // Registers to hold data
  val hold_0 = RegInit(0.U.asTypeOf(data))
  val hold_1 = RegInit(0.U.asTypeOf(data))

  // State representation (Idle, s_1_0, s_0_1, s_2_1)
  val sIdle :: s_1_0 :: s_0_1 :: s_2_1 :: Nil = Enum(4)
  val state = RegInit(sIdle)

  // Control signals
  val shift = Wire(Bool())
  val load = Wire(Bool())
  val sendSel = Wire(Bool())
  val push_vld = Wire(Bool())
  val pop_vld = Wire(Bool())

  // Task 2: Implement Control Signal Logic
  push_vld := io.enq.valid && (state === sIdle || state === s_1_0)
  pop_vld := io.deq.ready && (state === s_1_0 || state === s_0_1 || state === s_2_1)
  shift := push_vld && (state === s_1_0 || state === s_0_1)
  load := push_vld && (state === sIdle || state === s_1_0)
  sendSel := state === s_0_1 || state === s_2_1

  // Task 3: FSM State Transition Logic
  switch(state) {
    is(sIdle) {
      when(push_vld && io.deq.ready) {
        state := s_1_0
      }.elsewhen(push_vld) {
        state := s_0_1
      }
    }
    is(s_1_0) {
      when(push_vld && pop_vld) {
        state := s_2_1
      }.elsewhen(push_vld) {
        state := s_0_1
      }.elsewhen(pop_vld) {
        state := sIdle
      }
    }
    is(s_0_1) {
      when(push_vld) {
        state := s_2_1
      }.elsewhen(pop_vld) {
        state := sIdle
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
  io.deq.bits := Mux(sendSel, hold_1, hold_0)

  // Task 6: Interface and Connection Logic
  io.enq.ready := push_vld && (state =/= s_2_1)
  io.deq.valid := pop_vld && (state =/= sIdle)
}

