// Dual-Port RAM implementation in Chisel

// package dut

import chisel3._
import chisel3.util._
import chisel3.experimental.{ChiselEnum, annotate}
import chisel3.stage.ChiselStage

class dut(
  val addrWidth: Int = 14,
  val dataWidth: Int = 32,
  val depth: Int = 16384,
  val operationMode: String = "DUAL_PORT", // "SINGLE_PORT" or "DUAL_PORT"
  val outputMode: String = "REG",          // "REG" or "UNREG"
  val initFile: Option[String] = None
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
  
  // Optional initialization from file
  if (initFile.isDefined) {
    loadMemoryFromFile(mem, initFile.get, depth)
  }
  
  // Port A logic
  val portADataOutReg = RegInit(0.U(dataWidth.W))
  
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
  
  // Port B logic (only used in DUAL_PORT mode)
  val portBDataOutReg = RegInit(0.U(dataWidth.W))
  
  if (operationMode == "DUAL_PORT") {
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
  }
  
  // Output assignments based on output mode
  if (outputMode == "REG") {
    io.portADataOut := portADataOutReg
    io.portBDataOut := portBDataOutReg
  } else { // UNREG mode
    io.portADataOut := Mux(io.portAEna && !io.portAWe, mem.read(io.portAAddr), 0.U)
    if (operationMode == "DUAL_PORT") {
      io.portBDataOut := Mux(io.portBEna && !io.portBWe, mem.read(io.portBAddr), 0.U)
    } else {
      io.portBDataOut := 0.U
    }
  }
  
  // Helper function to load memory from a file (if needed)
  def loadMemoryFromFile(mem: SyncReadMem[UInt], fileName: String, depth: Int): Unit = {
    // This would need to be implemented with appropriate file loading
    // In real implementation, you might use something like:
    // val loadMem = VecInit(loadMemoryFromFileIntoVec(fileName, depth))
    // for (i <- 0 until depth) {
    //   mem.write(i.U, loadMem(i))
    // }
  }
}

// Example object to generate Verilog
/*
object DualPortRAMVerilog extends App {
  (new ChiselStage).emitVerilog(
    new dut(
      addrWidth = 14,
      dataWidth = 32,
      depth = 16384,
      operationMode = "DUAL_PORT",
      outputMode = "REG"
    ),
    Array("--target-dir", "generated")
  )
}
*/
