// package arbiter

import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val r = Input(UInt(3.W))
    val g = Output(UInt(3.W))
  })
  
  // Define the states
  object State extends ChiselEnum {
    val A, B, C, D = Value
  }
  
  // State register
  val state = RegInit(State.A)
  
  // Default output value
  io.g := 0.U
  
  // State transition logic
  switch(state) {
    is(State.A) {
      when(io.r(0) === 1.U) {
        state := State.B
      }.elsewhen(io.r(1) === 1.U) {
        state := State.C
      }.elsewhen(io.r(2) === 1.U) {
        state := State.D
      }.otherwise {
        state := State.A
      }
    }
    is(State.B) {
      io.g := "b001".U // g0 = 1
      when(io.r(0) === 0.U) {
        state := State.A
      }.otherwise {
        state := State.B
      }
    }
    is(State.C) {
      io.g := "b010".U // g1 = 1
      when(io.r(1) === 0.U) {
        state := State.A
      }.otherwise {
        state := State.C
      }
    }
    is(State.D) {
      io.g := "b100".U // g2 = 1
      when(io.r(2) === 0.U) {
        state := State.A
      }.otherwise {
        state := State.D
      }
    }
  }
}
