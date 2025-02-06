import chisel3._
import chisel3.util._
import chisel.lib.dclib._

class dut[D <: Data](data: D, n: Int, op: (D, D) => D) extends Module {
  require(n >= 2, "The number of inputs should be at least 2")

  val io = IO(new Bundle {
    val a = Vec(n, Flipped(Decoupled(data.cloneType)))
    val z = Decoupled(data.cloneType)
  })

  // Initialize internal structures
  val aInt = VecInit(io.a.map(DCInput(_)))
  val zInt = Wire(Decoupled(data.cloneType))

  // Logic computation
  val allValid = aInt.map(_.valid).reduce(_ && _)
  val readyForAll = Wire(Bool())

  // Reduction operation
  val reducedValue = aInt.map(_.bits).reduce(op)
  zInt.bits := reducedValue

  // Output control
  zInt.valid := allValid && io.z.ready
  readyForAll := zInt.ready && allValid

  aInt.zipWithIndex.foreach { case (a, i) =>
    a.ready := readyForAll
  }

  val zDcout = DCOutput(zInt)
  io.z <> zDcout
}

// Example usage:
// val myReduceModule = Module(new DCReduce(UInt(8.W), 4, (a: UInt, b: UInt) => a + b))
