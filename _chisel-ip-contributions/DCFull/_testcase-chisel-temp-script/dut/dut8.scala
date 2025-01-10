import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Define states
  val s_0_0 :: s_1_0 :: s_0_1 :: s_2_1 :: Nil = Enum(4)
  val stateReg = RegInit(s_0_0)

  // Data holding registers
  val hold_0 = Reg(data.cloneType)
  val hold_1 = Reg(data.cloneType)

  // Control signals
  val shift = WireDefault(false.B)
  val load = WireDefault(false.B)
  val sendSel = WireDefault(false.B)
  
  // Enqueue and Dequeue valid signals
  val push_vld = io.enq.valid && io.enq.ready
  val pop_vld = io.deq.valid && io.deq.ready

  // State machine logic
  switch(stateReg) {
    is(s_0_0) {
      when(push_vld) {
        load := true.B
        stateReg := s_1_0
      }
    }
    is(s_1_0) {
      when(push_vld && pop_vld) {
        shift := true.B
        load := true.B
      }.elsewhen(push_vld) {
        load := true.B
        stateReg := s_2_1
      }.elsewhen(pop_vld) {
        shift := true.B
        stateReg := s_0_0
      }
    }
    is(s_0_1) {
      when(push_vld && pop_vld) {
        load := true.B
      }.elsewhen(push_vld) {
        load := true.B
        stateReg := s_2_1
      }.elsewhen(pop_vld) {
        stateReg := s_0_0
      }
    }
    is(s_2_1) {
      when(pop_vld) {
        shift := true.B
        stateReg := s_1_0
      }
    }
  }

  // Data moves between the registers and the enq/deq interface
  when(shift) {
    hold_0 := hold_1
  }
  when(load) {
    hold_1 := io.enq.bits
  }

  // Output selection logic
  sendSel := (stateReg === s_1_0) || (stateReg === s_2_1)
  io.deq.bits := Mux(sendSel, hold_0, hold_1)

  // Dequeue valid logic
  io.deq.valid := (stateReg === s_1_0) || (stateReg === s_0_1) || (stateReg === s_2_1)
  // Enqueue ready logic
  io.enq.ready := (stateReg === s_0_0) || (stateReg === s_0_1)
}

