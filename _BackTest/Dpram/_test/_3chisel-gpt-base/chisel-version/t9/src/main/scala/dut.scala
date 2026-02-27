import chisel3._
import chisel3.util._

class dut(
  addrWidth: Int = 14,
  dataWidth: Int = 32,
  depth: Int = 16384,
  operationMode: String = "DUAL_PORT", // Either "SINGLE_PORT" or "DUAL_PORT"
  outputMode: String = "REG"          // Either "REG" or "UNREG"
) extends Module {
  val io = IO(new Bundle {
    // Port A
    val portaWe       = Input(Bool()) // Write enable for Port A
    val portaEn       = Input(Bool()) // Enable for Port A
    val portaClk      = Input(Clock()) // Clock for Port A
    val portaDataIn   = Input(UInt(dataWidth.W)) // Data input for Port A
    val portaAddr     = Input(UInt(addrWidth.W)) // Address input for Port A
    val portaDataOut  = Output(UInt(dataWidth.W)) // Data output for Port A

    // Port B
    val portbWe       = Input(Bool()) // Write enable for Port B
    val portbEn       = Input(Bool()) // Enable for Port B
    val portbClk      = Input(Clock()) // Clock for Port B
    val portbDataIn   = Input(UInt(dataWidth.W)) // Data input for Port B
    val portbAddr     = Input(UInt(addrWidth.W)) // Address input for Port B
    val portbDataOut  = Output(UInt(dataWidth.W)) // Data output for Port B
  })

  // Memory Storage (Depth x DataWidth)
  val ram = SyncReadMem(depth, UInt(dataWidth.W))

  // #####################
  // Port A Logic
  // #####################
  val portaDataOutReg = RegInit(0.U(dataWidth.W)) // Register for Port A output
  withClock(io.portaClk) {
    when(io.portaEn) {
      when(io.portaWe) {
        ram.write(io.portaAddr, io.portaDataIn) // Write operation
      }.otherwise {
        portaDataOutReg := ram.read(io.portaAddr, io.portaEn) // Read operation
      }
    }
  }
  // Output selection based on output mode
  io.portaDataOut := Mux(outputMode == "REG".U, portaDataOutReg, ram.read(io.portaAddr, io.portaEn))

  // #####################
  // Port B Logic
  // #####################
  val portbDataOutReg = RegInit(0.U(dataWidth.W)) // Register for Port B output
  withClock(io.portbClk) {
    when(io.portbEn) {
      when(io.portbWe) {
        ram.write(io.portbAddr, io.portbDataIn) // Write operation
      }.otherwise {
        portbDataOutReg := ram.read(io.portbAddr, io.portbEn) // Read operation
      }
    }
  }
  // Output selection based on output mode
  io.portbDataOut := Mux(outputMode == "REG".U, portbDataOutReg, ram.read(io.portbAddr, io.portbEn))

  // #####################
  // Write-Write Conflict Handling
  // #####################
  // In a dual-port configuration, we need to detect and handle simultaneous writes to the same address.
  if (operationMode == "DUAL_PORT") {
    when(io.portaWe && io.portbWe && io.portaAddr === io.portbAddr) {
      // Simultaneous write to the same address leads to undefined behavior
      // You can force the memory to an 'X' or handle it as per your requirements
      printf("Warning: Write-write conflict at address %d\n", io.portaAddr)
    }
  }
}

/*
object GenerateAltExcDPRAM extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new AltExcDPRAM())
}
*/
