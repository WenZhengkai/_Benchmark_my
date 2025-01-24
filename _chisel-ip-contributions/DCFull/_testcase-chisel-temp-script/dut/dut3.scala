import chisel3._
import chisel3.util._

class dut[D <: Data](data: D) extends Module {
  val io = IO(new Bundle {
    val enq = Flipped(Decoupled(data))
    val deq = Decoupled(data)
  })

  // Define module internal components
  val hold_0 = RegInit(0.U.asTypeOf(data))
  val hold_1 = RegInit(0.U.asTypeOf(data))
  val state = RegInit(0.U(2.W)) // State encoding with 2 bits

  // State Representation
  val s_0_0 :: s_1_0 :: s_0_1 :: s_2_1 :: Nil = Enum(4)
  
  val shift = WireDefault(false.B)
  val load = WireDefault(false.B)
  val sendSel = WireDefault(false.B)
  val push_vld = WireDefault(false.B)
  val pop_vld = WireDefault(false.B)

  // Task 2: Implement Control Signal Logic
  switch(state) {
    is(s_0_0) {
      push_vld := io.enq.valid
      pop_vld := false.B
      when(io.enq.valid && io.deq.ready) {
        shift := true.B
      }
    }
    is(s_1_0) {
      push_vld := io.enq.valid
      pop_vld := io.deq.ready
      when(io.enq.valid) {
        load := true.B
      }
      when(io.deq.ready) {
        shift := true.B
      }
    }
    is(s_0_1) {
      push_vld := false.B
      pop_vld := io.deq.ready
      when(io.deq.ready) {
        shift := true.B
      }
    }
    is(s_2_1) {
      push_vld := false.B
      pop_vld := io.deq.ready
      when(io.deq.ready) {
        load := true.B
      }
    }
  }

  // Task 3: FSM State Transition Logic
  switch(state) {
    is(s_0_0) {
      when(push_vld && io.deq.ready) {
        state := s_1_0
      }
    }
    is(s_1_0) {
      when(push_vld && !io.deq.ready) {
        state := s_2_1
      }.elsewhen(!push_vld && io.deq.ready) {
        state := s_0_1
      }
    }
    is(s_0_1) {
      when(io.deq.ready) {
        state := s_0_0
      }
    }
    is(s_2_1) {
      when(io.deq.ready) {
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

  switch(state) {
    is(s_0_0) {
      io.deq.valid := false.B
      sendSel := false.B
    }
    is(s_1_0) {
      io.deq.valid := true.B
      sendSel := false.B
    }
    is(s_0_1) {
      io.deq.valid := true.B
      sendSel := false.B
    }
    is(s_2_1) {
      io.deq.valid := true.B
      sendSel := true.B
    }
  }

  // Task 6: Interface and Connection Logic
  io.enq.ready := push_vld
}

