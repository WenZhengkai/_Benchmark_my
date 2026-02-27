// package altExcDPRAM

import chisel3._
import chisel3.util._

/** Dual-port RAM Module Configurations */
class dut(
    addrWidth: Int = 14,
    dataWidth: Int = 32,
    depth: Int = 16384,
    operationMode: String = "DUAL_PORT",
    outputMode: String = "REG"
) extends Module {
  require(depth == (1 << addrWidth), s"Depth must match 2^addrWidth")

  val io = IO(new Bundle {
    // Input control signals for Port A
    val portaWe       = Input(Bool())          // Write enable for Port A
    val portaEn       = Input(Bool())          // Enable signal for Port A
    val portAClk      = Input(Clock())         // Clock for Port A
    val portaDataIn   = Input(UInt(dataWidth.W)) // Data input for Port A
    val portaAddr     = Input(UInt(addrWidth.W)) // Address input for Port A

    // Input control signals for Port B
    val portbWe       = Input(Bool())          // Write enable for Port B
    val portbEn       = Input(Bool())          // Enable signal for Port B
    val portBClk      = Input(Clock())         // Clock for Port B
    val portbDataIn   = Input(UInt(dataWidth.W)) // Data input for Port B
    val portbAddr     = Input(UInt(addrWidth.W)) // Address input for Port B

    // Output data for Port A and Port B
    val portaDataOut  = Output(UInt(dataWidth.W))
    val portbDataOut  = Output(UInt(dataWidth.W))
  })

  // Define the memory storage using SyncReadMem for dual-port functionality
  val dpram = SyncReadMem(depth, UInt(dataWidth.W))

  // Port A Output Register for Registered Mode
  val portaDataOutReg = RegInit(0.U(dataWidth.W))

  // Port B Output Register for Registered Mode
  val portbDataOutReg = RegInit(0.U(dataWidth.W))

  // Clock domains for Port A and Port B
  withClock(io.portAClk) {
    when(io.portaEn) {
      when(io.portaWe) {
        // Write operation for Port A
        dpram.write(io.portaAddr, io.portaDataIn)
      }.otherwise {
        // Read operation for Port A
        val readData = dpram.read(io.portaAddr, io.portaEn)
        if (outputMode == "REG") {
          portaDataOutReg := readData
        } else {
          io.portaDataOut := readData
        }
      }
    }
  }

  withClock(io.portBClk) {
    when(io.portbEn) {
      when(io.portbWe) {
        // Write operation for Port B
        dpram.write(io.portbAddr, io.portbDataIn)
      }.otherwise {
        // Read operation for Port B
        val readData = dpram.read(io.portbAddr, io.portbEn)
        if (outputMode == "REG") {
          portbDataOutReg := readData
        } else {
          io.portbDataOut := readData
        }
      }
    }
  }

  // Assign outputs based on output mode
  io.portaDataOut := Mux(outputMode == "REG".U, portaDataOutReg, dpram.read(io.portaAddr, io.portaEn))
  io.portbDataOut := Mux(outputMode == "REG".U, portbDataOutReg, dpram.read(io.portbAddr, io.portbEn))
}
