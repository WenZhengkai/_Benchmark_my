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
  val io = IO(new Bundle {
    // Inputs
    val portawe = Input(Bool())
    val portbwe = Input(Bool())
    val portaena = Input(Bool())
    val portbena = Input(Bool())
    val portaclk = Input(Clock())
    val portbclk = Input(Clock())
    val portadatain = Input(UInt(width.W))
    val portbdatain = Input(UInt(width.W))
    val portaaddr = Input(UInt(addrwidth.W))
    val portbaddr = Input(UInt(addrwidth.W))
    // Outputs
    val portadataout = Output(UInt(width.W))
    val portbdataout = Output(UInt(width.W))
  })

  // Internal memory storage
  val dpram_content = Mem(depth, UInt(width.W))

  // Registered outputs
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
    io.portadataout := portadataout_reg
    io.portbdataout := portbdataout_reg
  } else {
    io.portadataout := dpram_content.read(io.portaaddr)
    io.portbdataout := dpram_content.read(io.portbaddr)
  }

  // Handle simultaneous write conflicts
  when(io.portawe && io.portbwe && io.portaaddr === io.portbaddr) {
    dpram_content.write(io.portaaddr, "bX".asUInt(width.W))
  }

  // Handle simultaneous read/write conflicts
  when(io.portawe && !io.portbwe && io.portaaddr === io.portbaddr) {
    portbdataout_reg := "bX".asUInt(width.W)
  }
  when(!io.portawe && io.portbwe && io.portaaddr === io.portbaddr) {
    portadataout_reg := "bX".asUInt(width.W)
  }
}

/*
object Dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new Dut(), Array("--target-dir", "generated"))
}
*/
