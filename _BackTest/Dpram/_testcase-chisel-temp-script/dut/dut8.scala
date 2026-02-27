// package memory

import chisel3._
import chisel3.util._

class dut(
  val addrWidth: Int = 14,
  val dataWidth: Int = 32,
  val depth: Int = 16384,
  val operationMode: String = "DUAL_PORT",
  val outputMode: String = "REG"
) extends Module {
  val io = IO(new Bundle {
    // Port A
    val portaclk = Input(Clock())
    val portaena = Input(Bool())
    val portawe = Input(Bool())
    val portaaddr = Input(UInt(addrWidth.W))
    val portadatain = Input(UInt(dataWidth.W))
    val portadataout = Output(UInt(dataWidth.W))
    
    // Port B
    val portbclk = Input(Clock())
    val portbena = Input(Bool())
    val portbwe = Input(Bool())
    val portbaddr = Input(UInt(addrWidth.W))
    val portbdatain = Input(UInt(dataWidth.W))
    val portbdataout = Output(UInt(dataWidth.W))
  })

  // Create memory
  val mem = SyncReadMem(depth, UInt(dataWidth.W))
  
  // Port A logic
  val portaClockDomain = withClock(io.portaclk) {
    val portaDataOut = RegInit(0.U(dataWidth.W))
    
    when(io.portaena) {
      when(io.portawe) {
        // Write operation
        mem.write(io.portaaddr, io.portadatain)
      }.otherwise {
        // Read operation
        val readData = mem.read(io.portaaddr)
        if (outputMode == "REG") {
          portaDataOut := readData
        } else {
          portaDataOut := readData
        }
      }
    }
    
    portaDataOut
  }
  
  // Port B logic
  val portbClockDomain = withClock(io.portbclk) {
    val portbDataOut = RegInit(0.U(dataWidth.W))
    
    when(io.portbena) {
      when(io.portbwe) {
        // Write operation
        mem.write(io.portbaddr, io.portbdatain)
      }.otherwise {
        // Read operation
        val readData = mem.read(io.portbaddr)
        if (outputMode == "REG") {
          portbDataOut := readData
        } else {
          portbDataOut := readData
        }
      }
    }
    
    portbDataOut
  }
  
  // Connect outputs
  io.portadataout := portaClockDomain
  io.portbdataout := portbClockDomain
  
  // Check for invalid configurations
  if (operationMode != "DUAL_PORT" && operationMode != "SINGLE_PORT") {
    throw new Exception("Invalid operation mode. Must be DUAL_PORT or SINGLE_PORT")
  }
  
  if (outputMode != "REG" && outputMode != "UNREG") {
    throw new Exception("Invalid output mode. Must be REG or UNREG")
  }
  
  // For single port mode, ensure that B port is properly handled
  if (operationMode == "SINGLE_PORT") {
    assert(!(io.portbena && io.portbwe), "In SINGLE_PORT mode, port B cannot write to memory")
  }
}

// A more configurable version with additional parameters
class ConfigurableDualPortRAM(
  val addrWidth: Int = 14,
  val dataWidth: Int = 32,
  val depth: Int = 16384,
  val ramblock: Int = 65535,
  val operationMode: String = "DUAL_PORT",
  val outputMode: String = "REG",
  val lpmFile: String = "NONE",
  val lpmType: String = "alt_exc_dpram",
  val lpmHint: String = "UNUSED"
) extends dut(addrWidth, dataWidth, depth, operationMode, outputMode) {
  // This class extends the base dut with additional configuration parameters
  // These parameters are mostly for documentation/compatibility and don't affect functionality
  
  // Optional initialization from a file
  if (lpmFile != "NONE") {
    println(s"Note: Memory initialization from file $lpmFile would be implemented here")
    // In a real implementation, you would add memory initialization logic here
  }
}

// Example of how to instantiate the module
/*
object DualPortRAMMain extends App {
  println("Generating dut Verilog")
  (new chisel3.stage.ChiselStage).emitVerilog(
    new dut(),
    Array("--target-dir", "generated")
  )
}
*/
