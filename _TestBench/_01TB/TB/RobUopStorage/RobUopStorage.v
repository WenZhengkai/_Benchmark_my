module RobUopStorage(
  input         clock,
  input         reset,
  input         io_enq_uops_0_valid,
  input  [31:0] io_enq_uops_0_pc,
  input  [6:0]  io_enq_uops_0_opcode,
  input  [4:0]  io_enq_uops_0_dst,
  input         io_enq_uops_1_valid,
  input  [31:0] io_enq_uops_1_pc,
  input  [6:0]  io_enq_uops_1_opcode,
  input  [4:0]  io_enq_uops_1_dst,
  input         io_enq_valids_0,
  input         io_enq_valids_1,
  input         io_rob_tail,
  input         io_next_rob_head,
  output        io_rob_compact_uop_rdata_0_valid,
  output [6:0]  io_rob_compact_uop_rdata_0_opcode,
  output [4:0]  io_rob_compact_uop_rdata_0_dst,
  output        io_rob_compact_uop_rdata_1_valid,
  output [6:0]  io_rob_compact_uop_rdata_1_opcode,
  output [4:0]  io_rob_compact_uop_rdata_1_dst
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] rob_compact_uop_mem_0 [0:1]; // @[RobUopStorage.scala 36:40]
  wire  rob_compact_uop_mem_0_rob_compact_uop_rdata_en; // @[RobUopStorage.scala 36:40]
  wire  rob_compact_uop_mem_0_rob_compact_uop_rdata_addr; // @[RobUopStorage.scala 36:40]
  wire [1:0] rob_compact_uop_mem_0_rob_compact_uop_rdata_data; // @[RobUopStorage.scala 36:40]
  wire [1:0] rob_compact_uop_mem_0_MPORT_data; // @[RobUopStorage.scala 36:40]
  wire  rob_compact_uop_mem_0_MPORT_addr; // @[RobUopStorage.scala 36:40]
  wire  rob_compact_uop_mem_0_MPORT_mask; // @[RobUopStorage.scala 36:40]
  wire  rob_compact_uop_mem_0_MPORT_en; // @[RobUopStorage.scala 36:40]
  reg  rob_compact_uop_mem_0_rob_compact_uop_rdata_en_pipe_0;
  reg  rob_compact_uop_mem_0_rob_compact_uop_rdata_addr_pipe_0;
  reg [1:0] rob_compact_uop_mem_1 [0:1]; // @[RobUopStorage.scala 36:40]
  wire  rob_compact_uop_mem_1_rob_compact_uop_rdata_en; // @[RobUopStorage.scala 36:40]
  wire  rob_compact_uop_mem_1_rob_compact_uop_rdata_addr; // @[RobUopStorage.scala 36:40]
  wire [1:0] rob_compact_uop_mem_1_rob_compact_uop_rdata_data; // @[RobUopStorage.scala 36:40]
  wire [1:0] rob_compact_uop_mem_1_MPORT_data; // @[RobUopStorage.scala 36:40]
  wire  rob_compact_uop_mem_1_MPORT_addr; // @[RobUopStorage.scala 36:40]
  wire  rob_compact_uop_mem_1_MPORT_mask; // @[RobUopStorage.scala 36:40]
  wire  rob_compact_uop_mem_1_MPORT_en; // @[RobUopStorage.scala 36:40]
  reg  rob_compact_uop_mem_1_rob_compact_uop_rdata_en_pipe_0;
  reg  rob_compact_uop_mem_1_rob_compact_uop_rdata_addr_pipe_0;
  reg  rob_head; // @[RobUopStorage.scala 33:29]
  wire [7:0] rob_compact_uop_wdata_hi = {io_enq_uops_0_valid,io_enq_uops_0_opcode}; // @[RobUopStorage.scala 37:78]
  wire [12:0] rob_compact_uop_wdata_0 = {io_enq_uops_0_valid,io_enq_uops_0_opcode,io_enq_uops_0_dst}; // @[RobUopStorage.scala 37:78]
  wire [7:0] rob_compact_uop_wdata_hi_1 = {io_enq_uops_1_valid,io_enq_uops_1_opcode}; // @[RobUopStorage.scala 37:78]
  wire [12:0] rob_compact_uop_wdata_1 = {io_enq_uops_1_valid,io_enq_uops_1_opcode,io_enq_uops_1_dst}; // @[RobUopStorage.scala 37:78]
  reg  rob_compact_uop_bypassed_REG; // @[RobUopStorage.scala 42:29]
  reg  rob_compact_uop_bypassed_REG_1; // @[RobUopStorage.scala 42:53]
  reg [12:0] rob_compact_uop_bypassed_REG_2; // @[RobUopStorage.scala 43:14]
  reg  rob_compact_uop_bypassed_r; // @[Reg.scala 19:16]
  reg  rob_compact_uop_bypassed_r_1; // @[Reg.scala 19:16]
  reg  rob_compact_uop_bypassed_r_2; // @[Reg.scala 19:16]
  reg  rob_compact_uop_bypassed_r_3; // @[Reg.scala 19:16]
  reg [12:0] rob_compact_uop_bypassed_r_4; // @[Reg.scala 19:16]
  reg [12:0] rob_compact_uop_bypassed_r_5; // @[Reg.scala 19:16]
  wire [12:0] _rob_compact_uop_bypassed_T_4 = rob_head == rob_compact_uop_bypassed_r_1 & rob_compact_uop_bypassed_r_3 ?
    rob_compact_uop_bypassed_r_5 : {{11'd0}, rob_compact_uop_mem_0_rob_compact_uop_rdata_data}; // @[RobUopStorage.scala 44:10]
  wire [12:0] _rob_compact_uop_bypassed_T_5 = rob_head == rob_compact_uop_bypassed_REG & rob_compact_uop_bypassed_REG_1
     ? rob_compact_uop_bypassed_REG_2 : _rob_compact_uop_bypassed_T_4; // @[RobUopStorage.scala 42:8]
  reg  rob_compact_uop_bypassed_REG_3; // @[RobUopStorage.scala 42:29]
  reg  rob_compact_uop_bypassed_REG_4; // @[RobUopStorage.scala 42:53]
  reg [12:0] rob_compact_uop_bypassed_REG_5; // @[RobUopStorage.scala 43:14]
  reg  rob_compact_uop_bypassed_r_6; // @[Reg.scala 19:16]
  reg  rob_compact_uop_bypassed_r_7; // @[Reg.scala 19:16]
  reg  rob_compact_uop_bypassed_r_8; // @[Reg.scala 19:16]
  reg  rob_compact_uop_bypassed_r_9; // @[Reg.scala 19:16]
  reg [12:0] rob_compact_uop_bypassed_r_10; // @[Reg.scala 19:16]
  reg [12:0] rob_compact_uop_bypassed_r_11; // @[Reg.scala 19:16]
  wire [12:0] _rob_compact_uop_bypassed_T_13 = rob_head == rob_compact_uop_bypassed_r_7 & rob_compact_uop_bypassed_r_9
     ? rob_compact_uop_bypassed_r_11 : {{11'd0}, rob_compact_uop_mem_1_rob_compact_uop_rdata_data}; // @[RobUopStorage.scala 44:10]
  wire [12:0] _rob_compact_uop_bypassed_T_14 = rob_head == rob_compact_uop_bypassed_REG_3 &
    rob_compact_uop_bypassed_REG_4 ? rob_compact_uop_bypassed_REG_5 : _rob_compact_uop_bypassed_T_13; // @[RobUopStorage.scala 42:8]
  assign rob_compact_uop_mem_0_rob_compact_uop_rdata_en = rob_compact_uop_mem_0_rob_compact_uop_rdata_en_pipe_0;
  assign rob_compact_uop_mem_0_rob_compact_uop_rdata_addr = rob_compact_uop_mem_0_rob_compact_uop_rdata_addr_pipe_0;
  assign rob_compact_uop_mem_0_rob_compact_uop_rdata_data =
    rob_compact_uop_mem_0[rob_compact_uop_mem_0_rob_compact_uop_rdata_addr]; // @[RobUopStorage.scala 36:40]
  assign rob_compact_uop_mem_0_MPORT_data = rob_compact_uop_wdata_0[1:0];
  assign rob_compact_uop_mem_0_MPORT_addr = io_rob_tail;
  assign rob_compact_uop_mem_0_MPORT_mask = io_enq_valids_0;
  assign rob_compact_uop_mem_0_MPORT_en = 1'h1;
  assign rob_compact_uop_mem_1_rob_compact_uop_rdata_en = rob_compact_uop_mem_1_rob_compact_uop_rdata_en_pipe_0;
  assign rob_compact_uop_mem_1_rob_compact_uop_rdata_addr = rob_compact_uop_mem_1_rob_compact_uop_rdata_addr_pipe_0;
  assign rob_compact_uop_mem_1_rob_compact_uop_rdata_data =
    rob_compact_uop_mem_1[rob_compact_uop_mem_1_rob_compact_uop_rdata_addr]; // @[RobUopStorage.scala 36:40]
  assign rob_compact_uop_mem_1_MPORT_data = rob_compact_uop_wdata_1[1:0];
  assign rob_compact_uop_mem_1_MPORT_addr = io_rob_tail;
  assign rob_compact_uop_mem_1_MPORT_mask = io_enq_valids_1;
  assign rob_compact_uop_mem_1_MPORT_en = 1'h1;
  assign io_rob_compact_uop_rdata_0_valid = _rob_compact_uop_bypassed_T_5[12]; // @[RobUopStorage.scala 48:15]
  assign io_rob_compact_uop_rdata_0_opcode = _rob_compact_uop_bypassed_T_5[11:5]; // @[RobUopStorage.scala 48:15]
  assign io_rob_compact_uop_rdata_0_dst = _rob_compact_uop_bypassed_T_5[4:0]; // @[RobUopStorage.scala 48:15]
  assign io_rob_compact_uop_rdata_1_valid = _rob_compact_uop_bypassed_T_14[12]; // @[RobUopStorage.scala 48:15]
  assign io_rob_compact_uop_rdata_1_opcode = _rob_compact_uop_bypassed_T_14[11:5]; // @[RobUopStorage.scala 48:15]
  assign io_rob_compact_uop_rdata_1_dst = _rob_compact_uop_bypassed_T_14[4:0]; // @[RobUopStorage.scala 48:15]
  always @(posedge clock) begin
    if (rob_compact_uop_mem_0_MPORT_en & rob_compact_uop_mem_0_MPORT_mask) begin
      rob_compact_uop_mem_0[rob_compact_uop_mem_0_MPORT_addr] <= rob_compact_uop_mem_0_MPORT_data; // @[RobUopStorage.scala 36:40]
    end
    rob_compact_uop_mem_0_rob_compact_uop_rdata_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      rob_compact_uop_mem_0_rob_compact_uop_rdata_addr_pipe_0 <= io_next_rob_head;
    end
    if (rob_compact_uop_mem_1_MPORT_en & rob_compact_uop_mem_1_MPORT_mask) begin
      rob_compact_uop_mem_1[rob_compact_uop_mem_1_MPORT_addr] <= rob_compact_uop_mem_1_MPORT_data; // @[RobUopStorage.scala 36:40]
    end
    rob_compact_uop_mem_1_rob_compact_uop_rdata_en_pipe_0 <= 1'h1;
    if (1'h1) begin
      rob_compact_uop_mem_1_rob_compact_uop_rdata_addr_pipe_0 <= io_next_rob_head;
    end
    if (reset) begin // @[RobUopStorage.scala 33:29]
      rob_head <= 1'h0; // @[RobUopStorage.scala 33:29]
    end else begin
      rob_head <= io_next_rob_head; // @[RobUopStorage.scala 34:12]
    end
    rob_compact_uop_bypassed_REG <= io_rob_tail; // @[RobUopStorage.scala 42:29]
    rob_compact_uop_bypassed_REG_1 <= io_enq_valids_0; // @[RobUopStorage.scala 42:53]
    rob_compact_uop_bypassed_REG_2 <= {rob_compact_uop_wdata_hi,io_enq_uops_0_dst}; // @[RobUopStorage.scala 37:78]
    rob_compact_uop_bypassed_r <= io_rob_tail; // @[Reg.scala 19:16 20:{18,22}]
    rob_compact_uop_bypassed_r_1 <= rob_compact_uop_bypassed_r; // @[Reg.scala 19:16 20:{18,22}]
    rob_compact_uop_bypassed_r_2 <= io_enq_valids_0; // @[Reg.scala 19:16 20:{18,22}]
    rob_compact_uop_bypassed_r_3 <= rob_compact_uop_bypassed_r_2; // @[Reg.scala 19:16 20:{18,22}]
    rob_compact_uop_bypassed_r_4 <= {rob_compact_uop_wdata_hi,io_enq_uops_0_dst}; // @[RobUopStorage.scala 37:78]
    rob_compact_uop_bypassed_r_5 <= rob_compact_uop_bypassed_r_4; // @[Reg.scala 19:16 20:{18,22}]
    rob_compact_uop_bypassed_REG_3 <= io_rob_tail; // @[RobUopStorage.scala 42:29]
    rob_compact_uop_bypassed_REG_4 <= io_enq_valids_1; // @[RobUopStorage.scala 42:53]
    rob_compact_uop_bypassed_REG_5 <= {rob_compact_uop_wdata_hi_1,io_enq_uops_1_dst}; // @[RobUopStorage.scala 37:78]
    rob_compact_uop_bypassed_r_6 <= io_rob_tail; // @[Reg.scala 19:16 20:{18,22}]
    rob_compact_uop_bypassed_r_7 <= rob_compact_uop_bypassed_r_6; // @[Reg.scala 19:16 20:{18,22}]
    rob_compact_uop_bypassed_r_8 <= io_enq_valids_1; // @[Reg.scala 19:16 20:{18,22}]
    rob_compact_uop_bypassed_r_9 <= rob_compact_uop_bypassed_r_8; // @[Reg.scala 19:16 20:{18,22}]
    rob_compact_uop_bypassed_r_10 <= {rob_compact_uop_wdata_hi_1,io_enq_uops_1_dst}; // @[RobUopStorage.scala 37:78]
    rob_compact_uop_bypassed_r_11 <= rob_compact_uop_bypassed_r_10; // @[Reg.scala 19:16 20:{18,22}]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    rob_compact_uop_mem_0[initvar] = _RAND_0[1:0];
  _RAND_3 = {1{`RANDOM}};
  for (initvar = 0; initvar < 2; initvar = initvar+1)
    rob_compact_uop_mem_1[initvar] = _RAND_3[1:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  rob_compact_uop_mem_0_rob_compact_uop_rdata_en_pipe_0 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  rob_compact_uop_mem_0_rob_compact_uop_rdata_addr_pipe_0 = _RAND_2[0:0];
  _RAND_4 = {1{`RANDOM}};
  rob_compact_uop_mem_1_rob_compact_uop_rdata_en_pipe_0 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  rob_compact_uop_mem_1_rob_compact_uop_rdata_addr_pipe_0 = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  rob_head = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  rob_compact_uop_bypassed_REG = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  rob_compact_uop_bypassed_REG_1 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  rob_compact_uop_bypassed_REG_2 = _RAND_9[12:0];
  _RAND_10 = {1{`RANDOM}};
  rob_compact_uop_bypassed_r = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  rob_compact_uop_bypassed_r_1 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  rob_compact_uop_bypassed_r_2 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  rob_compact_uop_bypassed_r_3 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  rob_compact_uop_bypassed_r_4 = _RAND_14[12:0];
  _RAND_15 = {1{`RANDOM}};
  rob_compact_uop_bypassed_r_5 = _RAND_15[12:0];
  _RAND_16 = {1{`RANDOM}};
  rob_compact_uop_bypassed_REG_3 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  rob_compact_uop_bypassed_REG_4 = _RAND_17[0:0];
  _RAND_18 = {1{`RANDOM}};
  rob_compact_uop_bypassed_REG_5 = _RAND_18[12:0];
  _RAND_19 = {1{`RANDOM}};
  rob_compact_uop_bypassed_r_6 = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  rob_compact_uop_bypassed_r_7 = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  rob_compact_uop_bypassed_r_8 = _RAND_21[0:0];
  _RAND_22 = {1{`RANDOM}};
  rob_compact_uop_bypassed_r_9 = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  rob_compact_uop_bypassed_r_10 = _RAND_23[12:0];
  _RAND_24 = {1{`RANDOM}};
  rob_compact_uop_bypassed_r_11 = _RAND_24[12:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
