// package memory

import chisel3._
import chisel3.util._

// Chisel implementation of a parameterizable dual-port memory
class dut(
  operationMode: String = "DUAL_PORT",
  addrWidth: Int = 14,
  dataWidth: Int = 32,
  depth: Int = 16384,
  outputMode: String = "REG",
  initFile: String = "NONE"
) extends Module {
  val io = IO(new Bundle {
    // Port A interface
    val portAClk = Input(Clock())
    val portAEna = Input(Bool())
    val portAWe = Input(Bool())
    val portAAddr = Input(UInt(addrWidth.W))
    val portADataIn = Input(UInt(dataWidth.W))
    val portADataOut = Output(UInt(dataWidth.W))

    // Port B interface
    val portBClk = Input(Clock())
    val portBEna = Input(Bool())
    val portBWe = Input(Bool())
    val portBAddr = Input(UInt(addrWidth.W))
    val portBDataIn = Input(UInt(dataWidth.W))
    val portBDataOut = Output(UInt(dataWidth.W))
  })

  // Memory array
  val mem = SyncReadMem(depth, UInt(dataWidth.W))

  // Port A logic
  val portALogic = withClock(io.portAClk) {
    Module(new PortLogic(addrWidth, dataWidth, depth, outputMode))
  }

  portALogic.io.ena := io.portAEna
  portALogic.io.we := io.portAWe
  portALogic.io.addr := io.portAAddr
  portALogic.io.dataIn := io.portADataIn
  io.portADataOut := portALogic.io.dataOut

  // Port B logic
  val portBLogic = withClock(io.portBClk) {
    Module(new PortLogic(addrWidth, dataWidth, depth, outputMode))
  }

  portBLogic.io.ena := io.portBEna
  portBLogic.io.we := io.portBWe
  portBLogic.io.addr := io.portBAddr
  portBLogic.io.dataIn := io.portBDataIn
  io.portBDataOut := portBLogic.io.dataOut

  // Memory operations
  // When operating in DUAL_PORT mode, both ports can access memory independently
  if (operationMode == "DUAL_PORT") {
    // Port A memory access
    when(io.portAEna) {
      when(io.portAWe) {
        mem.write(io.portAAddr, io.portADataIn)
        portALogic.io.readData := DontCare
      }.otherwise {
        portALogic.io.readData := mem.read(io.portAAddr)
      }
    }.otherwise {
      portALogic.io.readData := DontCare
    }

    // Port B memory access
    when(io.portBEna) {
      when(io.portBWe) {
        mem.write(io.portBAddr, io.portBDataIn)
        portBLogic.io.readData := DontCare
      }.otherwise {
        portBLogic.io.readData := mem.read(io.portBAddr)
      }
    }.otherwise {
      portBLogic.io.readData := DontCare
    }
  } 
  // In SINGLE_PORT mode, only Port A is active
  else if (operationMode == "SINGLE_PORT") {
    // Port A memory access
    when(io.portAEna) {
      when(io.portAWe) {
        mem.write(io.portAAddr, io.portADataIn)
        portALogic.io.readData := DontCare
      }.otherwise {
        portALogic.io.readData := mem.read(io.portAAddr)
      }
    }.otherwise {
      portALogic.io.readData := DontCare
    }

    // Port B is inactive
    portBLogic.io.readData := DontCare
  }
  // Default to BIDIR_DUAL_PORT where both ports can read/write
  else {
    // Port A memory access
    when(io.portAEna) {
      when(io.portAWe) {
        mem.write(io.portAAddr, io.portADataIn)
        portALogic.io.readData := DontCare
      }.otherwise {
        portALogic.io.readData := mem.read(io.portAAddr)
      }
    }.otherwise {
      portALogic.io.readData := DontCare
    }

    // Port B memory access
    when(io.portBEna) {
      when(io.portBWe) {
        mem.write(io.portBAddr, io.portBDataIn)
        portBLogic.io.readData := DontCare
      }.otherwise {
        portBLogic.io.readData := mem.read(io.portBAddr)
      }
    }.otherwise {
      portBLogic.io.readData := DontCare
    }
  }

  // Optional initialization from file
  if (initFile != "NONE") {
    // In a real implementation, you would need to add logic to load
    // memory contents from a file
    println(s"Would initialize memory from file: $initFile")
  }
}

// Port logic to handle registered/unregistered output modes
class PortLogic(addrWidth: Int, dataWidth: Int, depth: Int, outputMode: String) extends Module {
  val io = IO(new Bundle {
    val ena = Input(Bool())
    val we = Input(Bool())
    val addr = Input(UInt(addrWidth.W))
    val dataIn = Input(UInt(dataWidth.W))
    val readData = Input(UInt(dataWidth.W))
    val dataOut = Output(UInt(dataWidth.W))
  })

  // Output logic depends on the output mode
  if (outputMode == "REG") {
    // Registered output
    val dataOutReg = RegInit(0.U(dataWidth.W))
    
    when(io.ena && !io.we) {
      dataOutReg := io.readData
    }
    
    io.dataOut := dataOutReg
  } else {
    // Unregistered/combinational output
    io.dataOut := Mux(io.ena && !io.we, io.readData, 0.U)
  }
}

// Object to make the module instantiable from Scala
object dut {
  def apply(
    operationMode: String = "DUAL_PORT",
    addrWidth: Int = 14,
    dataWidth: Int = 32,
    depth: Int = 16384,
    outputMode: String = "REG",
    initFile: String = "NONE"
  ): dut = {
    new dut(
      operationMode, 
      addrWidth, 
      dataWidth, 
      depth, 
      outputMode, 
      initFile
    )
  }
}
