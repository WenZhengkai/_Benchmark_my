// package memory

import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

class dut(
  val addrWidth: Int = 14,
  val dataWidth: Int = 32,
  val depth: Int = 16384,
  val operationMode: String = "DUAL_PORT",
  val outputMode: String = "REG",
  val lpmFile: String = "NONE"
) extends Module {
  
  // Define the IO bundle
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
  
  // Memory storage
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
        // Read operation
        if (outputMode == "REG") {
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
        // Read operation
        if (outputMode == "REG") {
          portBDataOutReg := mem.read(io.portBAddr)
        }
      }
    }
  }
  
  // Output logic based on operation mode and output mode
  if (operationMode == "SINGLE_PORT") {
    // In single port mode, only port A is used
    if (outputMode == "REG") {
      io.portADataOut := portADataOutReg
    } else {
      io.portADataOut := mem.read(io.portAAddr, io.portAEna && !io.portAWe)
    }
    io.portBDataOut := 0.U
  } else {
    // In dual port mode
    if (outputMode == "REG") {
      io.portADataOut := portADataOutReg
      io.portBDataOut := portBDataOutReg
    } else {
      io.portADataOut := mem.read(io.portAAddr, io.portAEna && !io.portAWe)
      io.portBDataOut := mem.read(io.portBAddr, io.portBEna && !io.portBWe)
    }
  }
  
  // Initialize memory from file if specified
  if (lpmFile != "NONE") {
    loadMemoryFromFile(mem, lpmFile)
  }
  
  // Helper method to load memory from file (in a real implementation this would read a file)
  private def loadMemoryFromFile(mem: SyncReadMem[UInt], filename: String): Unit = {
    // This is a placeholder for actual file loading functionality
    // In a real implementation, you would use something like:
    // val lines = scala.io.Source.fromFile(filename).getLines()
    // for ((line, i) <- lines.zipWithIndex) {
    //   mem.write(i.U, line.toInt.U)
    // }
  }
}

// Test harness to demonstrate usage
/*
object DualPortRAMMain extends App {
  chisel3.Driver.execute(args, () => new dut())
}
*/
