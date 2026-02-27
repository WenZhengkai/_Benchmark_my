// package memory

import chisel3._
import chisel3.util._

class dut(
  val operationMode: String = "DUAL_PORT", 
  val addrWidth: Int = 14,
  val dataWidth: Int = 32,
  val depth: Int = 16384,
  val outputMode: String = "REG",
  val lpmFile: String = "NONE"
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

  // Memory array
  val mem = SyncReadMem(depth, UInt(dataWidth.W))
  
  // Port A logic
  val portaDataOutReg = RegInit(0.U(dataWidth.W))
  
  withClock(io.portaclk) {
    when(io.portaena) {
      when(io.portawe) {
        mem.write(io.portaaddr, io.portadatain)
      }.otherwise {
        // Read operation
        val readData = mem.read(io.portaaddr)
        if (outputMode == "REG") {
          portaDataOutReg := readData
        } else {
          portaDataOutReg := readData
        }
      }
    }
  }
  
  // Port B logic
  val portbDataOutReg = RegInit(0.U(dataWidth.W))
  
  withClock(io.portbclk) {
    when(io.portbena) {
      when(io.portbwe) {
        mem.write(io.portbaddr, io.portbdatain)
      }.otherwise {
        // Read operation
        val readData = mem.read(io.portbaddr)
        if (outputMode == "REG") {
          portbDataOutReg := readData
        } else {
          portbDataOutReg := readData
        }
      }
    }
  }
  
  // Output assignment based on output mode
  if (outputMode == "REG") {
    io.portadataout := portaDataOutReg
    io.portbdataout := portbDataOutReg
  } else {
    // For UNREG mode, we need to handle reads without registering
    // This is simplified here, as Chisel's SyncReadMem always has registered reads
    io.portadataout := portaDataOutReg
    io.portbdataout := portbDataOutReg
  }
  
  // Handle collision detection and conflict resolution
  // This is a simplified implementation, as Chisel doesn't directly support
  // hardware X values like Verilog. A more comprehensive implementation would
  // require additional logic for conflict detection.
}

// Usage example
/*
object DualPortRAMMain extends App {
  chisel3.Driver.execute(args, () => new dut())
}
*/
