package example

import chisel3._
import chisel3.util._

/** DCSerializer Module
  *
  * Serializes an arbitrary Chisel data structure (`D <: Data`) into a sequence
  * of output words of fixed width (`W` bits), transmitting them one word at a time.
  *
  * @param data  Chisel data type to be serialized
  * @param width Width in bits of the serialized output channel
  **/
class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be greater than 0")
  require(data.getWidth > width, "Output width (W) must be smaller than input data width")

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(data)) // Input data to serialize
    val dataOut = Decoupled(UInt(width.W)) // Serialized output words
  })

  // Calculate the number of cycles required for serialization
  val dataWidth: Int = data.getWidth
  val cycles: Int = (dataWidth + width - 1) / width // Ceiling of dataWidth / width

  // Internal state
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W)) // Tracks the current serialization cycle
  val active = RegInit(false.B)                     // Tracks if a serialization is currently ongoing
  val buffer = Reg(data.cloneType)                  // Stores the input data during serialization

  io.dataIn.ready := !active && io.dataOut.ready    // Accept new data if idle
  io.dataOut.valid := active                        // Output is valid when actively serializing
  io.dataOut.bits := buffer.asUInt()(width.U * cycleCount + width.U - 1, width.U * cycleCount) // Extract the current word

  when(io.dataIn.fire) {
    // When a new transaction starts:
    buffer := io.dataIn.bits            // Load the input data
    cycleCount := 0.U                   // Reset the cycle counter
    active := true.B                    // Indicate serialization is active
  }

  when(active && io.dataOut.fire) {
    // When a serialized word is sent:
    cycleCount := cycleCount + 1.U      // Advance to the next serialization cycle
    when(cycleCount === (cycles - 1).U) {
      active := false.B                 // End the transaction after all cycles
    }
  }
}

