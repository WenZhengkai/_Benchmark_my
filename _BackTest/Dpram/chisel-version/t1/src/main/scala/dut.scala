// package memory

import chisel3._
import chisel3.util._

class dut(
  val operationMode: String = "DUAL_PORT",
  val addrWidth: Int = 14,
  val dataWidth: Int = 32,
  val depth: Int = 16384,
  val outputMode: String = "REG"
) extends Module {
  val io = IO(new Bundle {
    // Port A
    val portAClk = Input(Clock())
    val portAEna = Input(Bool())
    val portAWe = Input(Bool())
    val portAAddr = Input(UInt(addrWidth.W))
    val portADataIn = Input(UInt(dataWidth.W))
    val portADataOut = Output(UInt(dataWidth.W))
    
    // Port B
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
  val portADataOutReg = withClock(io.portAClk) {
    RegInit(0.U(dataWidth.W))
  }
  
  withClock(io.portAClk) {
    when(io.portAEna) {
      when(io.portAWe) {
        mem.write(io.portAAddr, io.portADataIn)
      }.otherwise {
        when(outputMode == "REG") {
          portADataOutReg := mem.read(io.portAAddr)
        }
      }
    }
  }
  
  // Port B logic
  val portBDataOutReg = withClock(io.portBClk) {
    RegInit(0.U(dataWidth.W))
  }
  
  withClock(io.portBClk) {
    when(io.portBEna) {
      when(io.portBWe) {
        mem.write(io.portBAddr, io.portBDataIn)
      }.otherwise {
        when(outputMode == "REG") {
          portBDataOutReg := mem.read(io.portBAddr)
        }
      }
    }
  }
  
  // Handle read-during-write behavior and output mode
  val portADataOutWire = Wire(UInt(dataWidth.W))
  val portBDataOutWire = Wire(UInt(dataWidth.W))
  
  if (outputMode == "REG") {
    portADataOutWire := portADataOutReg
    portBDataOutWire := portBDataOutReg
  } else {
    // For UNREG mode, directly connect to the memory read
    withClock(io.portAClk) {
      portADataOutWire := Mux(io.portAEna && !io.portAWe, mem.read(io.portAAddr), 0.U)
    }
    withClock(io.portBClk) {
      portBDataOutWire := Mux(io.portBEna && !io.portBWe, mem.read(io.portBAddr), 0.U)
    }
  }
  
  // Connect outputs
  io.portADataOut := portADataOutWire
  io.portBDataOut := portBDataOutWire
  
  // Handle operation mode restrictions
  if (operationMode == "SINGLE_PORT") {
    // In single port mode, port B is not used
    io.portBDataOut := DontCare
  }
}

// Object to make the module instantiatable from Scala
object dut {
  def apply(
    operationMode: String = "DUAL_PORT",
    addrWidth: Int = 14,
    dataWidth: Int = 32,
    depth: Int = 16384,
    outputMode: String = "REG"
  ): dut = {
    new dut(operationMode, addrWidth, dataWidth, depth, outputMode)
  }
}
