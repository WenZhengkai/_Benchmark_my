import chisel3._
import chisel3.util._

/**
  * Dual-port RAM (alt_exc_dpram) in Chisel
  *
  * @param addrWidth    Number of bits for the address
  * @param dataWidth    Number of bits for the data
  * @param depth        Depth of the memory (number of addresses)
  * @param outputReg    Enable registered output mode (true for "REG" mode, false for "UNREG")
  */
class dut(
  addrWidth: Int = 14,
  dataWidth: Int = 32,
  depth: Int = 16384,
  outputReg: Boolean = true
) extends Module {
  val io = IO(new Bundle {
    // Port A
    val portaClk    = Input(Clock())
    val portaWE     = Input(Bool())
    val portaEnA    = Input(Bool())
    val portaAddr   = Input(UInt(addrWidth.W))
    val portaDataIn = Input(UInt(dataWidth.W))
    val portaDataOut = Output(UInt(dataWidth.W))

    // Port B
    val portbClk    = Input(Clock())
    val portbWE     = Input(Bool())
    val portbEnA    = Input(Bool())
    val portbAddr   = Input(UInt(addrWidth.W))
    val portbDataIn = Input(UInt(dataWidth.W))
    val portbDataOut = Output(UInt(dataWidth.W))
  })

  // Internal memory storage
  val mem = SyncReadMem(depth, UInt(dataWidth.W))

  // Port A: Read/Write Logic
  withClock(io.portaClk) {
    val portaReg = Reg(UInt(dataWidth.W))
    when(io.portaEnA) {
      // Write logic
      when(io.portaWE) {
        mem.write(io.portaAddr, io.portaDataIn)
      }
      // Read logic
      portaReg := mem.read(io.portaAddr, !io.portaWE)
    }
    io.portaDataOut := Mux(outputReg.B, portaReg, mem.read(io.portaAddr, !io.portaWE))
  }

  // Port B: Read/Write Logic
  withClock(io.portbClk) {
    val portbReg = Reg(UInt(dataWidth.W))
    when(io.portbEnA) {
      // Write logic
      when(io.portbWE) {
        mem.write(io.portbAddr, io.portbDataIn)
      }
      // Read logic
      portbReg := mem.read(io.portbAddr, !io.portbWE)
    }
    io.portbDataOut := Mux(outputReg.B, portbReg, mem.read(io.portbAddr, !io.portbWE))
  }
}

/*
object AltExcDPRAMDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new AltExcDPRAM())
}
*/
