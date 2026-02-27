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
  val dpram_content = Mem(depth, UInt(width.W))

  // Registered outputs
  val portadataout_reg = RegInit(0.U(width.W))
  val portbdataout_reg = RegInit(0.U(width.W))

  // Temporary outputs
  val portadataout_tmp = Wire(UInt(width.W))
  val portbdataout_tmp = Wire(UInt(width.W))

  // Port A logic
  withClock(io.portaclk) {
    when(io.portaena) {
      when(io.portawe) {
        // Write operation
        dpram_content.write(io.portaaddr, io.portadatain)
        // Check for simultaneous write conflict
        when(io.portbwe && io.portbena && (io.portaaddr === io.portbaddr)) {
          dpram_content.write(io.portaaddr, "hX".U(width.W))
        }
      }.otherwise {
        // Read operation
        portadataout_tmp := dpram_content.read(io.portaaddr)
        // Check for simultaneous read-write conflict
        when(io.portbwe && io.portbena && (io.portaaddr === io.portbaddr)) {
          portadataout_tmp := "hX".U(width.W)
        }
      }
    }
    // Registered output mode for Port A
    when(io.portaena) {
      portadataout_reg := portadataout_tmp
    }
  }

  // Port B logic
  withClock(io.portbclk) {
    when(io.portbena) {
      when(io.portbwe) {
        // Write operation
        dpram_content.write(io.portbaddr, io.portbdatain)
        // Check for simultaneous write conflict
        when(io.portawe && io.portaena && (io.portaaddr === io.portbaddr)) {
          dpram_content.write(io.portbaddr, "hX".U(width.W))
        }
      }.otherwise {
        // Read operation
        portbdataout_tmp := dpram_content.read(io.portbaddr)
        // Check for simultaneous read-write conflict
        when(io.portawe && io.portaena && (io.portaaddr === io.portbaddr)) {
          portbdataout_tmp := "hX".U(width.W)
        }
      }
    }
    // Registered output mode for Port B
    when(io.portbena) {
      portbdataout_reg := portbdataout_tmp
    }
  }

  // Output mode selection
  io.portadataout := Mux(output_mode == "REG", portadataout_reg, portadataout_tmp)
  io.portbdataout := Mux(output_mode == "REG", portbdataout_reg, portbdataout_tmp)
}

// Generate Verilog
/*
object Dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new Dut(), Array("--target-dir", "generated"))
}
*/
