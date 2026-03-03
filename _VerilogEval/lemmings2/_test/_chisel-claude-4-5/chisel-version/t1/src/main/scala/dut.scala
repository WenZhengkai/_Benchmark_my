import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val bump_left = Input(Bool())
    val bump_right = Input(Bool())
    val ground = Input(Bool())
    val walk_left = Output(Bool())
    val walk_right = Output(Bool())
    val aaah = Output(Bool())
  })

  // Define states
  val sWalkLeft :: sWalkRight :: sFallLeft :: sFallRight :: Nil = Enum(4)
  
  // State register
  val state = RegInit(sWalkLeft)
  
  // Next state logic
  switch(state) {
    is(sWalkLeft) {
      when(!io.ground) {
        state := sFallLeft
      }.elsewhen(io.bump_left) {
        state := sWalkRight
      }.elsewhen(io.bump_right) {
        state := sWalkLeft
      }
    }
    
    is(sWalkRight) {
      when(!io.ground) {
        state := sFallRight
      }.elsewhen(io.bump_right) {
        state := sWalkLeft
      }.elsewhen(io.bump_left) {
        state := sWalkRight
      }
    }
    
    is(sFallLeft) {
      when(io.ground) {
        state := sWalkLeft
      }
    }
    
    is(sFallRight) {
      when(io.ground) {
        state := sWalkRight
      }
    }
  }
  
  // Output logic (Moore machine - outputs depend only on state)
  io.walk_left := (state === sWalkLeft)
  io.walk_right := (state === sWalkRight)
  io.aaah := (state === sFallLeft) || (state === sFallRight)
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
