import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val csr_read_data_in = Input(UInt(32.W)) // Input from CSR (Control and Status Register)
    val wb_reg_pc = Input(UInt(32.W))       // Input from the program counter
    val wb_readdata = Input(UInt(32.W))     // Input from memory read
    val wb_aluresult = Input(UInt(32.W))    // Input from ALU result
    val wb_memtoreg = Input(UInt(2.W))      // Control signal to select writeback data
    val writedata = Output(UInt(32.W))      // Output writeback data for regfile
  })

  // Writeback Data Multiplexer
  io.writedata := 0.U // Default value to avoid unintended latches
  switch(io.wb_memtoreg) {
    is(0.U) { io.writedata := io.wb_reg_pc }         // Case 00: Write back PC
    is(1.U) { io.writedata := io.wb_readdata }       // Case 01: Write back data from memory
    is(2.U) { io.writedata := io.wb_aluresult }      // Case 10: Write back ALU result
    is(3.U) { io.writedata := io.csr_read_data_in }  // Case 11: Write back CSR read data
  }
}

// Generate the Verilog code
/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut())
}
*/
