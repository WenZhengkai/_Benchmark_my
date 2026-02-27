import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W))     // 3 sensors, s[3] to s[1]
    val reset = Input(Bool())    // Active-high synchronous reset
    val fr3 = Output(Bool())     // Flow rate control signals
    val fr2 = Output(Bool())
    val fr1 = Output(Bool())
    val dfr = Output(Bool())     // Supplemental flow valve
  })

  // Define states to track previous sensor readings
  val sIdle :: sLow :: sMid :: sHigh :: sFull :: Nil = Enum(5)
  val state = RegInit(sLow)      // Initial state (low water level)
  
  // Register to track previous sensor reading for level change detection
  val prevSensors = RegInit(0.U(3.W))
  
  // Default output values
  io.fr1 := false.B
  io.fr2 := false.B
  io.fr3 := false.B
  io.dfr := false.B
  
  // Extract individual sensor bits
  val s1 = io.s(0)  // Lowest sensor
  val s2 = io.s(1)  // Middle sensor
  val s3 = io.s(2)  // Highest sensor
  
  // Determine current water level based on sensors
  val waterLevel = Wire(UInt(3.W))
  when(s1 && s2 && s3) {
    waterLevel := 3.U  // Above s[3]
  }.elsewhen(s1 && s2 && !s3) {
    waterLevel := 2.U  // Between s[3] and s[2]
  }.elsewhen(s1 && !s2 && !s3) {
    waterLevel := 1.U  // Between s[2] and s[1]
  }.otherwise {
    waterLevel := 0.U  // Below s[1]
  }
  
  // Check if water level is rising
  val isRising = waterLevel > prevSensors.asUInt

  // State machine
  when(io.reset) {
    // Reset to low water level state
    state := sLow
    prevSensors := 0.U
    io.fr1 := true.B
    io.fr2 := true.B
    io.fr3 := true.B
    io.dfr := true.B
  }.otherwise {
    // Update previous sensors register
    prevSensors := io.s
    
    // State transitions based on water level
    switch(waterLevel) {
      is(0.U) { state := sLow }   // Below s[1]
      is(1.U) { state := sMid }   // Between s[2] and s[1]
      is(2.U) { state := sHigh }  // Between s[3] and s[2]
      is(3.U) { state := sFull }  // Above s[3]
    }
    
    // Set nominal flow rate based on water level
    switch(state) {
      is(sLow) {
        // Below s[1]: Maximum flow rate
        io.fr1 := true.B
        io.fr2 := true.B
        io.fr3 := true.B
      }
      is(sMid) {
        // Between s[2] and s[1]
        io.fr1 := true.B
        io.fr2 := true.B
        io.fr3 := false.B
      }
      is(sHigh) {
        // Between s[3] and s[2]
        io.fr1 := true.B
        io.fr2 := false.B
        io.fr3 := false.B
      }
      is(sFull) {
        // Above s[3]: No flow
        io.fr1 := false.B
        io.fr2 := false.B
        io.fr3 := false.B
      }
    }
    
    // Set supplemental flow if water level is rising
    io.dfr := isRising
  }
}
