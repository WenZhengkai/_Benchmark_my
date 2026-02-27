// package memory

import chisel3._
import chisel3.util._
import scala.math.pow

class dut(
  val operationMode: String = "DUAL_PORT",
  val addrWidth: Int = 14,
  val dataWidth: Int = 32,
  val depth: Int = 16384,
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

  // Memory array
  val mem = SyncReadMem(depth, UInt(dataWidth.W))
  
  // Port A logic
  val portaOutReg = withClock(io.portaclk) {
    RegInit(0.U(dataWidth.W))
  }
  
  withClock(io.portaclk) {
    when(io.portaena) {
      when(io.portawe) {
        mem.write(io.portaaddr, io.portadatain)
      }.otherwise {
        // For synchronous read
        when(outputMode == "REG") {
          portaOutReg := mem.read(io.portaaddr)
        }
      }
    }
  }
  
  // Port B logic
  val portbOutReg = withClock(io.portbclk) {
    RegInit(0.U(dataWidth.W))
  }
  
  withClock(io.portbclk) {
    when(io.portbena) {
      when(io.portbwe) {
        mem.write(io.portbaddr, io.portbdatain)
      }.otherwise {
        // For synchronous read
        when(outputMode == "REG") {
          portbOutReg := mem.read(io.portbaddr)
        }
      }
    }
  }
  
  // Handle special case for SINGLE_PORT mode
  if (operationMode == "SINGLE_PORT") {
    // In single port mode, only port A is active
    io.portbdataout := DontCare
    io.portadataout := Mux(outputMode == "REG", portaOutReg, mem.read(io.portaaddr))
  } else {
    // Dual port mode - both ports active
    io.portadataout := Mux(outputMode == "REG", portaOutReg, mem.read(io.portaaddr))
    io.portbdataout := Mux(outputMode == "REG", portbOutReg, mem.read(io.portbaddr))
  }
  
  // Add write-read conflict detection logic
  // Note: This is a simplified approach. For full X-propagation like in Verilog
  // you would need additional hardware or simulation flags
  when(io.portawe && io.portbwe && io.portaaddr === io.portbaddr) {
    printf("WARNING: Write-write conflict detected at address %d\n", io.portaaddr)
  }

  when(io.portawe && !io.portbwe && io.portaaddr === io.portbaddr) {
    printf("WARNING: Write-read conflict on Port A write, Port B read at address %d\n", io.portaaddr)
  }

  when(!io.portawe && io.portbwe && io.portaaddr === io.portbaddr) {
    printf("WARNING: Write-read conflict on Port B write, Port A read at address %d\n", io.portaaddr)
  }
}

// Companion object for module creation
object dut {
  def apply(
    operationMode: String = "DUAL_PORT",
    addrWidth: Int = 14,
    dataWidth: Int = 32,
    depth: Int = 16384,
    outputMode: String = "REG"
  ): dut = {
    new dut(
      operationMode = operationMode,
      addrWidth = addrWidth,
      dataWidth = dataWidth, 
      depth = depth,
      outputMode = outputMode
    )
  }
}

// Example usage in Chisel test bench
class TestTop extends Module {
  val io = IO(new Bundle {
    val test_out = Output(UInt(32.W))
  })
  
  val ram = Module(new dut(
    operationMode = "DUAL_PORT",
    addrWidth = 8,
    dataWidth = 32,
    depth = 256,
    outputMode = "REG"
  ))
  
  // Connect some test signals
  ram.io.portaclk := clock
  ram.io.portaena := true.B
  ram.io.portawe := false.B
  ram.io.portaaddr := 0.U
  ram.io.portadatain := 0.U
  
  ram.io.portbclk := clock
  ram.io.portbena := true.B
  ram.io.portbwe := false.B
  ram.io.portbaddr := 0.U
  ram.io.portbdatain := 0.U
  
  io.test_out := ram.io.portadataout
}
