import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // State definitions
  val s_0_0 :: s_1_0 :: s_0_1 :: s_2_1 :: Nil = Enum(4)
  val state = RegInit(s_0_0)

  // Registers to hold data
  val hold_0 = Reg(data)
  val hold_1 = Reg(data)

  // Control Signals
  val push_vld = io.enq.valid && io.enq.ready
  val pop_vld = io.deq.valid && io.deq.ready
  val sendSel = Wire(Bool())
  val shift = Wire(Bool())
  val load = Wire(Bool())
  
  // Initial assignments
  io.enq.ready := false.B
  io.deq.valid := false.B
  io.deq.bits := Mux(sendSel, hold_1, hold_0)

  // Determine control signals based on state
  switch(state) {
    is(s_0_0) {
      io.enq.ready := true.B
      when(push_vld) {
        state := s_1_0
        hold_0 := io.enq.bits
      }
    }
    is(s_1_0) {
      io.enq.ready := true.B
      io.deq.valid := true.B
      when(push_vld && !pop_vld) {
        state := s_2_1
        hold_1 := io.enq.bits
      }.elsewhen(!push_vld && pop_vld) {
        state := s_0_0
      }.elsewhen(push_vld && pop_vld) {
        state := s_1_0
        hold_0 := io.enq.bits
      }
    }
    is(s_0_1) {
      io.deq.valid := true.B
      when(pop_vld) {
        state := s_0_0
      }
    }
    is(s_2_1) {
      io.deq.valid := true.B
      io.enq.ready := false.B
      when(pop_vld) {
        state := s_0_1
        hold_0 := hold_1
      }
    }
  }
  
  // Determine which data to send
  sendSel := state === s_2_1 || state === s_0_1

  // Update control signals for data management
  load := push_vld && state === s_1_0
  shift := pop_vld && state === s_2_1

  // Load data when needed
  when(load) {
    hold_1 := io.enq.bits
  }

  // Shift data when needed
  when(shift) {
    hold_0 := hold_1
  }
}

