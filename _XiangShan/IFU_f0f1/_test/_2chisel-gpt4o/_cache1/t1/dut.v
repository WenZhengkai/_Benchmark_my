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
  reg  f1_valid; // @[dut.scala 29:25]
  reg [31:0] f1_ftq_req_startAddr; // @[dut.scala 30:23]
  wire [2:0] _io_f1_pc_0_T = 1'h0 * 2'h2; // @[dut.scala 54:48]
  wire [31:0] _GEN_3 = {{29'd0}, _io_f1_pc_0_T}; // @[dut.scala 54:41]
  wire [3:0] _io_f1_half_snpc_0_T = 1'h0 * 3'h4; // @[dut.scala 55:55]
  wire [31:0] _GEN_4 = {{28'd0}, _io_f1_half_snpc_0_T}; // @[dut.scala 55:48]
  wire [31:0] _io_f1_half_snpc_0_T_2 = f1_ftq_req_startAddr + _GEN_4; // @[dut.scala 55:48]
  wire [2:0] _io_f1_pc_1_T = 1'h1 * 2'h2; // @[dut.scala 54:48]
  wire [31:0] _GEN_5 = {{29'd0}, _io_f1_pc_1_T}; // @[dut.scala 54:41]
  wire [3:0] _io_f1_half_snpc_1_T = 1'h1 * 3'h4; // @[dut.scala 55:55]
  wire [31:0] _GEN_6 = {{28'd0}, _io_f1_half_snpc_1_T}; // @[dut.scala 55:48]
  wire [31:0] _io_f1_half_snpc_1_T_2 = f1_ftq_req_startAddr + _GEN_6; // @[dut.scala 55:48]
  wire [3:0] _io_f1_pc_2_T = 2'h2 * 2'h2; // @[dut.scala 54:48]
  wire [31:0] _GEN_7 = {{28'd0}, _io_f1_pc_2_T}; // @[dut.scala 54:41]
  wire [4:0] _io_f1_half_snpc_2_T = 2'h2 * 3'h4; // @[dut.scala 55:55]
  wire [31:0] _GEN_8 = {{27'd0}, _io_f1_half_snpc_2_T}; // @[dut.scala 55:48]
  wire [31:0] _io_f1_half_snpc_2_T_2 = f1_ftq_req_startAddr + _GEN_8; // @[dut.scala 55:48]
  wire [3:0] _io_f1_pc_3_T = 2'h3 * 2'h2; // @[dut.scala 54:48]
  wire [31:0] _GEN_9 = {{28'd0}, _io_f1_pc_3_T}; // @[dut.scala 54:41]
  wire [4:0] _io_f1_half_snpc_3_T = 2'h3 * 3'h4; // @[dut.scala 55:55]
  wire [31:0] _GEN_10 = {{27'd0}, _io_f1_half_snpc_3_T}; // @[dut.scala 55:48]
  wire [31:0] _io_f1_half_snpc_3_T_2 = f1_ftq_req_startAddr + _GEN_10; // @[dut.scala 55:48]
  wire [5:0] _io_f1_cut_ptr_0_T_1 = {1'h0,f1_ftq_req_startAddr[4:0]}; // @[Cat.scala 33:92]
  assign io_fromFtq_req_ready = io_f2_ready & ~io_f2_flush; // @[dut.scala 37:39]
  assign io_f1_valid = f1_valid & io_f2_ready; // @[dut.scala 63:27]
  assign io_f1_pc_0 = f1_ftq_req_startAddr + _GEN_3; // @[dut.scala 54:41]
  assign io_f1_pc_1 = f1_ftq_req_startAddr + _GEN_5; // @[dut.scala 54:41]
  assign io_f1_pc_2 = f1_ftq_req_startAddr + _GEN_7; // @[dut.scala 54:41]
  assign io_f1_pc_3 = f1_ftq_req_startAddr + _GEN_9; // @[dut.scala 54:41]
  assign io_f1_half_snpc_0 = _io_f1_half_snpc_0_T_2 + 32'h2; // @[dut.scala 55:62]
  assign io_f1_half_snpc_1 = _io_f1_half_snpc_1_T_2 + 32'h2; // @[dut.scala 55:62]
  assign io_f1_half_snpc_2 = _io_f1_half_snpc_2_T_2 + 32'h2; // @[dut.scala 55:62]
  assign io_f1_half_snpc_3 = _io_f1_half_snpc_3_T_2 + 32'h2; // @[dut.scala 55:62]
  assign io_f1_cut_ptr_0 = _io_f1_cut_ptr_0_T_1[4:0]; // @[dut.scala 59:22]
  assign io_f1_cut_ptr_1 = _io_f1_cut_ptr_0_T_1[4:0]; // @[dut.scala 59:22]
  assign io_f1_cut_ptr_2 = _io_f1_cut_ptr_0_T_1[4:0]; // @[dut.scala 59:22]
  assign io_f1_cut_ptr_3 = _io_f1_cut_ptr_0_T_1[4:0]; // @[dut.scala 59:22]
  assign io_f1_cut_ptr_4 = _io_f1_cut_ptr_0_T_1[4:0]; // @[dut.scala 59:22]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 29:25]
      f1_valid <= 1'h0; // @[dut.scala 29:25]
    end else if (io_f2_flush | ~f0_fire) begin // @[dut.scala 40:33]
      f1_valid <= 1'h0; // @[dut.scala 41:14]
    end else begin
      f1_valid <= f0_fire; // @[dut.scala 43:14]
    end
    if (!(io_f2_flush | ~f0_fire)) begin // @[dut.scala 40:33]
      if (f0_fire) begin // @[dut.scala 44:19]
        f1_ftq_req_startAddr <= io_fromFtq_req_bits_startAddr; // @[dut.scala 45:18]
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
