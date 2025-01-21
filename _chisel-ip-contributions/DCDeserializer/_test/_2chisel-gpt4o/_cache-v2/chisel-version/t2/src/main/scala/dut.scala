import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles required to assemble one full data structure
  val dataTypeWidth = data.getWidth
  val cycles = (dataTypeWidth + width - 1) / width

  // Register to keep count of which cycle we are currently on
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  // Vector register to hold all segments of the serialized data
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  // Boolean register to indicate when output data is valid
  val dataValid = RegInit(false.B)

  // Default: Data out is not valid, input is not ready
  io.dataOut.valid := dataValid
  io.dataIn.ready := !dataValid

  // On incoming valid data, store it and update cycle count
  when(io.dataIn.fire()) {
    dataSelect(cycleCount) := io.dataIn.bits
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid := true.B
    } .otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // When data has been consumed (dataOut is valid and ready)
  when(io.dataOut.fire()) {
    dataValid := false.B
  }

  // Assemble the output bits from accumulated segments and cast to original Data type
  io.dataOut.bits := dataSelect.asTypeOf(data)
}

