import chisel3._
import chisel3.util._

class dut(
    val operation_mode: String = "DUAL_PORT",
    val addrWidth: Int = 14,
    val dataWidth: Int = 32,
    val depth: Int = 16384,
    val outputMode: String = "REG" // "REG" or "UNREG"
) extends Module {
  val io = IO(new Bundle {
    // Port A
    val portawe = Input(Bool()) // Write Enable
    val portaena = Input(Bool()) // Port Enable
    val portaclk = Input(Clock()) // Clock
    val portadatain = Input(UInt(dataWidth.W)) // Data In
    val portaaddr = Input(UInt(addrWidth.W)) // Address In
    val portadataout = Output(UInt(dataWidth.W)) // Data Out

    // Port B
    val portbwe = Input(Bool()) // Write Enable
    val portbena = Input(Bool()) // Port Enable
    val portbclk = Input(Clock()) // Clock
    val portbdatain = Input(UInt(dataWidth.W)) // Data In
    val portbaddr = Input(UInt(addrWidth.W)) // Address In
    val portbdataout = Output(UInt(dataWidth.W)) // Data Out
  })

  require(depth <= Math.pow(2, addrWidth).toInt, "Depth exceeds addressable range for given addrWidth")
  val memory = SyncReadMem(depth, UInt(dataWidth.W)) // Dual-port synchronous SRAM.

  // Port A logic
  val portaDataReg = RegInit(0.U(dataWidth.W)) // Registered output for Port A
  val portaReadData = WireDefault(0.U(dataWidth.W)) // Temporary wire for read data

  withClock(io.portaclk) {
    when(io.portawe && io.portaena) {
      // Write Operation for Port A
      memory.write(io.portaaddr, io.portadatain)
    } .otherwise {
      // Read Operation for Port A
      if (operation_mode == "DUAL_PORT") {
        portaReadData := memory.read(io.portaaddr, io.portaena)
      }
    }

    if (outputMode == "REG") {
      portaDataReg := portaReadData // Registered output
    }
  }

  io.portadataout := Mux(outputMode == "REG".B, portaDataReg, portaReadData)

  // Port B logic
  val portbDataReg = RegInit(0.U(dataWidth.W)) // Registered output for Port B
  val portbReadData = WireDefault(0.U(dataWidth.W)) // Temporary wire for read data

  withClock(io.portbclk) {
    when(io.portbwe && io.portbena) {
      // Write Operation for Port B
      memory.write(io.portbaddr, io.portbdatain)
    } .otherwise {
      // Read Operation for Port B
      if (operation_mode == "DUAL_PORT") {
        portbReadData := memory.read(io.portbaddr, io.portbena)
      }
    }

    if (outputMode == "REG") {
      portbDataReg := portbReadData // Registered output
    }
  }

  io.portbdataout := Mux(outputMode == "REG".B, portbDataReg, portbReadData)
}

/*
object AltExcDPRAM extends App {
  chisel3.Driver.execute(args, () => new AltExcDPRAM())
}
*/
