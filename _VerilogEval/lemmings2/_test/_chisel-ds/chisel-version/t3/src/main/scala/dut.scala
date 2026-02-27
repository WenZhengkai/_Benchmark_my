import chisel3._
import chisel3.util._

class LemmingsFSM extends Module {
  val io = IO(new Bundle {
    val bump_left = Input(Bool())
    val bump_right = Input(Bool())
    val ground = Input(Bool())
    val walk_left = Output(Bool())
    val walk_right = Output(Bool())
    val aaah = Output(Bool())
  })

  // Define states for the FSM
  val sWalkLeft :: sWalkRight :: sFalling :: Nil = Enum(3)

  // State register
  val stateReg = RegInit(sWalkLeft)

  // Outputs
  io.walk_left := stateReg === sWalkLeft
  io.walk_right := stateReg === sWalkRight
  io.aaah := stateReg === sFalling

  // FSM logic
  switch(stateReg) {
    is(sWalkLeft) {
      when(!io.ground) {
        stateReg := sFalling
      }.elsewhen(io.bump_left) {
        stateReg := sWalkRight
      }
    }
    is(sWalkRight) {
      when(!io.ground) {
        stateReg := sFalling
      }.elsewhen(io.bump_right) {
        stateReg := sWalkLeft
      }
    }
    is(sFalling) {
      when(io.ground) {
        stateReg := Mux(io.walk_left, sWalkLeft, sWalkRight)
      }
    }
  }

  // Handle reset
  when(reset.asBool) {
    stateReg := sWalkLeft
  }
}

/*
object LemmingsFSM extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new LemmingsFSM(), Array("--target-dir", "generated"))
}
*/
