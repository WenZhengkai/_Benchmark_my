import chisel3._
import chisel3.util._

class dut(
  operationMode: String = "DUAL_PORT",
  addrWidth: Int = 14,
  dataWidth: Int = 32,
  depth: Int = 16384,
  outputMode: String = "REG"
) extends Module {

  val io = IO(new Bundle {
    // Inputs
    val portawe     = Input(Bool())
    val portbwe     = Input(Bool())
    val portaena    = Input(Bool())
    val portbena    = Input(Bool())
    val portaclk    = Input(Clock())
    val portbclk    = Input(Clock())
    val portadatain = Input(UInt(dataWidth.W))
    val portbdatain = Input(UInt(dataWidth.W))
    val portaaddr   = Input(UInt(addrWidth.W))
    val portbaddr   = Input(UInt(addrWidth.W))

    // Outputs
    val portadataout = Output(UInt(dataWidth.W))
    val portbdataout = Output(UInt(dataWidth.W))
  })

  // Memory array for dual-port RAM
  val dpramContent = SyncReadMem(depth, UInt(dataWidth.W))

  // Registered outputs (for REG output mode)
  val portaDataReg = RegInit(0.U(dataWidth.W))
  val portbDataReg = RegInit(0.U(dataWidth.W))

  // Temporary signals for combinational output behavior
  val portaDataTmp = WireDefault(0.U(dataWidth.W))
  val portbDataTmp = WireDefault(0.U(dataWidth.W))

  // Write and Read Operations for Port A
  withClockAndReset(io.portaclk, reset.asBool) {
    when(io.portawe && io.portaena) {
      // Write operation for Port A
      dpramContent.write(io.portaaddr, io.portadatain)
    }

    when(!io.portawe && io.portaena) {
      // Read operation for Port A
      portaDataTmp := dpramContent.read(io.portaaddr, io.portaena)
    }

    // Registered output mode for Port A
    when(outputMode == "REG".U) {
      when(io.portaena) {
        portaDataReg := portaDataTmp
      }
      io.portadataout := portaDataReg
    }.otherwise {
      io.portadataout := portaDataTmp
    }
  }

  // Write and Read Operations for Port B
  withClockAndReset(io.portbclk, reset.asBool) {
    when(io.portbwe && io.portbena) {
      // Write operation for Port B
      dpramContent.write(io.portbaddr, io.portbdatain)
    }

    when(!io.portbwe && io.portbena) {
      // Read operation for Port B
      portbDataTmp := dpramContent.read(io.portbaddr, io.portbena)
    }

    // Registered output mode for Port B
    when(outputMode == "REG".U) {
      when(io.portbena) {
        portbDataReg := portbDataTmp
      }
      io.portbdataout := portbDataReg
    }.otherwise {
      io.portbdataout := portbDataTmp
    }
  }
}

/*
object AltExcDpram extends App {
  chisel3.Driver.execute(args, () => new AltExcDpram(
    operationMode = "DUAL_PORT",
    addrWidth = 14,
    dataWidth = 32,
    depth = 16384,
    outputMode = "REG"
  ))
}
*/
