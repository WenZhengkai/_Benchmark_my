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

  // Internal memory array
  val dpram_content = SyncReadMem(depth, UInt(width.W))

  // Internal signals
  val portadataout_tmp = Wire(UInt(width.W))
  val portbdataout_tmp = Wire(UInt(width.W))
  val portadataout_reg = Reg(UInt(width.W))
  val portbdataout_reg = Reg(UInt(width.W))
  val portadataout_reg_out = Wire(UInt(width.W))
  val portbdataout_reg_out = Wire(UInt(width.W))

  // Port A logic
  when(io.portaena) {
    when(io.portawe) {
      // Write operation for Port A
      dpram_content.write(io.portaaddr, io.portadatain)
      portadataout_tmp := DontCare
    }.otherwise {
      // Read operation for Port A
      portadataout_tmp := dpram_content.read(io.portaaddr)
    }
  }.otherwise {
    portadataout_tmp := DontCare
  }

  // Port B logic
  when(io.portbena) {
    when(io.portbwe) {
      // Write operation for Port B
      dpram_content.write(io.portbaddr, io.portbdatain)
      portbdataout_tmp := DontCare
    }.otherwise {
      // Read operation for Port B
      portbdataout_tmp := dpram_content.read(io.portbaddr)
    }
  }.otherwise {
    portbdataout_tmp := DontCare
  }

  // Output mode handling
  if (output_mode == "REG") {
    // Registered output mode
    portadataout_reg_out := portadataout_reg
    portbdataout_reg_out := portbdataout_reg

    when(io.portaena) {
      portadataout_reg := portadataout_tmp
    }

    when(io.portbena) {
      portbdataout_reg := portbdataout_tmp
    }

    io.portadataout := portadataout_reg_out
    io.portbdataout := portbdataout_reg_out
  } else {
    // Unregistered output mode
    io.portadataout := portadataout_tmp
    io.portbdataout := portbdataout_tmp
  }

  // Handle simultaneous read/write conflicts
  when(io.portawe && io.portbwe && io.portaaddr === io.portbaddr) {
    // Both ports writing to the same address
    dpram_content.write(io.portaaddr, "hX".U(width.W))
  }

  when(io.portawe && !io.portbwe && io.portaaddr === io.portbaddr) {
    // Port A writing, Port B reading from the same address
    portbdataout_tmp := "hX".U(width.W)
  }

  when(!io.portawe && io.portbwe && io.portaaddr === io.portbaddr) {
    // Port B writing, Port A reading from the same address
    portadataout_tmp := "hX".U(width.W)
  }
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
