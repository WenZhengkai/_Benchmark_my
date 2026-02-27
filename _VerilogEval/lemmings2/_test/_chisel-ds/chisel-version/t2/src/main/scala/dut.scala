import chisel3._
import chisel3.util._

class LemmingsFSM extends Module {
  val io = IO(new Bundle {
    val bump_left  = Input(Bool())
    val bump_right = Input(Bool())
    val ground     = Input(Bool())
    val walk_left  = Output(Bool())
    val walk_right = Output(Bool())
    val aaah       = Output(Bool())
  })

  // Define the states
  val sWalkLeft :: sWalkRight :: sFallLeft :: sFallRight :: Nil = Enum(4)

  // State register with reset to walk left
  val stateReg = RegInit(sWalkLeft)

  // Output logic
  io.walk_left  := stateReg === sWalkLeft || stateReg === sFallLeft
  io.walk_right := stateReg === sWalkRight || stateReg === sFallRight
  io.aaah       := stateReg === sFallLeft || stateReg === sFallRight

  // Next state logic
  switch(stateReg) {
    is(sWalkLeft) {
      when(!io.ground) {
        stateReg := sFallLeft
      }.elsewhen(io.bump_left) {
        stateReg := sWalkRight
      }
    }
    is(sWalkRight) {
      when(!io.ground) {
        stateReg := sFallRight
      }.elsewhen(io.bump_right) {
        stateReg := sWalkLeft
      }
    }
    is(sFallLeft) {
      when(io.ground) {
        stateReg := sWalkLeft
      }
    }
    is(sFallRight) {
      when(io.ground) {
        stateReg := sWalkRight
      }
    }
  }
}

/*
object LemmingsFSM extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new LemmingsFSM(), args)
}
*/
