import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(dataType))  // Input interface for enqueue
    val deq = Decoupled(dataType)           // Output interface for dequeue
  })

  // Define the states for the FSM
  val s_0_0 :: s_1_0 :: s_0_1 :: s_2_1 :: Nil = Enum(4)

  // State register
  val state = RegInit(s_0_0)

  // Data holding registers
  val hold_0 = Reg(dataType)
  val hold_1 = Reg(dataType)

  // Control signals
  val shift = Wire(Bool())
  val load = Wire(Bool())
  val sendSel = Wire(Bool())

  // Determine valid states for push and pop operations
  val push_vld = io.enq.valid && io.enq.ready
  val pop_vld  = io.deq.valid && io.deq.ready

  // Default control signal values
  shift := false.B
  load := false.B
  sendSel := false.B

  // State machine logic
  switch(state) {
    is(s_0_0) {
      when(push_vld) {
        state := s_1_0
        load := true.B
      }
    }
    is(s_1_0) {
      when(push_vld && pop_vld) {
        state := s_1_0
        load := true.B
        shift := true.B
      }.elsewhen(push_vld) {
        state := s_2_1
        load := true.B
      }.elsewhen(pop_vld) {
        state := s_0_1
        shift := true.B
      }
    }
    is(s_0_1) {
      when(push_vld && pop_vld) {
        state := s_1_0
        load := true.B
        shift := true.B
      }.elsewhen(push_vld) {
        state := s_2_1
        load := true.B
      }.elsewhen(pop_vld) {
        state := s_0_0
      }
    }
    is(s_2_1) {
      when(pop_vld) {
        state := s_1_0
        shift := true.B
      }
    }
  }

  // Data handling logic
  when(load) {
    hold_0 := io.enq.bits
  }
  when(shift) {
    hold_1 := hold_0
  }

  // Output data muxing based on sendSel
  io.deq.bits := Mux(sendSel, hold_1, hold_0)

  // Determining which slot's data should be sent
  sendSel := (state === s_0_1 || state === s_2_1)
  
  // Ready/Valid logic for enq and deq
  io.enq.ready := state =/= s_2_1
  io.deq.valid := state =/= s_0_0
}

