import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val csr_read_data_in = Input(UInt(32.W))
    val wb_reg_pc = Input(UInt(32.W))
    val wb_readdata = Input(UInt(32.W))
    val wb_aluresult = Input(UInt(32.W))
    val wb_memtoreg = Input(UInt(2.W))
    val writedata = Output(UInt(32.W))
  })

  // Default value for writedata
  io.writedata := 0.U // Initialize to avoid comb. logic issues

  // Writeback multiplexer logic
  switch(io.wb_memtoreg) {
    is(0.U) { io.writedata := io.wb_reg_pc }
    is(1.U) { io.writedata := io.wb_readdata }
    is(2.U) { io.writedata := io.wb_aluresult }
    is(3.U) { io.writedata := io.csr_read_data_in }
  }
}

// Generate the Verilog
/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
