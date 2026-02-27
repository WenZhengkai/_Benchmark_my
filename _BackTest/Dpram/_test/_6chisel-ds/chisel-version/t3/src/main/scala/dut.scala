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
  // Define IO ports
  val io = IO(new Bundle {
    // Port A
    val portawe   = Input(Bool())
    val portaena  = Input(Bool())
    val portaclk  = Input(Clock())
    val portadatain = Input(UInt(width.W))
    val portaaddr = Input(UInt(addrwidth.W))
    val portadataout = Output(UInt(width.W))

    // Port B
    val portbwe   = Input(Bool())
    val portbena  = Input(Bool())
    val portbclk  = Input(Clock())
    val portbdatain = Input(UInt(width.W))
    val portbaddr = Input(UInt(addrwidth.W))
    val portbdataout = Output(UInt(width.W))
  })

  // Internal memory storage
  val dpram_content = SyncReadMem(depth, UInt(width.W))

  // Internal signals for Port A
  val portawe_latched = RegNext(io.portawe, false.B)
  val portaaddr_latched = RegNext(io.portaaddr, 0.U)
  val portadataout_tmp = Wire(UInt(width.W))
  val portadataout_reg = Reg(UInt(width.W))
  val portadataout_reg_out = RegNext(portadataout_reg, 0.U)

  // Internal signals for Port B
  val portbwe_latched = RegNext(io.portbwe, false.B)
  val portbaddr_latched = RegNext(io.portbaddr, 0.U)
  val portbdataout_tmp = Wire(UInt(width.W))
  val portbdataout_reg = Reg(UInt(width.W))
  val portbdataout_reg_out = RegNext(portbdataout_reg, 0.U)

  // Port A logic
  when(io.portaena && io.portaclk.asUInt.toBool) {
    when(io.portawe) {
      // Write operation for Port A
      dpram_content.write(io.portaaddr, io.portadatain)
    } otherwise {
      // Read operation for Port A
      portadataout_tmp := dpram_content.read(io.portaaddr)
    }
  }

  // Port B logic
  when(io.portbena && io.portbclk.asUInt.toBool) {
    when(io.portbwe) {
      // Write operation for Port B
      dpram_content.write(io.portbaddr, io.portbdatain)
    } otherwise {
      // Read operation for Port B
      portbdataout_tmp := dpram_content.read(io.portbaddr)
    }
  }

  // Handle simultaneous read/write conflicts
  when(io.portaena && io.portbena && io.portaaddr === io.portbaddr) {
    when(io.portawe && io.portbwe) {
      // Both ports writing to the same location: force unknown
      dpram_content.write(io.portaaddr, "hX".asUInt(width.W))
    } otherwise {
      // One port reading, the other writing: force unknown output
      when(io.portawe) {
        portbdataout_tmp := "hX".asUInt(width.W)
      }
      when(io.portbwe) {
        portadataout_tmp := "hX".asUInt(width.W)
      }
    }
  }

  // Registered output mode logic
  if (output_mode == "REG") {
    portadataout_reg := portadataout_tmp
    portbdataout_reg := portbdataout_tmp
    io.portadataout := portadataout_reg_out
    io.portbdataout := portbdataout_reg_out
  } else {
    io.portadataout := portadataout_tmp
    io.portbdataout := portbdataout_tmp
  }
}

// Generate Verilog
/*
object Dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new Dut())
}
*/
