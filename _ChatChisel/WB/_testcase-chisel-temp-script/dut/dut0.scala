import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val csr_read_data_in = Input(UInt(32.W))  // CSR read data
    val wb_reg_pc = Input(UInt(32.W))        // Writeback PC value
    val wb_readdata = Input(UInt(32.W))      // Read data from memory
    val wb_aluresult = Input(UInt(32.W))     // ALU result
    val wb_memtoreg = Input(UInt(2.W))       // Control signal for writeback source
    val writedata = Output(UInt(32.W))       // Output data to be written to regfile
  })

  // Writeback multiplexer implementation
  io.writedata := DontCare // Initialize output to avoid unspecified assignment warnings

  switch(io.wb_memtoreg) {
    is(0.U) { io.writedata := io.wb_reg_pc }           // Select PC value
    is(1.U) { io.writedata := io.wb_readdata }         // Select memory read data
    is(2.U) { io.writedata := io.wb_aluresult }        // Select ALU result
    is(3.U) { io.writedata := io.csr_read_data_in }    // Select CSR read data
  }
}

/*
object dutDriver extends App {
  // Generate Verilog for the dut module
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
