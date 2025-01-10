module dut(
  input         clock,
  input         reset,
  input         io_f2_flush,
  output        io_fromFtq_req_ready,
  input         io_fromFtq_req_valid,
  input  [31:0] io_fromFtq_req_bits_startAddr,
  input         io_f2_ready,
  output        io_f1_valid,
  output [31:0] io_f1_pc_0,
  output [31:0] io_f1_pc_1,
  output [31:0] io_f1_pc_2,
  output [31:0] io_f1_pc_3,
  output [31:0] io_f1_half_snpc_0,
  output [31:0] io_f1_half_snpc_1,
  output [31:0] io_f1_half_snpc_2,
  output [31:0] io_f1_half_snpc_3,
  output [4:0]  io_f1_cut_ptr_0,
  output [4:0]  io_f1_cut_ptr_1,
  output [4:0]  io_f1_cut_ptr_2,
  output [4:0]  io_f1_cut_ptr_3,
  output [4:0]  io_f1_cut_ptr_4
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  f0_fire = io_fromFtq_req_valid & io_fromFtq_req_ready; // @[dut.scala 24:26]
  reg  f1_valid; // @[dut.scala 28:25]
  reg [31:0] f1_ftq_req_startAddr; // @[dut.scala 29:33]
  wire  _GEN_0 = io_f2_ready ? 1'h0 : f1_valid; // @[dut.scala 36:28 37:14 28:25]
  wire  _GEN_1 = f0_fire | _GEN_0; // @[dut.scala 33:24 34:14]
  wire [32:0] _pcBase_0_T_1 = {{1'd0}, f1_ftq_req_startAddr}; // @[dut.scala 46:39]
  wire [31:0] pcBase_0 = _pcBase_0_T_1[31:0]; // @[dut.scala 46:39]
  wire [31:0] snpcBase_0 = pcBase_0 + 32'h2; // @[dut.scala 47:54]
  wire [4:0] cutPtrBase_0 = pcBase_0[5:1]; // @[dut.scala 48:58]
  wire [31:0] pcBase_1 = f1_ftq_req_startAddr + 32'h2; // @[dut.scala 46:39]
  wire [31:0] _snpcBase_1_T_2 = f1_ftq_req_startAddr + 32'h4; // @[dut.scala 47:41]
  wire [31:0] snpcBase_1 = _snpcBase_1_T_2 + 32'h2; // @[dut.scala 47:54]
  wire [4:0] cutPtrBase_1 = pcBase_1[5:1]; // @[dut.scala 48:58]
  wire [31:0] _snpcBase_2_T_2 = f1_ftq_req_startAddr + 32'h8; // @[dut.scala 47:41]
  wire [31:0] snpcBase_2 = _snpcBase_2_T_2 + 32'h2; // @[dut.scala 47:54]
  wire [4:0] cutPtrBase_2 = _snpcBase_1_T_2[5:1]; // @[dut.scala 48:58]
  wire [31:0] pcBase_3 = f1_ftq_req_startAddr + 32'h6; // @[dut.scala 46:39]
  wire [31:0] _snpcBase_3_T_2 = f1_ftq_req_startAddr + 32'hc; // @[dut.scala 47:41]
  wire [31:0] snpcBase_3 = _snpcBase_3_T_2 + 32'h2; // @[dut.scala 47:54]
  wire [4:0] cutPtrBase_3 = pcBase_3[5:1]; // @[dut.scala 48:58]
  assign io_fromFtq_req_ready = ~io_f2_flush & ~io_f2_ready; // @[dut.scala 25:40]
  assign io_f1_valid = f1_valid & io_f2_ready; // @[dut.scala 52:17]
  assign io_f1_pc_0 = f1_valid & io_f2_ready ? pcBase_0 : 32'h0; // @[dut.scala 52:33 54:14 59:14]
  assign io_f1_pc_1 = f1_valid & io_f2_ready ? pcBase_1 : 32'h0; // @[dut.scala 52:33 54:14 59:14]
  assign io_f1_pc_2 = f1_valid & io_f2_ready ? _snpcBase_1_T_2 : 32'h0; // @[dut.scala 52:33 54:14 59:14]
  assign io_f1_pc_3 = f1_valid & io_f2_ready ? pcBase_3 : 32'h0; // @[dut.scala 52:33 54:14 59:14]
  assign io_f1_half_snpc_0 = f1_valid & io_f2_ready ? snpcBase_0 : 32'h0; // @[dut.scala 52:33 55:21 60:21]
  assign io_f1_half_snpc_1 = f1_valid & io_f2_ready ? snpcBase_1 : 32'h0; // @[dut.scala 52:33 55:21 60:21]
  assign io_f1_half_snpc_2 = f1_valid & io_f2_ready ? snpcBase_2 : 32'h0; // @[dut.scala 52:33 55:21 60:21]
  assign io_f1_half_snpc_3 = f1_valid & io_f2_ready ? snpcBase_3 : 32'h0; // @[dut.scala 52:33 55:21 60:21]
  assign io_f1_cut_ptr_0 = f1_valid & io_f2_ready ? cutPtrBase_0 : 5'h0; // @[dut.scala 52:33 56:19 61:19]
  assign io_f1_cut_ptr_1 = f1_valid & io_f2_ready ? cutPtrBase_1 : 5'h0; // @[dut.scala 52:33 56:19 61:19]
  assign io_f1_cut_ptr_2 = f1_valid & io_f2_ready ? cutPtrBase_2 : 5'h0; // @[dut.scala 52:33 56:19 61:19]
  assign io_f1_cut_ptr_3 = f1_valid & io_f2_ready ? cutPtrBase_3 : 5'h0; // @[dut.scala 52:33 56:19 61:19]
  assign io_f1_cut_ptr_4 = 5'h0; // @[dut.scala 52:33 56:19 61:19]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 28:25]
      f1_valid <= 1'h0; // @[dut.scala 28:25]
    end else if (io_f2_flush) begin // @[dut.scala 31:21]
      f1_valid <= 1'h0; // @[dut.scala 32:14]
    end else begin
      f1_valid <= _GEN_1;
    end
    if (!(io_f2_flush)) begin // @[dut.scala 31:21]
      if (f0_fire) begin // @[dut.scala 33:24]
        f1_ftq_req_startAddr <= io_fromFtq_req_bits_startAddr; // @[dut.scala 35:26]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  f1_valid = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  f1_ftq_req_startAddr = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
