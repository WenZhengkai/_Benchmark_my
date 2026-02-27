import chisel3._
import chisel3.util._

class WaterReservoirController extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))
    val reset = Input(Bool())
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
  })

  // Define states
  val sAboveS3 :: sBetweenS3S2 :: sBetweenS2S1 :: sBelowS1 :: Nil = Enum(4)
  
  // State register
  val state = RegInit(sBelowS1)
  
  // Previous state register (for detecting direction of water level change)
  val prevState = RegInit(sBelowS1)
  
  // Logic to determine current sensor state
  val currentSensorState = Wire(UInt(2.W))
  
  when(io.s === "b111".U) {
    currentSensorState := sAboveS3
  }.elsewhen(io.s === "b011".U) {
    currentSensorState := sBetweenS3S2
  }.elsewhen(io.s === "b001".U) {
    currentSensorState := sBetweenS2S1
  }.otherwise {
    currentSensorState := sBelowS1
  }
  
  // State transition logic
  when(io.reset) {
    state := sBelowS1
    prevState := sBelowS1
  }.otherwise {
    when(state =/= currentSensorState) {
      prevState := state
      state := currentSensorState
    }
  }
  
  // Output logic
  io.fr1 := (state === sBetweenS3S2) || (state === sBetweenS2S1) || (state === sBelowS1)
  io.fr2 := (state === sBetweenS2S1) || (state === sBelowS1)
  io.fr3 := (state === sBelowS1)
  
  // Supplemental flow valve logic
  // Opens when water level is rising (current state is higher than previous state)
  io.dfr := (state > prevState) || (state === sBelowS1)
}

// Module instantiation for the top-level
class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))
    val fr3 = Output(Bool())
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())
  })
  
  val controller = Module(new WaterReservoirController())
  
  // Connect inputs
  controller.io.s := io.s
  controller.io.reset := reset
  
  // Connect outputs
  io.fr1 := controller.io.fr1
  io.fr2 := controller.io.fr2
  io.fr3 := controller.io.fr3
  io.dfr := controller.io.dfr
}
