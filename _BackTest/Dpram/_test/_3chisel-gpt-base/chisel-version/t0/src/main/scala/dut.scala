import chisel3._
import chisel3.util._

class dut(
    operationMode: String = "DUAL_PORT",
    addrWidth: Int = 14,
    dataWidth: Int = 32,
    depth: Int = 16384,
    outputMode: String = "REG",
    lpmFile: String = "NONE",
    ramBlock: Int = 65535
) extends Module {
  val io = IO(new Bundle {
    val portawe      = Input(Bool())
    val portbwe      = Input(Bool())
    val portaena     = Input(Bool())
    val portbena     = Input(Bool())
    val portaclk     = Input(Clock())
    val portbclk     = Input(Clock())
    val portadatain  = Input(UInt(dataWidth.W))
    val portbdatain  = Input(UInt(dataWidth.W))
    val portaaddr    = Input(UInt(addrWidth.W))
    val portbaddr    = Input(UInt(addrWidth.W))
    val portadataout = Output(UInt(dataWidth.W))
    val portbdataout = Output(UInt(dataWidth.W))
  })

  // Internal memory array definition
  val memory = SyncReadMem(depth, UInt(dataWidth.W))

  // Output register signals (for "REG" mode)
  val portaDataReg = RegInit(0.U(dataWidth.W))
  val portbDataReg = RegInit(0.U(dataWidth.W))

  // Read/write logic for Port A
  withClock(io.portaclk) {
    when(io.portaena) {
      when(io.portawe) {
        // Write operation
        memory.write(io.portaaddr, io.portadatain)
      }.otherwise {
        // Read operation
        if (outputMode == "REG") {
          portaDataReg := memory.read(io.portaaddr, io.portaena)
        }
      }
    }
  }

  // Read/write logic for Port B
  withClock(io.portbclk) {
    when(io.portbena) {
      when(io.portbwe) {
        // Write operation
        memory.write(io.portbaddr, io.portbdatain)
      }.otherwise {
        // Read operation
        if (outputMode == "REG") {
          portbDataReg := memory.read(io.portbaddr, io.portbena)
        }
      }
    }
  }

  // Determine output based on output mode
  io.portadataout := Mux(outputMode == "REG", portaDataReg, memory.read(io.portaaddr, io.portaena))
  io.portbdataout := Mux(outputMode == "REG", portbDataReg, memory.read(io.portbaddr, io.portbena))
}

/*
object AltExcDpramDriver extends App {
  chisel3.Driver.execute(args, () => new AltExcDpram())
}
*/
