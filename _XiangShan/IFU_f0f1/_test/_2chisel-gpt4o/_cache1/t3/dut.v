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
  wire  f0_fire = io_fromFtq_req_valid & io_fromFtq_req_ready; // @[dut.scala 25:26]
  wire  _io_fromFtq_req_ready_T = ~io_f2_flush; // @[dut.scala 31:27]
  reg  f1_valid_reg; // @[dut.scala 36:29]
  reg [31:0] f1_ftq_req_startAddr; // @[dut.scala 37:27]
  wire  f1_fire = f1_valid_reg & io_f2_ready; // @[dut.scala 40:30]
  wire  f1_ready = f1_fire | ~f1_valid_reg; // @[dut.scala 41:26]
  wire  _GEN_0 = io_f2_flush ? 1'h0 : f1_valid_reg; // @[dut.scala 46:27 47:18 36:29]
  wire  _GEN_2 = f0_fire & f1_ready | _GEN_0; // @[dut.scala 43:29 45:18]
  wire [32:0] _io_f1_pc_0_T_1 = {{1'd0}, f1_ftq_req_startAddr}; // @[dut.scala 55:29]
  wire [31:0] _io_f1_half_snpc_1_T_2 = f1_ftq_req_startAddr + 32'h4; // @[dut.scala 56:36]
  wire [31:0] _io_f1_half_snpc_2_T_2 = f1_ftq_req_startAddr + 32'h8; // @[dut.scala 56:36]
  wire [31:0] _io_f1_half_snpc_3_T_2 = f1_ftq_req_startAddr + 32'hc; // @[dut.scala 56:36]
  wire [1:0] _io_f1_cut_ptr_2_T_1 = 2'h2 - 2'h1; // @[dut.scala 64:33]
  wire [5:0] _io_f1_cut_ptr_2_T_2 = {_io_f1_cut_ptr_2_T_1, 4'h0}; // @[dut.scala 64:40]
  wire [1:0] _io_f1_cut_ptr_3_T_1 = 2'h3 - 2'h1; // @[dut.scala 64:33]
  wire [5:0] _io_f1_cut_ptr_3_T_2 = {_io_f1_cut_ptr_3_T_1, 4'h0}; // @[dut.scala 64:40]
  wire [2:0] _io_f1_cut_ptr_4_T_1 = 3'h4 - 3'h1; // @[dut.scala 64:33]
  wire [6:0] _io_f1_cut_ptr_4_T_2 = {_io_f1_cut_ptr_4_T_1, 4'h0}; // @[dut.scala 64:40]
  assign io_fromFtq_req_ready = ~io_f2_flush & io_f2_ready; // @[dut.scala 31:40]
  assign io_f1_valid = f1_valid_reg & _io_fromFtq_req_ready_T; // @[dut.scala 50:31]
  assign io_f1_pc_0 = _io_f1_pc_0_T_1[31:0]; // @[dut.scala 55:29]
  assign io_f1_pc_1 = f1_ftq_req_startAddr + 32'h2; // @[dut.scala 55:29]
  assign io_f1_pc_2 = f1_ftq_req_startAddr + 32'h4; // @[dut.scala 55:29]
  assign io_f1_pc_3 = f1_ftq_req_startAddr + 32'h6; // @[dut.scala 55:29]
  assign io_f1_half_snpc_0 = _io_f1_pc_0_T_1[31:0] + 32'h2; // @[dut.scala 56:49]
  assign io_f1_half_snpc_1 = _io_f1_half_snpc_1_T_2 + 32'h2; // @[dut.scala 56:49]
  assign io_f1_half_snpc_2 = _io_f1_half_snpc_2_T_2 + 32'h2; // @[dut.scala 56:49]
  assign io_f1_half_snpc_3 = _io_f1_half_snpc_3_T_2 + 32'h2; // @[dut.scala 56:49]
  assign io_f1_cut_ptr_0 = 5'h0; // @[dut.scala 62:24]
  assign io_f1_cut_ptr_1 = 5'h0; // @[dut.scala 64:40]
  assign io_f1_cut_ptr_2 = _io_f1_cut_ptr_2_T_2[4:0]; // @[dut.scala 64:24]
  assign io_f1_cut_ptr_3 = _io_f1_cut_ptr_3_T_2[4:0]; // @[dut.scala 64:24]
  assign io_f1_cut_ptr_4 = _io_f1_cut_ptr_4_T_2[4:0]; // @[dut.scala 64:24]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 36:29]
      f1_valid_reg <= 1'h0; // @[dut.scala 36:29]
    end else if (io_f2_flush) begin // @[dut.scala 69:21]
      f1_valid_reg <= 1'h0; // @[dut.scala 71:18]
    end else begin
      f1_valid_reg <= _GEN_2;
    end
    if (reset) begin // @[dut.scala 37:27]
      f1_ftq_req_startAddr <= 32'h0; // @[dut.scala 37:27]
    end else if (f0_fire & f1_ready) begin // @[dut.scala 43:29]
      f1_ftq_req_startAddr <= io_fromFtq_req_bits_startAddr; // @[dut.scala 44:16]
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
  f1_valid_reg = _RAND_0[0:0];
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
