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
  wire  f0_fire = io_fromFtq_req_valid & io_fromFtq_req_ready; // @[dut.scala 26:26]
  reg  f1_valid; // @[dut.scala 31:25]
  reg [31:0] f1_ftq_req_startAddr; // @[dut.scala 32:23]
  wire  f1_fire = f1_valid & io_f2_ready; // @[dut.scala 34:26]
  wire  _GEN_0 = f1_fire ? 1'h0 : f1_valid; // @[dut.scala 43:23 44:14 31:25]
  wire  _GEN_1 = f0_fire | _GEN_0; // @[dut.scala 40:23 41:14]
  wire [32:0] _T_1 = {{1'd0}, f1_ftq_req_startAddr}; // @[dut.scala 49:26]
  wire [31:0] _T_5 = f1_ftq_req_startAddr + 32'h2; // @[dut.scala 49:26]
  wire [31:0] _T_8 = f1_ftq_req_startAddr + 32'h4; // @[dut.scala 49:26]
  wire [31:0] _T_11 = f1_ftq_req_startAddr + 32'h6; // @[dut.scala 49:26]
  wire [31:0] _T_24 = f1_ftq_req_startAddr + 32'h8; // @[dut.scala 53:26]
  wire [31:0] _T_29 = f1_ftq_req_startAddr + 32'hc; // @[dut.scala 53:26]
  wire [5:0] _T_36 = {1'h1,_T_1[4:0]}; // @[Cat.scala 33:92]
  wire [5:0] _T_41 = {1'h1,_T_5[4:0]}; // @[Cat.scala 33:92]
  wire [5:0] _T_46 = {1'h1,_T_8[4:0]}; // @[Cat.scala 33:92]
  wire [5:0] _T_51 = {1'h1,_T_11[4:0]}; // @[Cat.scala 33:92]
  wire [5:0] _T_56 = {1'h1,_T_24[4:0]}; // @[Cat.scala 33:92]
  assign io_fromFtq_req_ready = ~io_f2_flush; // @[dut.scala 28:27]
  assign io_f1_valid = f1_valid; // @[dut.scala 35:15]
  assign io_f1_pc_0 = _T_1[31:0]; // @[dut.scala 49:26]
  assign io_f1_pc_1 = f1_ftq_req_startAddr + 32'h2; // @[dut.scala 49:26]
  assign io_f1_pc_2 = f1_ftq_req_startAddr + 32'h4; // @[dut.scala 49:26]
  assign io_f1_pc_3 = f1_ftq_req_startAddr + 32'h6; // @[dut.scala 49:26]
  assign io_f1_half_snpc_0 = _T_1[31:0] + 32'h2; // @[dut.scala 53:39]
  assign io_f1_half_snpc_1 = _T_8 + 32'h2; // @[dut.scala 53:39]
  assign io_f1_half_snpc_2 = _T_24 + 32'h2; // @[dut.scala 53:39]
  assign io_f1_half_snpc_3 = _T_29 + 32'h2; // @[dut.scala 53:39]
  assign io_f1_cut_ptr_0 = _T_36[4:0]; // @[dut.scala 56:17]
  assign io_f1_cut_ptr_1 = _T_41[4:0]; // @[dut.scala 56:17]
  assign io_f1_cut_ptr_2 = _T_46[4:0]; // @[dut.scala 56:17]
  assign io_f1_cut_ptr_3 = _T_51[4:0]; // @[dut.scala 56:17]
  assign io_f1_cut_ptr_4 = _T_56[4:0]; // @[dut.scala 56:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 31:25]
      f1_valid <= 1'h0; // @[dut.scala 31:25]
    end else if (io_f2_flush) begin // @[dut.scala 38:21]
      f1_valid <= 1'h0; // @[dut.scala 39:14]
    end else begin
      f1_valid <= _GEN_1;
    end
    if (!(io_f2_flush)) begin // @[dut.scala 38:21]
      if (f0_fire) begin // @[dut.scala 40:23]
        f1_ftq_req_startAddr <= io_fromFtq_req_bits_startAddr; // @[dut.scala 42:16]
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
