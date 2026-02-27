import chisel3._
import chisel3.util._

class dut(
    operationMode: String = "DUAL_PORT", // Either "DUAL_PORT" or other modes
    addrWidth: Int = 14,
    dataWidth: Int = 32,
    depth: Int = 16384,
    outputMode: String = "REG"          // Either "REG" or "UNREG"
) extends Module {
  val io = IO(new Bundle {
    // Port A Signals
    val portaWE = Input(Bool())
    val portaEn = Input(Bool())
    val portaClk = Input(Clock())
    val portaAddr = Input(UInt(addrWidth.W))
    val portaDataIn = Input(UInt(dataWidth.W))
    val portaDataOut = Output(UInt(dataWidth.W))

    // Port B Signals
    val portbWE = Input(Bool())
    val portbEn = Input(Bool())
    val portbClk = Input(Clock())
    val portbAddr = Input(UInt(addrWidth.W))
    val portbDataIn = Input(UInt(dataWidth.W))
    val portbDataOut = Output(UInt(dataWidth.W))
  })

  // Define memory (dual-port RAM): depth x dataWidth
  val dpram = SyncReadMem(depth, UInt(dataWidth.W))

  // Output registers for port A and port B (used if outputMode is "REG")
  val portARegOut = RegInit(0.U(dataWidth.W))
  val portBRegOut = RegInit(0.U(dataWidth.W))

  // Port A (Write/Read logic)
  withClock(io.portaClk) {
    when(io.portaWE && io.portaEn) { // Write enable for Port A
      dpram.write(io.portaAddr, io.portaDataIn)
    }

    val portaReadData = Wire(UInt(dataWidth.W))
    portaReadData := 0.U

    when(io.portaEn) { // Read enable for Port A
      portaReadData := dpram.read(io.portaAddr, !io.portaWE)
    }

    // Output based on output mode
    if (outputMode == "REG") {
      portARegOut := portaReadData
      io.portaDataOut := portARegOut
    } else { // "UNREG"
      io.portaDataOut := portaReadData
    }
  }

  // Port B (Write/Read logic)
  withClock(io.portbClk) {
    when(io.portbWE && io.portbEn) { // Write enable for Port B
      dpram.write(io.portbAddr, io.portbDataIn)
    }

    val portbReadData = Wire(UInt(dataWidth.W))
    portbReadData := 0.U

    when(io.portbEn) { // Read enable for Port B
      portbReadData := dpram.read(io.portbAddr, !io.portbWE)
    }

    // Output based on output mode
    if (outputMode == "REG") {
      portBRegOut := portbReadData
      io.portbDataOut := portBRegOut
    } else { // "UNREG"
      io.portbDataOut := portbReadData
    }
  }
}

/*
object AltExcDPRAM extends App {
  // Generates Verilog hardware description from the Chisel design
  (new chisel3.stage.ChiselStage).emitVerilog(new AltExcDPRAM())
}
*/
