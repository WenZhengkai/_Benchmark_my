// package dut

import chisel3._
import chisel3.util._

class DualPortRam(
  operationMode: String = "DUAL_PORT",
  addrWidth: Int = 14,
  dataWidth: Int = 32,
  depth: Int = 16384,
  outputMode: String = "REG"
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
  
  // Registered outputs (if needed)
  val portaDataOutReg = RegInit(0.U(dataWidth.W))
  val portbDataOutReg = RegInit(0.U(dataWidth.W))
  
  // Port A logic
  withClock(io.portaclk) {
    when(io.portaena) {
      when(io.portawe) {
        // Write operation
        mem.write(io.portaaddr, io.portadatain)
      }.otherwise {
        // Read operation
        if (outputMode == "REG") {
          portaDataOutReg := mem.read(io.portaaddr)
        }
      }
    }
  }
  
  // Port B logic - only used in DUAL_PORT mode
  if (operationMode == "DUAL_PORT") {
    withClock(io.portbclk) {
      when(io.portbena) {
        when(io.portbwe) {
          // Write operation
          mem.write(io.portbaddr, io.portbdatain)
        }.otherwise {
          // Read operation
          if (outputMode == "REG") {
            portbDataOutReg := mem.read(io.portbaddr)
          }
        }
      }
    }
  }
  
  // Connect outputs based on output mode
  if (outputMode == "REG") {
    io.portadataout := portaDataOutReg
    io.portbdataout := portbDataOutReg
  } else { // "UNREG" mode
    io.portadataout := mem.read(io.portaaddr)
    if (operationMode == "DUAL_PORT") {
      io.portbdataout := mem.read(io.portbaddr)
    } else {
      io.portbdataout := 0.U // Not used in SINGLE_PORT mode
    }
  }
}

// Factory object for module instantiation
object DualPortRam {
  def apply(
    operationMode: String = "DUAL_PORT",
    addrWidth: Int = 14,
    dataWidth: Int = 32,
    depth: Int = 16384,
    outputMode: String = "REG"
  ): DualPortRam = new DualPortRam(
    operationMode = operationMode,
    addrWidth = addrWidth,
    dataWidth = dataWidth,
    depth = depth,
    outputMode = outputMode
  )
}

// Top-level module that instantiates the DualPortRam with the specified parameters
class dut extends Module {
  val io = IO(new Bundle {
    // Port A
    val portaena = Input(Bool())
    val portawe = Input(Bool())
    val portaaddr = Input(UInt(14.W))
    val portadatain = Input(UInt(32.W))
    val portadataout = Output(UInt(32.W))
    
    // Port B
    val portbena = Input(Bool())
    val portbwe = Input(Bool())
    val portbaddr = Input(UInt(14.W))
    val portbdatain = Input(UInt(32.W))
    val portbdataout = Output(UInt(32.W))
  })

  // Instantiate the dual-port RAM
  val ram = Module(DualPortRam(
    operationMode = "DUAL_PORT",
    addrWidth = 14,
    dataWidth = 32,
    depth = 16384,
    outputMode = "REG"
  ))
  
  // Connect top-level ports to RAM module
  ram.io.portaclk := clock
  ram.io.portaena := io.portaena
  ram.io.portawe := io.portawe
  ram.io.portaaddr := io.portaaddr
  ram.io.portadatain := io.portadatain
  io.portadataout := ram.io.portadataout
  
  ram.io.portbclk := clock
  ram.io.portbena := io.portbena
  ram.io.portbwe := io.portbwe
  ram.io.portbaddr := io.portbaddr
  ram.io.portbdatain := io.portbdatain
  io.portbdataout := ram.io.portbdataout
}

// Use this object for generating Verilog
/*
object dutGenerator extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut, args)
}
*/
