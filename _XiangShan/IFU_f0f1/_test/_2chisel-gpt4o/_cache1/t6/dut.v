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
  wire  f0_fire = io_fromFtq_req_valid & io_f2_ready; // @[dut.scala 24:26]
  reg  f1_valid; // @[dut.scala 27:25]
  reg [31:0] f1_ftq_req; // @[dut.scala 28:27]
  wire  _GEN_0 = f0_fire | f1_valid; // @[dut.scala 32:23 33:14 27:25]
  wire [2:0] _io_f1_pc_0_T = 1'h0 * 2'h2; // @[dut.scala 40:38]
  wire [31:0] _GEN_4 = {{29'd0}, _io_f1_pc_0_T}; // @[dut.scala 40:31]
  wire [31:0] _io_f1_pc_0_T_2 = f1_ftq_req + _GEN_4; // @[dut.scala 40:31]
  wire [3:0] _io_f1_half_snpc_0_T = 1'h0 * 3'h4; // @[dut.scala 41:45]
  wire [31:0] _GEN_5 = {{28'd0}, _io_f1_half_snpc_0_T}; // @[dut.scala 41:38]
  wire [31:0] _io_f1_half_snpc_0_T_2 = f1_ftq_req + _GEN_5; // @[dut.scala 41:38]
  wire [2:0] _io_f1_pc_1_T = 1'h1 * 2'h2; // @[dut.scala 40:38]
  wire [31:0] _GEN_6 = {{29'd0}, _io_f1_pc_1_T}; // @[dut.scala 40:31]
  wire [31:0] _io_f1_pc_1_T_2 = f1_ftq_req + _GEN_6; // @[dut.scala 40:31]
  wire [3:0] _io_f1_half_snpc_1_T = 1'h1 * 3'h4; // @[dut.scala 41:45]
  wire [31:0] _GEN_7 = {{28'd0}, _io_f1_half_snpc_1_T}; // @[dut.scala 41:38]
  wire [31:0] _io_f1_half_snpc_1_T_2 = f1_ftq_req + _GEN_7; // @[dut.scala 41:38]
  wire [3:0] _io_f1_pc_2_T = 2'h2 * 2'h2; // @[dut.scala 40:38]
  wire [31:0] _GEN_8 = {{28'd0}, _io_f1_pc_2_T}; // @[dut.scala 40:31]
  wire [31:0] _io_f1_pc_2_T_2 = f1_ftq_req + _GEN_8; // @[dut.scala 40:31]
  wire [4:0] _io_f1_half_snpc_2_T = 2'h2 * 3'h4; // @[dut.scala 41:45]
  wire [31:0] _GEN_9 = {{27'd0}, _io_f1_half_snpc_2_T}; // @[dut.scala 41:38]
  wire [31:0] _io_f1_half_snpc_2_T_2 = f1_ftq_req + _GEN_9; // @[dut.scala 41:38]
  wire [3:0] _io_f1_pc_3_T = 2'h3 * 2'h2; // @[dut.scala 40:38]
  wire [31:0] _GEN_10 = {{28'd0}, _io_f1_pc_3_T}; // @[dut.scala 40:31]
  wire [31:0] _io_f1_pc_3_T_2 = f1_ftq_req + _GEN_10; // @[dut.scala 40:31]
  wire [4:0] _io_f1_half_snpc_3_T = 2'h3 * 3'h4; // @[dut.scala 41:45]
  wire [31:0] _GEN_11 = {{27'd0}, _io_f1_half_snpc_3_T}; // @[dut.scala 41:38]
  wire [31:0] _io_f1_half_snpc_3_T_2 = f1_ftq_req + _GEN_11; // @[dut.scala 41:38]
  wire [4:0] _io_f1_cut_ptr_4_T = 3'h4 * 2'h2; // @[dut.scala 45:44]
  wire [31:0] _GEN_16 = {{27'd0}, _io_f1_cut_ptr_4_T}; // @[dut.scala 45:37]
  wire [31:0] _io_f1_cut_ptr_4_T_2 = f1_ftq_req + _GEN_16; // @[dut.scala 45:37]
  assign io_fromFtq_req_ready = io_f2_ready & ~f1_valid; // @[dut.scala 49:39]
  assign io_f1_valid = f1_valid; // @[dut.scala 37:15]
  assign io_f1_pc_0 = f1_ftq_req + _GEN_4; // @[dut.scala 40:31]
  assign io_f1_pc_1 = f1_ftq_req + _GEN_6; // @[dut.scala 40:31]
  assign io_f1_pc_2 = f1_ftq_req + _GEN_8; // @[dut.scala 40:31]
  assign io_f1_pc_3 = f1_ftq_req + _GEN_10; // @[dut.scala 40:31]
  assign io_f1_half_snpc_0 = _io_f1_half_snpc_0_T_2 + 32'h2; // @[dut.scala 41:52]
  assign io_f1_half_snpc_1 = _io_f1_half_snpc_1_T_2 + 32'h2; // @[dut.scala 41:52]
  assign io_f1_half_snpc_2 = _io_f1_half_snpc_2_T_2 + 32'h2; // @[dut.scala 41:52]
  assign io_f1_half_snpc_3 = _io_f1_half_snpc_3_T_2 + 32'h2; // @[dut.scala 41:52]
  assign io_f1_cut_ptr_0 = _io_f1_pc_0_T_2[5:1]; // @[dut.scala 45:51]
  assign io_f1_cut_ptr_1 = _io_f1_pc_1_T_2[5:1]; // @[dut.scala 45:51]
  assign io_f1_cut_ptr_2 = _io_f1_pc_2_T_2[5:1]; // @[dut.scala 45:51]
  assign io_f1_cut_ptr_3 = _io_f1_pc_3_T_2[5:1]; // @[dut.scala 45:51]
  assign io_f1_cut_ptr_4 = _io_f1_cut_ptr_4_T_2[5:1]; // @[dut.scala 45:51]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 27:25]
      f1_valid <= 1'h0; // @[dut.scala 27:25]
    end else if (io_f2_flush) begin // @[dut.scala 30:21]
      f1_valid <= 1'h0; // @[dut.scala 31:14]
    end else begin
      f1_valid <= _GEN_0;
    end
    if (reset) begin // @[dut.scala 28:27]
      f1_ftq_req <= 32'h0; // @[dut.scala 28:27]
    end else if (!(io_f2_flush)) begin // @[dut.scala 30:21]
      if (f0_fire) begin // @[dut.scala 32:23]
        f1_ftq_req <= io_fromFtq_req_bits_startAddr; // @[dut.scala 34:16]
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
  f1_ftq_req = _RAND_1[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
