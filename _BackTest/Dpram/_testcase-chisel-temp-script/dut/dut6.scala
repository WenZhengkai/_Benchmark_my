// package memory

import chisel3._
import chisel3.util._

class dut(
  val addrWidth: Int = 14,
  val dataWidth: Int = 32,
  val depth: Int = 16384,
  val outputReg: Boolean = true,
  val operationMode: String = "DUAL_PORT"
) extends Module {
  val io = IO(new Bundle {
    // Port A
    val portAEnable = Input(Bool())
    val portAWrite = Input(Bool())
    val portAAddr = Input(UInt(addrWidth.W))
    val portADataIn = Input(UInt(dataWidth.W))
    val portADataOut = Output(UInt(dataWidth.W))
    
    // Port B
    val portBEnable = Input(Bool())
    val portBWrite = Input(Bool())
    val portBAddr = Input(UInt(addrWidth.W))
    val portBDataIn = Input(UInt(dataWidth.W))
    val portBDataOut = Output(UInt(dataWidth.W))
  })

  // Memory array
  val mem = SyncReadMem(depth, UInt(dataWidth.W))
  
  // Port A registered outputs
  val portADataOutReg = RegInit(0.U(dataWidth.W))
  
  // Port B registered outputs
  val portBDataOutReg = RegInit(0.U(dataWidth.W))
  
  // Port A logic
  when(io.portAEnable) {
    when(io.portAWrite) {
      // Write operation
      mem.write(io.portAAddr, io.portADataIn)
      // Read-during-write behavior
      if(outputReg) {
        portADataOutReg := DontCare
      }
    }.otherwise {
      // Read operation
      val readData = mem.read(io.portAAddr)
      if(outputReg) {
        portADataOutReg := readData
      } else {
        io.portADataOut := readData
      }
    }
  }
  
  // Port B logic - only active in dual port mode
  if (operationMode == "DUAL_PORT") {
    when(io.portBEnable) {
      when(io.portBWrite) {
        // Write operation
        mem.write(io.portBAddr, io.portBDataIn)
        // Read-during-write behavior
        if(outputReg) {
          portBDataOutReg := DontCare
        }
      }.otherwise {
        // Read operation
        val readData = mem.read(io.portBAddr)
        if(outputReg) {
          portBDataOutReg := readData
        } else {
          io.portBDataOut := readData
        }
      }
    }
  } else {
    // In single port mode, port B outputs are driven to 0
    io.portBDataOut := 0.U
  }
  
  // Connect outputs based on output mode configuration
  if(outputReg) {
    io.portADataOut := portADataOutReg
    io.portBDataOut := portBDataOutReg
  }
  
  // Handle read/write collision detection (when both ports try to access the same address)
  // This is a simplified approach; in real applications, you might need more sophisticated collision handling
  when(io.portAEnable && io.portBEnable && io.portAAddr === io.portBAddr && 
       (io.portAWrite || io.portBWrite)) {
    printf("Warning: Potential read/write collision detected at address %d\n", io.portAAddr)
  }
}

// Usage example
/*
object DualPortRAMMain extends App {
  chisel3.Driver.execute(args, () => new dut(
    addrWidth = 10,
    dataWidth = 32,
    depth = 1024,
    outputReg = true,
    operationMode = "DUAL_PORT"
  ))
}
*/
