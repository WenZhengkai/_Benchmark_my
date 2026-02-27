import chisel3._
import chisel3.util._

class dut(
    val operation_mode: String = "DUAL_PORT",
    val addrwidth: Int = 14,
    val width: Int = 32,
    val depth: Int = 16384,
    val ramblock: Int = 65535,
    val output_mode: String = "REG",
    val lpm_file: String = "NONE",
    val lpm_type: String = "alt_exc_dpram",
    val lpm_hint: String = "UNUSED"
) extends Module {
  // IO Ports
  val io = IO(new Bundle {
    // Port A
    val portawe = Input(Bool())
    val portaena = Input(Bool())
    val portaclk = Input(Clock())
    val portadatain = Input(UInt(width.W))
    val portaaddr = Input(UInt(addrwidth.W))
    val portadataout = Output(UInt(width.W))

    // Port B
    val portbwe = Input(Bool())
    val portbena = Input(Bool())
    val portbclk = Input(Clock())
    val portbdatain = Input(UInt(width.W))
    val portbaddr = Input(UInt(addrwidth.W))
    val portbdataout = Output(UInt(width.W))
  })

  // Internal memory array
  val dpram_content = Mem(depth, UInt(width.W))

  // Registered outputs for Port A and Port B
  val portadataout_reg = Reg(UInt(width.W))
  val portbdataout_reg = Reg(UInt(width.W))

  // Port A logic
  withClock(io.portaclk) {
    when(io.portaena) {
      when(io.portawe) {
        // Write operation for Port A
        dpram_content.write(io.portaaddr, io.portadatain)
      }.otherwise {
        // Read operation for Port A
        portadataout_reg := dpram_content.read(io.portaaddr)
      }
    }
  }

  // Port B logic
  withClock(io.portbclk) {
    when(io.portbena) {
      when(io.portbwe) {
        // Write operation for Port B
        dpram_content.write(io.portbaddr, io.portbdatain)
      }.otherwise {
        // Read operation for Port B
        portbdataout_reg := dpram_content.read(io.portbaddr)
      }
    }
  }

  // Output mode handling
  if (output_mode == "REG") {
    // Registered output mode
    io.portadataout := portadataout_reg
    io.portbdataout := portbdataout_reg
  } else {
    // Unregistered output mode
    io.portadataout := dpram_content.read(io.portaaddr)
    io.portbdataout := dpram_content.read(io.portbaddr)
  }

  // Handle simultaneous read/write conflicts
  when(io.portawe && io.portbwe && io.portaaddr === io.portbaddr) {
    // Undefined behavior for simultaneous writes to the same address
    dpram_content(io.portaaddr) := "x".U
  }

  when(io.portawe && !io.portbwe && io.portaaddr === io.portbaddr) {
    // Port B reads while Port A writes to the same address
    io.portbdataout := "x".U
  }

  when(!io.portawe && io.portbwe && io.portaaddr === io.portbaddr) {
    // Port A reads while Port B writes to the same address
    io.portadataout := "x".U
  }
}

// Top-level module for testing
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
