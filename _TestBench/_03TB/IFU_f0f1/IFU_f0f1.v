module IFU_f0f1(
  input         clock,
  input         reset,
  input         io_f2_flush,
  output        io_fromFtq_req_ready,
  input         io_fromFtq_req_valid,
  input  [31:0] io_fromFtq_req_bits_startAddr,
  output        io_f1_valid,
  input         io_f2_ready,
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
  wire  f0_fire = io_fromFtq_req_ready & io_fromFtq_req_valid; // @[Decoupled.scala 51:35]
  reg  f1_valid; // @[IFU_f0f1.scala 50:30]
  reg [31:0] f1_ftq_req_startAddr; // @[Reg.scala 19:16]
  wire  f1_fire = f1_valid & io_f2_ready; // @[IFU_f0f1.scala 54:32]
  wire  _GEN_1 = f1_fire ? 1'h0 : f1_valid; // @[IFU_f0f1.scala 50:30 64:{35,46}]
  wire  _GEN_2 = f0_fire & ~io_f2_flush | _GEN_1; // @[IFU_f0f1.scala 63:{35,46}]
  wire [32:0] _T_2 = {{1'd0}, f1_ftq_req_startAddr}; // @[IFU_f0f1.scala 66:83]
  wire [5:0] _T_19 = {1'h0,f1_ftq_req_startAddr[5:1]}; // @[Cat.scala 33:92]
  wire [6:0] _T_20 = {{1'd0}, _T_19}; // @[IFU_f0f1.scala 70:122]
  wire [5:0] _T_25 = _T_19 + 6'h1; // @[IFU_f0f1.scala 70:122]
  wire [5:0] _T_29 = _T_19 + 6'h2; // @[IFU_f0f1.scala 70:122]
  wire [5:0] _T_33 = _T_19 + 6'h3; // @[IFU_f0f1.scala 70:122]
  wire [5:0] _T_37 = _T_19 + 6'h4; // @[IFU_f0f1.scala 70:122]
  assign io_fromFtq_req_ready = f1_fire | ~f1_valid; // @[IFU_f0f1.scala 56:26]
  assign io_f1_valid = f1_valid; // @[IFU_f0f1.scala 72:15]
  assign io_f1_pc_0 = _T_2[31:0]; // @[IFU_f0f1.scala 66:83]
  assign io_f1_pc_1 = f1_ftq_req_startAddr + 32'h2; // @[IFU_f0f1.scala 66:83]
  assign io_f1_pc_2 = f1_ftq_req_startAddr + 32'h4; // @[IFU_f0f1.scala 66:83]
  assign io_f1_pc_3 = f1_ftq_req_startAddr + 32'h6; // @[IFU_f0f1.scala 66:83]
  assign io_f1_half_snpc_0 = f1_ftq_req_startAddr + 32'h4; // @[IFU_f0f1.scala 68:83]
  assign io_f1_half_snpc_1 = f1_ftq_req_startAddr + 32'h6; // @[IFU_f0f1.scala 68:83]
  assign io_f1_half_snpc_2 = f1_ftq_req_startAddr + 32'h8; // @[IFU_f0f1.scala 68:83]
  assign io_f1_half_snpc_3 = f1_ftq_req_startAddr + 32'ha; // @[IFU_f0f1.scala 68:83]
  assign io_f1_cut_ptr_0 = _T_20[4:0]; // @[IFU_f0f1.scala 70:19]
  assign io_f1_cut_ptr_1 = _T_25[4:0]; // @[IFU_f0f1.scala 70:19]
  assign io_f1_cut_ptr_2 = _T_29[4:0]; // @[IFU_f0f1.scala 70:19]
  assign io_f1_cut_ptr_3 = _T_33[4:0]; // @[IFU_f0f1.scala 70:19]
  assign io_f1_cut_ptr_4 = _T_37[4:0]; // @[IFU_f0f1.scala 70:19]
  always @(posedge clock) begin
    if (reset) begin // @[IFU_f0f1.scala 50:30]
      f1_valid <= 1'h0; // @[IFU_f0f1.scala 50:30]
    end else if (io_f2_flush) begin // @[IFU_f0f1.scala 62:35]
      f1_valid <= 1'h0; // @[IFU_f0f1.scala 62:46]
    end else begin
      f1_valid <= _GEN_2;
    end
    if (f0_fire) begin // @[Reg.scala 20:18]
      f1_ftq_req_startAddr <= io_fromFtq_req_bits_startAddr; // @[Reg.scala 20:22]
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
