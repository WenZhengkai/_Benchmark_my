// package memory

import chisel3._
import chisel3.util._

class DualPortRam(
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
  
  // Memory storage
  val memory = SyncReadMem(depth, UInt(dataWidth.W))
  
  // Port A logic - memory read/write
  val portaClockDomain = withClock(io.portaclk) {
    val addrReg = RegNext(io.portaaddr)
    val portaDataOut = Wire(UInt(dataWidth.W))
    
    when (io.portaena) {
      when (io.portawe) {
        memory.write(io.portaaddr, io.portadatain)
        // If in registered output mode, we still need to read the old value
        if (outputMode == "REG") {
          portaDataOut := memory.read(io.portaaddr)
        } else {
          portaDataOut := DontCare
        }
      } .otherwise {
        portaDataOut := memory.read(io.portaaddr)
      }
    } .otherwise {
      portaDataOut := DontCare
    }
    
    // Output registration logic
    val portaOutput = if (outputMode == "REG") {
      val outReg = RegNext(portaDataOut)
      val enableReg = RegNext(io.portaena)
      Mux(enableReg, outReg, 0.U)
    } else {
      portaDataOut
    }
    
    portaOutput
  }
  
  // Port B logic - memory read/write
  val portbClockDomain = withClock(io.portbclk) {
    val addrReg = RegNext(io.portbaddr)
    val portbDataOut = Wire(UInt(dataWidth.W))
    
    when (io.portbena) {
      when (io.portbwe) {
        if (operationMode == "DUAL_PORT") {
          memory.write(io.portbaddr, io.portbdatain)
        }
        // If in registered output mode, we still need to read the old value
        if (outputMode == "REG") {
          portbDataOut := memory.read(io.portbaddr)
        } else {
          portbDataOut := DontCare
        }
      } .otherwise {
        portbDataOut := memory.read(io.portbaddr)
      }
    } .otherwise {
      portbDataOut := DontCare
    }
    
    // Output registration logic
    val portbOutput = if (outputMode == "REG") {
      val outReg = RegNext(portbDataOut)
      val enableReg = RegNext(io.portbena)
      Mux(enableReg, outReg, 0.U)
    } else {
      portbDataOut
    }
    
    portbOutput
  }
  
  // Connect outputs
  io.portadataout := portaClockDomain
  io.portbdataout := portbClockDomain
}

// A wrapped version with the specified 'dut' module name
class dut(
  val operationMode: String = "DUAL_PORT",
  val addrWidth: Int = 14,
  val dataWidth: Int = 32,
  val depth: Int = 16384,
  val ramblock: Int = 65535,
  val outputMode: String = "REG",
  val lpmFile: String = "NONE",
  val lpmType: String = "alt_exc_dpram",
  val lpmHint: String = "UNUSED"
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
  
  // Instantiate the dual port RAM implementation
  val dpram = Module(new DualPortRam(
    operationMode = operationMode,
    addrWidth = addrWidth,
    dataWidth = dataWidth,
    depth = depth,
    outputMode = outputMode,
    lpmFile = lpmFile
  ))
  
  // Connect all ports
  dpram.io.portaclk := io.portaclk
  dpram.io.portaena := io.portaena
  dpram.io.portawe := io.portawe
  dpram.io.portaaddr := io.portaaddr
  dpram.io.portadatain := io.portadatain
  io.portadataout := dpram.io.portadataout
  
  dpram.io.portbclk := io.portbclk
  dpram.io.portbena := io.portbena
  dpram.io.portbwe := io.portbwe
  dpram.io.portbaddr := io.portbaddr
  dpram.io.portbdatain := io.portbdatain
  io.portbdataout := dpram.io.portbdataout
}

// An object for generating Verilog
/*
object DualPortRamDriver extends App {
  chisel3.Driver.execute(args, () => new dut())
}
*/
