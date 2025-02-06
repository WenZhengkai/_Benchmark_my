import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs, n, must be at least 2.")
  
  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Step 1: Initialization
  val aInt = VecInit(io.a.map(DCInput(_)))
  val zInt = Wire(Decoupled(data.cloneType))
  zInt.bits := aInt(0).bits // Initialize with first element
  
  // Step 2: Logic Computation
  val all_valid = aInt.map(_.valid).reduce(_ && _)

  when(all_valid) {
    val result = aInt.map(_.bits).reduce(op)
    zInt.bits := result
    zInt.valid := true.B
    aInt.foreach(_.ready := zInt.ready)
  }.otherwise {
    zInt.valid := false.B
    aInt.foreach(_.ready := false.B)
  }

  // Step 3: Output Control
  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}

// Example usage
// Note: Provide appropriate binary function and data type.
// val mod = Module(new DCReduce(UInt(8.W), 4, (a: UInt, b: UInt) => a + b))
