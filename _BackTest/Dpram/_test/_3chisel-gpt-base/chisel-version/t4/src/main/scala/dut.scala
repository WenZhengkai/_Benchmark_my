import chisel3._
import chisel3.util._

/** Dual-Port RAM Module (`alt_exc_dpram`) in Chisel */
class dut(
    addrWidth: Int = 14,          // Address width
    dataWidth: Int = 32,          // Data width
    depth: Int = 16384,           // Memory depth
    outputMode: String = "REG"    // Output mode: "REG" or "UNREG"
) extends Module {
  val io = IO(new Bundle {
    // Port A Inputs
    val porta_we = Input(Bool())                       // Write enable
    val porta_en = Input(Bool())                       // Enable
    val porta_clk = Input(Clock())                     // Clock
    val porta_data_in = Input(UInt(dataWidth.W))       // Data input
    val porta_addr = Input(UInt(addrWidth.W))          // Address input

    // Port A Outputs
    val porta_data_out = Output(UInt(dataWidth.W))     // Data output

    // Port B Inputs
    val portb_we = Input(Bool())                       // Write enable
    val portb_en = Input(Bool())                       // Enable
    val portb_clk = Input(Clock())                     // Clock
    val portb_data_in = Input(UInt(dataWidth.W))       // Data input
    val portb_addr = Input(UInt(addrWidth.W))          // Address input

    // Port B Outputs
    val portb_data_out = Output(UInt(dataWidth.W))     // Data output
  })

  // Internal dual-port RAM memory
  val mem = SyncReadMem(depth, UInt(dataWidth.W))

  // ---------------------------------
  // Port A Functionality
  // ---------------------------------
  // Read/Write enable logic for Port A
  withClock(io.porta_clk) {
    when(io.porta_we && io.porta_en) {
      // Write operation
      mem.write(io.porta_addr, io.porta_data_in)
    }
  }

  // Data output for Port A
  val porta_reg_out = WireDefault(0.U(dataWidth.W)) // Default to zero if unused
  porta_reg_out := mem.read(io.porta_addr, io.porta_en && !io.porta_we)

  // Registered output mode for Port A
  if (outputMode == "REG") {
    val porta_data_out_reg = RegNext(porta_reg_out)
    io.porta_data_out := porta_data_out_reg
  } else {
    io.porta_data_out := porta_reg_out
  }

  // ---------------------------------
  // Port B Functionality
  // ---------------------------------
  // Read/Write enable logic for Port B
  withClock(io.portb_clk) {
    when(io.portb_we && io.portb_en) {
      // Write operation
      mem.write(io.portb_addr, io.portb_data_in)
    }
  }

  // Data output for Port B
  val portb_reg_out = WireDefault(0.U(dataWidth.W)) // Default to zero if unused
  portb_reg_out := mem.read(io.portb_addr, io.portb_en && !io.portb_we)

  // Registered output mode for Port B
  if (outputMode == "REG") {
    val portb_data_out_reg = RegNext(portb_reg_out)
    io.portb_data_out := portb_data_out_reg
  } else {
    io.portb_data_out := portb_reg_out
  }
}

/** Companion object to generate Verilog for testing */
/*
object AltExcDPRAMMain extends App {
  // Default parameters: addrWidth = 14, dataWidth = 32, depth = 16384, outputMode = "REG"
  chisel3.Driver.execute(args, () => new AltExcDPRAM())
}
*/
