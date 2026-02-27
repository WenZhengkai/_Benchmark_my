module dut(
  input         clock,
  input         reset,
  input  [31:0] io_csr_read_data_in,
  input  [31:0] io_wb_reg_pc,
  input  [31:0] io_wb_readdata,
  input  [31:0] io_wb_aluresult,
  input  [1:0]  io_wb_memtoreg,
  output [31:0] io_writedata
);
  wire [31:0] _GEN_0 = 2'h3 == io_wb_memtoreg ? io_csr_read_data_in : 32'h0; // @[dut.scala 16:16 17:26 21:28]
  wire [31:0] _GEN_1 = 2'h2 == io_wb_memtoreg ? io_wb_aluresult : _GEN_0; // @[dut.scala 17:26 20:28]
  wire [31:0] _GEN_2 = 2'h1 == io_wb_memtoreg ? io_wb_readdata : _GEN_1; // @[dut.scala 17:26 19:28]
  assign io_writedata = 2'h0 == io_wb_memtoreg ? io_wb_reg_pc : _GEN_2; // @[dut.scala 17:26 18:28]
endmodule
