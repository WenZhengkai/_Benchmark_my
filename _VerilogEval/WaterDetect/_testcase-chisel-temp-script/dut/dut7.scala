import chisel3._
import chisel3.util._

class WaterReservoirController extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))  // 3 sensors, s[3], s[2], s[1]
    val reset = Input(Bool()) // Active-high synchronous reset
    val fr3 = Output(Bool())  // Flow rate control valves
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())  // Supplemental flow valve
  })

  // Define the possible states of the water level
  val sAbove3      = 0.U(2.W)  // Water level above s[3]
  val sBetween32   = 1.U(2.W)  // Water level between s[3] and s[2]
  val sBetween21   = 2.U(2.W)  // Water level between s[2] and s[1]
  val sBelow1      = 3.U(2.W)  // Water level below s[1]

  // State register for current water level
  val waterLevel = RegInit(sBelow1)
  
  // Register to track previous water level (before the last sensor change)
  val prevWaterLevel = RegInit(sBelow1)

  // Default values for outputs
  io.fr1 := false.B
  io.fr2 := false.B
  io.fr3 := false.B
  io.dfr := false.B

  // Convert input sensors to a format we can use for state transitions
  // Note: In Chisel, we access bits using () not [], and they're 0-indexed
  val s1 = io.s(0)  // Lowest sensor
  val s2 = io.s(1)  // Middle sensor
  val s3 = io.s(2)  // Highest sensor

  // Determine the current water level based on sensor inputs
  val newWaterLevel = Wire(UInt(2.W))
  
  when(s3) {
    newWaterLevel := sAbove3      // All sensors are on (s1, s2, s3)
  }.elsewhen(s2) {
    newWaterLevel := sBetween32   // Only s1 and s2 are on
  }.elsewhen(s1) {
    newWaterLevel := sBetween21   // Only s1 is on
  }.otherwise {
    newWaterLevel := sBelow1      // No sensors are on
  }

  // Update state only when the water level changes
  when(io.reset) {
    waterLevel := sBelow1
    prevWaterLevel := sBelow1
  }.elsewhen(newWaterLevel =/= waterLevel) {
    prevWaterLevel := waterLevel
    waterLevel := newWaterLevel
  }

  // Set flow rate outputs based on current water level
  switch(waterLevel) {
    is(sAbove3) {
      // No flow needed when water level is above s[3]
    }
    is(sBetween32) {
      io.fr1 := true.B
    }
    is(sBetween21) {
      io.fr1 := true.B
      io.fr2 := true.B
    }
    is(sBelow1) {
      io.fr1 := true.B
      io.fr2 := true.B
      io.fr3 := true.B
    }
  }

  // Set supplemental flow valve (dfr) if water level is rising
  io.dfr := waterLevel < prevWaterLevel

  // Override when reset is asserted (as if water level had been low for a long time)
  when(io.reset) {
    io.fr1 := true.B
    io.fr2 := true.B
    io.fr3 := true.B
    io.dfr := true.B
  }
}

// Generate Verilog for the module named "dut"
/*
object dutGenerator extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new WaterReservoirController, Array("--target-dir", "generated", "--target", "systemverilog", "--module-name", "dut"))
}
*/
