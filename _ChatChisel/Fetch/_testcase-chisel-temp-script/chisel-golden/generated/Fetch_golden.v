module BHT_golden(
  input         clock,
  input  [31:0] io_pc,
  input  [31:0] io_mem_pc,
  input         io_pcsrc,
  input  [31:0] io_target_pc,
  output        io_matched,
  output        io_valid,
  output [31:0] io_bht_pred_pc
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_MEM_INIT
  reg [25:0] bhtTable_tag [0:15]; // @[BHT.scala 24:21]
  wire  bhtTable_tag_bhtEntry_en; // @[BHT.scala 24:21]
  wire [3:0] bhtTable_tag_bhtEntry_addr; // @[BHT.scala 24:21]
  wire [25:0] bhtTable_tag_bhtEntry_data; // @[BHT.scala 24:21]
  wire [25:0] bhtTable_tag_MPORT_data; // @[BHT.scala 24:21]
  wire [3:0] bhtTable_tag_MPORT_addr; // @[BHT.scala 24:21]
  wire  bhtTable_tag_MPORT_mask; // @[BHT.scala 24:21]
  wire  bhtTable_tag_MPORT_en; // @[BHT.scala 24:21]
  reg  bhtTable_valid [0:15]; // @[BHT.scala 24:21]
  wire  bhtTable_valid_bhtEntry_en; // @[BHT.scala 24:21]
  wire [3:0] bhtTable_valid_bhtEntry_addr; // @[BHT.scala 24:21]
  wire  bhtTable_valid_bhtEntry_data; // @[BHT.scala 24:21]
  wire  bhtTable_valid_MPORT_data; // @[BHT.scala 24:21]
  wire [3:0] bhtTable_valid_MPORT_addr; // @[BHT.scala 24:21]
  wire  bhtTable_valid_MPORT_mask; // @[BHT.scala 24:21]
  wire  bhtTable_valid_MPORT_en; // @[BHT.scala 24:21]
  reg [31:0] bhtTable_target_pc [0:15]; // @[BHT.scala 24:21]
  wire  bhtTable_target_pc_bhtEntry_en; // @[BHT.scala 24:21]
  wire [3:0] bhtTable_target_pc_bhtEntry_addr; // @[BHT.scala 24:21]
  wire [31:0] bhtTable_target_pc_bhtEntry_data; // @[BHT.scala 24:21]
  wire [31:0] bhtTable_target_pc_MPORT_data; // @[BHT.scala 24:21]
  wire [3:0] bhtTable_target_pc_MPORT_addr; // @[BHT.scala 24:21]
  wire  bhtTable_target_pc_MPORT_mask; // @[BHT.scala 24:21]
  wire  bhtTable_target_pc_MPORT_en; // @[BHT.scala 24:21]
  assign bhtTable_tag_bhtEntry_en = 1'h1;
  assign bhtTable_tag_bhtEntry_addr = io_pc[5:2];
  assign bhtTable_tag_bhtEntry_data = bhtTable_tag[bhtTable_tag_bhtEntry_addr]; // @[BHT.scala 24:21]
  assign bhtTable_tag_MPORT_data = io_mem_pc[31:6];
  assign bhtTable_tag_MPORT_addr = io_mem_pc[5:2];
  assign bhtTable_tag_MPORT_mask = 1'h1;
  assign bhtTable_tag_MPORT_en = io_pcsrc;
  assign bhtTable_valid_bhtEntry_en = 1'h1;
  assign bhtTable_valid_bhtEntry_addr = io_pc[5:2];
  assign bhtTable_valid_bhtEntry_data = bhtTable_valid[bhtTable_valid_bhtEntry_addr]; // @[BHT.scala 24:21]
  assign bhtTable_valid_MPORT_data = 1'h1;
  assign bhtTable_valid_MPORT_addr = io_mem_pc[5:2];
  assign bhtTable_valid_MPORT_mask = 1'h1;
  assign bhtTable_valid_MPORT_en = io_pcsrc;
  assign bhtTable_target_pc_bhtEntry_en = 1'h1;
  assign bhtTable_target_pc_bhtEntry_addr = io_pc[5:2];
  assign bhtTable_target_pc_bhtEntry_data = bhtTable_target_pc[bhtTable_target_pc_bhtEntry_addr]; // @[BHT.scala 24:21]
  assign bhtTable_target_pc_MPORT_data = io_target_pc;
  assign bhtTable_target_pc_MPORT_addr = io_mem_pc[5:2];
  assign bhtTable_target_pc_MPORT_mask = 1'h1;
  assign bhtTable_target_pc_MPORT_en = io_pcsrc;
  assign io_matched = bhtTable_tag_bhtEntry_data == io_pc[31:6]; // @[BHT.scala 30:30]
  assign io_valid = bhtTable_valid_bhtEntry_data; // @[BHT.scala 31:12]
  assign io_bht_pred_pc = bhtTable_target_pc_bhtEntry_data; // @[BHT.scala 32:18]
  always @(posedge clock) begin
    if (bhtTable_tag_MPORT_en & bhtTable_tag_MPORT_mask) begin
      bhtTable_tag[bhtTable_tag_MPORT_addr] <= bhtTable_tag_MPORT_data; // @[BHT.scala 24:21]
    end
    if (bhtTable_valid_MPORT_en & bhtTable_valid_MPORT_mask) begin
      bhtTable_valid[bhtTable_valid_MPORT_addr] <= bhtTable_valid_MPORT_data; // @[BHT.scala 24:21]
    end
    if (bhtTable_target_pc_MPORT_en & bhtTable_target_pc_MPORT_mask) begin
      bhtTable_target_pc[bhtTable_target_pc_MPORT_addr] <= bhtTable_target_pc_MPORT_data; // @[BHT.scala 24:21]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    bhtTable_tag[initvar] = _RAND_0[25:0];
  _RAND_1 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    bhtTable_valid[initvar] = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    bhtTable_target_pc[initvar] = _RAND_2[31:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BTB_golden(
  input         clock,
  input         reset,
  input  [31:0] io_pc,
  input  [31:0] io_mem_pc,
  input         io_pcsrc,
  input         io_branch,
  output        io_btb_taken
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
  reg [1:0] btbTable [0:15]; // @[BTB.scala 14:21]
  wire  btbTable_btbEntry_en; // @[BTB.scala 14:21]
  wire [3:0] btbTable_btbEntry_addr; // @[BTB.scala 14:21]
  wire [1:0] btbTable_btbEntry_data; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_16_en; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_16_addr; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_16_data; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_17_en; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_17_addr; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_17_data; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_19_en; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_19_addr; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_19_data; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_20_en; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_20_addr; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_20_data; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_1_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_1_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_1_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_1_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_2_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_2_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_2_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_2_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_3_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_3_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_3_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_3_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_4_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_4_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_4_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_4_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_5_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_5_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_5_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_5_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_6_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_6_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_6_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_6_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_7_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_7_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_7_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_7_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_8_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_8_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_8_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_8_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_9_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_9_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_9_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_9_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_10_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_10_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_10_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_10_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_11_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_11_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_11_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_11_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_12_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_12_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_12_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_12_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_13_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_13_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_13_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_13_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_14_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_14_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_14_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_14_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_15_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_15_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_15_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_15_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_18_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_18_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_18_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_18_en; // @[BTB.scala 14:21]
  wire [1:0] btbTable_MPORT_21_data; // @[BTB.scala 14:21]
  wire [3:0] btbTable_MPORT_21_addr; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_21_mask; // @[BTB.scala 14:21]
  wire  btbTable_MPORT_21_en; // @[BTB.scala 14:21]
  wire  _T_4 = btbTable_MPORT_16_data < 2'h3; // @[BTB.scala 33:38]
  wire  _T_10 = btbTable_MPORT_19_data > 2'h0; // @[BTB.scala 38:38]
  wire  _GEN_35 = io_pcsrc & _T_4; // @[BTB.scala 14:21 31:28]
  wire  _GEN_41 = io_pcsrc ? 1'h0 : 1'h1; // @[BTB.scala 14:21 31:28 38:20]
  wire  _GEN_44 = io_pcsrc ? 1'h0 : _T_10; // @[BTB.scala 14:21 31:28]
  assign btbTable_btbEntry_en = 1'h1;
  assign btbTable_btbEntry_addr = io_pc[5:2];
  assign btbTable_btbEntry_data = btbTable[btbTable_btbEntry_addr]; // @[BTB.scala 14:21]
  assign btbTable_MPORT_16_en = io_branch & io_pcsrc;
  assign btbTable_MPORT_16_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_16_data = btbTable[btbTable_MPORT_16_addr]; // @[BTB.scala 14:21]
  assign btbTable_MPORT_17_en = io_branch & _GEN_35;
  assign btbTable_MPORT_17_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_17_data = btbTable[btbTable_MPORT_17_addr]; // @[BTB.scala 14:21]
  assign btbTable_MPORT_19_en = io_branch & _GEN_41;
  assign btbTable_MPORT_19_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_19_data = btbTable[btbTable_MPORT_19_addr]; // @[BTB.scala 14:21]
  assign btbTable_MPORT_20_en = io_branch & _GEN_44;
  assign btbTable_MPORT_20_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_20_data = btbTable[btbTable_MPORT_20_addr]; // @[BTB.scala 14:21]
  assign btbTable_MPORT_data = 2'h0;
  assign btbTable_MPORT_addr = 4'h0;
  assign btbTable_MPORT_mask = 1'h1;
  assign btbTable_MPORT_en = reset;
  assign btbTable_MPORT_1_data = 2'h0;
  assign btbTable_MPORT_1_addr = 4'h1;
  assign btbTable_MPORT_1_mask = 1'h1;
  assign btbTable_MPORT_1_en = reset;
  assign btbTable_MPORT_2_data = 2'h0;
  assign btbTable_MPORT_2_addr = 4'h2;
  assign btbTable_MPORT_2_mask = 1'h1;
  assign btbTable_MPORT_2_en = reset;
  assign btbTable_MPORT_3_data = 2'h0;
  assign btbTable_MPORT_3_addr = 4'h3;
  assign btbTable_MPORT_3_mask = 1'h1;
  assign btbTable_MPORT_3_en = reset;
  assign btbTable_MPORT_4_data = 2'h0;
  assign btbTable_MPORT_4_addr = 4'h4;
  assign btbTable_MPORT_4_mask = 1'h1;
  assign btbTable_MPORT_4_en = reset;
  assign btbTable_MPORT_5_data = 2'h0;
  assign btbTable_MPORT_5_addr = 4'h5;
  assign btbTable_MPORT_5_mask = 1'h1;
  assign btbTable_MPORT_5_en = reset;
  assign btbTable_MPORT_6_data = 2'h0;
  assign btbTable_MPORT_6_addr = 4'h6;
  assign btbTable_MPORT_6_mask = 1'h1;
  assign btbTable_MPORT_6_en = reset;
  assign btbTable_MPORT_7_data = 2'h0;
  assign btbTable_MPORT_7_addr = 4'h7;
  assign btbTable_MPORT_7_mask = 1'h1;
  assign btbTable_MPORT_7_en = reset;
  assign btbTable_MPORT_8_data = 2'h0;
  assign btbTable_MPORT_8_addr = 4'h8;
  assign btbTable_MPORT_8_mask = 1'h1;
  assign btbTable_MPORT_8_en = reset;
  assign btbTable_MPORT_9_data = 2'h0;
  assign btbTable_MPORT_9_addr = 4'h9;
  assign btbTable_MPORT_9_mask = 1'h1;
  assign btbTable_MPORT_9_en = reset;
  assign btbTable_MPORT_10_data = 2'h0;
  assign btbTable_MPORT_10_addr = 4'ha;
  assign btbTable_MPORT_10_mask = 1'h1;
  assign btbTable_MPORT_10_en = reset;
  assign btbTable_MPORT_11_data = 2'h0;
  assign btbTable_MPORT_11_addr = 4'hb;
  assign btbTable_MPORT_11_mask = 1'h1;
  assign btbTable_MPORT_11_en = reset;
  assign btbTable_MPORT_12_data = 2'h0;
  assign btbTable_MPORT_12_addr = 4'hc;
  assign btbTable_MPORT_12_mask = 1'h1;
  assign btbTable_MPORT_12_en = reset;
  assign btbTable_MPORT_13_data = 2'h0;
  assign btbTable_MPORT_13_addr = 4'hd;
  assign btbTable_MPORT_13_mask = 1'h1;
  assign btbTable_MPORT_13_en = reset;
  assign btbTable_MPORT_14_data = 2'h0;
  assign btbTable_MPORT_14_addr = 4'he;
  assign btbTable_MPORT_14_mask = 1'h1;
  assign btbTable_MPORT_14_en = reset;
  assign btbTable_MPORT_15_data = 2'h0;
  assign btbTable_MPORT_15_addr = 4'hf;
  assign btbTable_MPORT_15_mask = 1'h1;
  assign btbTable_MPORT_15_en = reset;
  assign btbTable_MPORT_18_data = btbTable_MPORT_17_data + 2'h1;
  assign btbTable_MPORT_18_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_18_mask = 1'h1;
  assign btbTable_MPORT_18_en = io_branch & _GEN_35;
  assign btbTable_MPORT_21_data = btbTable_MPORT_20_data - 2'h1;
  assign btbTable_MPORT_21_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_21_mask = 1'h1;
  assign btbTable_MPORT_21_en = io_branch & _GEN_44;
  assign io_btb_taken = btbTable_btbEntry_data[1]; // @[BTB.scala 27:28]
  always @(posedge clock) begin
    if (btbTable_MPORT_en & btbTable_MPORT_mask) begin
      btbTable[btbTable_MPORT_addr] <= btbTable_MPORT_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_1_en & btbTable_MPORT_1_mask) begin
      btbTable[btbTable_MPORT_1_addr] <= btbTable_MPORT_1_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_2_en & btbTable_MPORT_2_mask) begin
      btbTable[btbTable_MPORT_2_addr] <= btbTable_MPORT_2_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_3_en & btbTable_MPORT_3_mask) begin
      btbTable[btbTable_MPORT_3_addr] <= btbTable_MPORT_3_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_4_en & btbTable_MPORT_4_mask) begin
      btbTable[btbTable_MPORT_4_addr] <= btbTable_MPORT_4_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_5_en & btbTable_MPORT_5_mask) begin
      btbTable[btbTable_MPORT_5_addr] <= btbTable_MPORT_5_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_6_en & btbTable_MPORT_6_mask) begin
      btbTable[btbTable_MPORT_6_addr] <= btbTable_MPORT_6_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_7_en & btbTable_MPORT_7_mask) begin
      btbTable[btbTable_MPORT_7_addr] <= btbTable_MPORT_7_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_8_en & btbTable_MPORT_8_mask) begin
      btbTable[btbTable_MPORT_8_addr] <= btbTable_MPORT_8_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_9_en & btbTable_MPORT_9_mask) begin
      btbTable[btbTable_MPORT_9_addr] <= btbTable_MPORT_9_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_10_en & btbTable_MPORT_10_mask) begin
      btbTable[btbTable_MPORT_10_addr] <= btbTable_MPORT_10_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_11_en & btbTable_MPORT_11_mask) begin
      btbTable[btbTable_MPORT_11_addr] <= btbTable_MPORT_11_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_12_en & btbTable_MPORT_12_mask) begin
      btbTable[btbTable_MPORT_12_addr] <= btbTable_MPORT_12_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_13_en & btbTable_MPORT_13_mask) begin
      btbTable[btbTable_MPORT_13_addr] <= btbTable_MPORT_13_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_14_en & btbTable_MPORT_14_mask) begin
      btbTable[btbTable_MPORT_14_addr] <= btbTable_MPORT_14_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_15_en & btbTable_MPORT_15_mask) begin
      btbTable[btbTable_MPORT_15_addr] <= btbTable_MPORT_15_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_18_en & btbTable_MPORT_18_mask) begin
      btbTable[btbTable_MPORT_18_addr] <= btbTable_MPORT_18_data; // @[BTB.scala 14:21]
    end
    if (btbTable_MPORT_21_en & btbTable_MPORT_21_mask) begin
      btbTable[btbTable_MPORT_21_addr] <= btbTable_MPORT_21_data; // @[BTB.scala 14:21]
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
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    btbTable[initvar] = _RAND_0[1:0];
`endif // RANDOMIZE_MEM_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Fetch_golden(
  input         clock,
  input         reset,
  input  [31:0] io_trap_vector,
  input  [31:0] io_mret_vector,
  input  [31:0] io_target_pc,
  input  [31:0] io_mem_pc,
  input         io_pcsrc,
  input         io_branch,
  input         io_trap,
  input         io_mret,
  input         io_pc_stall,
  input         io_if_id_stall,
  input         io_if_id_flush,
  input         io_predict,
  output [31:0] io_id_pc,
  output [31:0] io_inst,
  input  [31:0] io_fetch_data,
  output [31:0] io_fetch_address
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  bht_clock; // @[Fetch.scala 32:19]
  wire [31:0] bht_io_pc; // @[Fetch.scala 32:19]
  wire [31:0] bht_io_mem_pc; // @[Fetch.scala 32:19]
  wire  bht_io_pcsrc; // @[Fetch.scala 32:19]
  wire [31:0] bht_io_target_pc; // @[Fetch.scala 32:19]
  wire  bht_io_matched; // @[Fetch.scala 32:19]
  wire  bht_io_valid; // @[Fetch.scala 32:19]
  wire [31:0] bht_io_bht_pred_pc; // @[Fetch.scala 32:19]
  wire  btb_clock; // @[Fetch.scala 33:19]
  wire  btb_reset; // @[Fetch.scala 33:19]
  wire [31:0] btb_io_pc; // @[Fetch.scala 33:19]
  wire [31:0] btb_io_mem_pc; // @[Fetch.scala 33:19]
  wire  btb_io_pcsrc; // @[Fetch.scala 33:19]
  wire  btb_io_branch; // @[Fetch.scala 33:19]
  wire  btb_io_btb_taken; // @[Fetch.scala 33:19]
  reg [31:0] pcReg; // @[Fetch.scala 36:22]
  reg [31:0] idPcReg; // @[Fetch.scala 37:24]
  reg [31:0] instReg; // @[Fetch.scala 38:24]
  wire [31:0] _pcReg_T_1 = pcReg + 32'h4; // @[Fetch.scala 65:20]
  wire [31:0] _GEN_0 = btb_io_btb_taken & bht_io_valid & bht_io_matched ? bht_io_bht_pred_pc : _pcReg_T_1; // @[Fetch.scala 62:74 63:11 65:11]
  wire [31:0] _GEN_1 = io_pc_stall ? pcReg : _GEN_0; // @[Fetch.scala 60:27 61:11]
  BHT_golden bht ( // @[Fetch.scala 32:19]
    .clock(bht_clock),
    .io_pc(bht_io_pc),
    .io_mem_pc(bht_io_mem_pc),
    .io_pcsrc(bht_io_pcsrc),
    .io_target_pc(bht_io_target_pc),
    .io_matched(bht_io_matched),
    .io_valid(bht_io_valid),
    .io_bht_pred_pc(bht_io_bht_pred_pc)
  );
  BTB_golden btb ( // @[Fetch.scala 33:19]
    .clock(btb_clock),
    .reset(btb_reset),
    .io_pc(btb_io_pc),
    .io_mem_pc(btb_io_mem_pc),
    .io_pcsrc(btb_io_pcsrc),
    .io_branch(btb_io_branch),
    .io_btb_taken(btb_io_btb_taken)
  );
  assign io_id_pc = idPcReg; // @[Fetch.scala 83:12]
  assign io_inst = instReg; // @[Fetch.scala 84:11]
  assign io_fetch_address = pcReg; // @[Fetch.scala 82:20]
  assign bht_clock = clock;
  assign bht_io_pc = pcReg; // @[Fetch.scala 41:13]
  assign bht_io_mem_pc = io_mem_pc; // @[Fetch.scala 42:17]
  assign bht_io_pcsrc = io_pcsrc; // @[Fetch.scala 43:16]
  assign bht_io_target_pc = io_target_pc; // @[Fetch.scala 44:20]
  assign btb_clock = clock;
  assign btb_reset = reset;
  assign btb_io_pc = pcReg; // @[Fetch.scala 46:13]
  assign btb_io_mem_pc = io_mem_pc; // @[Fetch.scala 47:17]
  assign btb_io_pcsrc = io_pcsrc; // @[Fetch.scala 48:16]
  assign btb_io_branch = io_branch; // @[Fetch.scala 49:17]
  always @(posedge clock) begin
    if (reset) begin // @[Fetch.scala 36:22]
      pcReg <= 32'h8; // @[Fetch.scala 36:22]
    end else if (io_trap) begin // @[Fetch.scala 54:17]
      pcReg <= io_trap_vector; // @[Fetch.scala 55:11]
    end else if (io_mret) begin // @[Fetch.scala 56:23]
      pcReg <= io_mret_vector; // @[Fetch.scala 57:11]
    end else if (io_pcsrc & ~io_predict) begin // @[Fetch.scala 58:39]
      pcReg <= io_target_pc; // @[Fetch.scala 59:11]
    end else begin
      pcReg <= _GEN_1;
    end
    if (reset) begin // @[Fetch.scala 37:24]
      idPcReg <= 32'h0; // @[Fetch.scala 37:24]
    end else if (io_if_id_flush) begin // @[Fetch.scala 77:24]
      idPcReg <= 32'h0; // @[Fetch.scala 78:13]
    end else if (!(io_if_id_stall)) begin // @[Fetch.scala 69:24]
      idPcReg <= pcReg; // @[Fetch.scala 73:13]
    end
    if (reset) begin // @[Fetch.scala 38:24]
      instReg <= 32'h0; // @[Fetch.scala 38:24]
    end else if (io_if_id_flush) begin // @[Fetch.scala 77:24]
      instReg <= 32'h13; // @[Fetch.scala 79:13]
    end else if (!(io_if_id_stall)) begin // @[Fetch.scala 69:24]
      instReg <= io_fetch_data; // @[Fetch.scala 74:13]
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
  pcReg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  idPcReg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  instReg = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
