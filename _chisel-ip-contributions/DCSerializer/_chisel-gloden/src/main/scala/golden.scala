import chisel3._
import chisel3.util._

/**
  * Takes a Chisel datatype and serializes it across a channel of "W" bits.
  * The incoming transaction is not buffered, and will be acknowledged once
  * the entire serialized stream is sent.
  *
  * @param data  Data structure to be sent
  * @param width Width of the serialized channel
  * @tparam D
  * 
  */
class DCSerializer[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data.cloneType))
    val dataOut = Decoupled(UInt(width.W))
  })

  val cycles = if (data.getWidth % width != 0) data.getWidth / width + 1 else data.getWidth / width
  require(cycles > 1)

  val cycleCount = RegInit(init = 0.U(log2Ceil(cycles).W))
  val dataSelect = Wire(Vec(cycles, UInt(width.W)))

  dataSelect := io.dataIn.bits.asTypeOf(dataSelect)

  io.dataOut.bits := dataSelect(cycleCount)
  io.dataOut.valid := io.dataIn.valid
  io.dataIn.ready := io.dataOut.ready & (cycleCount === (cycles - 1).U)

  when(io.dataIn.fire) {
    cycleCount := 0.U

  }.elsewhen(io.dataOut.fire) {
    cycleCount := cycleCount + 1.U
    
  }
}

object Driver extends App {
  println("Generating the DCSerializer hardware")
  emitVerilog(new DCSerializer(UInt(8.W),5), Array("--target-dir", "generated"))
}