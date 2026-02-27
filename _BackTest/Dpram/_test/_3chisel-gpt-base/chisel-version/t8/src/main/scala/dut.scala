import chisel3._
import chisel3.util._

/** alt_exc_dpram module in Chisel */
class dut(val addrWidth: Int = 14,
                  val dataWidth: Int = 32,
                  val depth: Int = 16384,
                  val outputMode: String = "REG",
                  val operationMode: String = "DUAL_PORT") extends Module {

  // Define I/O
  val io = IO(new Bundle {
    // Inputs
    val portawe     = Input(Bool())                      // Write Enable A
    val portbwe     = Input(Bool())                      // Write Enable B
    val portaena    = Input(Bool())                      // Enable A
    val portbena    = Input(Bool())                      // Enable B
    val portaclk    = Input(Clock())                     // Clock A
    val portbclk    = Input(Clock())                     // Clock B
    val portadatain = Input(UInt(dataWidth.W))           // Data Input A
    val portbdatain = Input(UInt(dataWidth.W))           // Data Input B
    val portaaddr   = Input(UInt(addrWidth.W))           // Address A
    val portbaddr   = Input(UInt(addrWidth.W))           // Address B

    // Outputs
    val portadataout = Output(UInt(dataWidth.W))         // Data Output A
    val portbdataout = Output(UInt(dataWidth.W))         // Data Output B
  })

  // Memory Declaration: Create a RAM block based on the `depth` and `dataWidth` parameters
  val dpram = SyncReadMem(depth, UInt(dataWidth.W)) // Dual-port, synchronous RAM

  // Internal Registers for holding data
  val portadataoutReg = RegInit(0.U(dataWidth.W))
  val portbdataoutReg = RegInit(0.U(dataWidth.W))

  // Read Logic for Port A
  val readDataA = Wire(UInt(dataWidth.W))
  readDataA := dpram.read(io.portaaddr, io.portaena) // Conditional read

  // Read Logic for Port B
  val readDataB = Wire(UInt(dataWidth.W))
  readDataB := dpram.read(io.portbaddr, io.portbena) // Conditional read

  // Write Logic for Port A
  withClock(io.portaclk) {
    when(io.portaena && io.portawe) {
      dpram.write(io.portaaddr, io.portadatain) // Write data to memory
    }
  }

  // Write Logic for Port B
  withClock(io.portbclk) {
    when(io.portbena && io.portbwe) {
      dpram.write(io.portbaddr, io.portbdatain) // Write data to memory
    }
  }

  // Handle Output Based on `outputMode` Parameter
  if (outputMode == "REG") {
    // Registered output mode
    withClock(io.portaclk) {
      portadataoutReg := readDataA
    }
    withClock(io.portbclk) {
      portbdataoutReg := readDataB
    }
    io.portadataout := portadataoutReg
    io.portbdataout := portbdataoutReg
  } else {
    // Unregistered output mode
    io.portadataout := readDataA
    io.portbdataout := readDataB
  }
}

/*
object AltExcDPRAMDriver extends App {
  // Generate the Verilog
  chisel3.Driver.execute(args, () => new AltExcDPRAM())
}
*/
