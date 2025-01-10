import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(DecoupledIO(data))
    val deq = DecoupledIO(data)
  })

  // State Definitions
  val s_0_0 :: s_1_0 :: s_0_1 :: s_2_1 :: Nil = Enum(4)
  val state = RegInit(s_0_0)

  // Registers to hold data
  val hold_0 = Reg(data.cloneType)
  val hold_1 = Reg(data.cloneType)

  // Control Signals
  val push_vld = io.enq.valid && io.enq.ready
  val pop_vld = io.deq.valid && io.deq.ready
  val shift = Wire(Bool())
  val load = Wire(Bool())
  val sendSel = Wire(Bool())

  // Default control signal assignments
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
        state := s_1_0 // continue in the same state
        shift := true.B
        load := true.B
      } .elsewhen(push_vld) {
        state := s_2_1
        load := true.B
      } .elsewhen(pop_vld) {
        state := s_0_0
      }
    }
    is(s_0_1) {
      when(push_vld && pop_vld) {
        state := s_1_0
        shift := true.B
        load := true.B
      } .elsewhen(push_vld) {
        state := s_2_1
        shift := true.B
        load := true.B
      } .elsewhen(pop_vld) {
        state := s_0_0
        shift := true.B
      }
    }
    is(s_2_1) {
      when(pop_vld) {
        state := s_1_0
        shift := true.B
      }
    }
  }

  // Shift and Load Data
  when(shift) {
    hold_0 := hold_1
  }
  when(load) {
    hold_1 := io.enq.bits
  }

  // Select output data
  sendSel := (state === s_0_1 || state === s_2_1)

  // Connect to I/O
  io.enq.ready := (state =/= s_2_1)
  io.deq.valid := (state === s_1_0 || state === s_0_1 || state === s_2_1)
  io.deq.bits := Mux(sendSel, hold_1, hold_0)
}


