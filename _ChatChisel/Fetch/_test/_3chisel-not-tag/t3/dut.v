module BHT(
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
  reg [25:0] bhtTable_tag [0:15]; // @[driver.scala 28:21]
  wire  bhtTable_tag_bhtEntry_en; // @[driver.scala 28:21]
  wire [3:0] bhtTable_tag_bhtEntry_addr; // @[driver.scala 28:21]
  wire [25:0] bhtTable_tag_bhtEntry_data; // @[driver.scala 28:21]
  wire [25:0] bhtTable_tag_MPORT_data; // @[driver.scala 28:21]
  wire [3:0] bhtTable_tag_MPORT_addr; // @[driver.scala 28:21]
  wire  bhtTable_tag_MPORT_mask; // @[driver.scala 28:21]
  wire  bhtTable_tag_MPORT_en; // @[driver.scala 28:21]
  reg  bhtTable_valid [0:15]; // @[driver.scala 28:21]
  wire  bhtTable_valid_bhtEntry_en; // @[driver.scala 28:21]
  wire [3:0] bhtTable_valid_bhtEntry_addr; // @[driver.scala 28:21]
  wire  bhtTable_valid_bhtEntry_data; // @[driver.scala 28:21]
  wire  bhtTable_valid_MPORT_data; // @[driver.scala 28:21]
  wire [3:0] bhtTable_valid_MPORT_addr; // @[driver.scala 28:21]
  wire  bhtTable_valid_MPORT_mask; // @[driver.scala 28:21]
  wire  bhtTable_valid_MPORT_en; // @[driver.scala 28:21]
  reg [31:0] bhtTable_target_pc [0:15]; // @[driver.scala 28:21]
  wire  bhtTable_target_pc_bhtEntry_en; // @[driver.scala 28:21]
  wire [3:0] bhtTable_target_pc_bhtEntry_addr; // @[driver.scala 28:21]
  wire [31:0] bhtTable_target_pc_bhtEntry_data; // @[driver.scala 28:21]
  wire [31:0] bhtTable_target_pc_MPORT_data; // @[driver.scala 28:21]
  wire [3:0] bhtTable_target_pc_MPORT_addr; // @[driver.scala 28:21]
  wire  bhtTable_target_pc_MPORT_mask; // @[driver.scala 28:21]
  wire  bhtTable_target_pc_MPORT_en; // @[driver.scala 28:21]
  assign bhtTable_tag_bhtEntry_en = 1'h1;
  assign bhtTable_tag_bhtEntry_addr = io_pc[5:2];
  assign bhtTable_tag_bhtEntry_data = bhtTable_tag[bhtTable_tag_bhtEntry_addr]; // @[driver.scala 28:21]
  assign bhtTable_tag_MPORT_data = io_mem_pc[31:6];
  assign bhtTable_tag_MPORT_addr = io_mem_pc[5:2];
  assign bhtTable_tag_MPORT_mask = 1'h1;
  assign bhtTable_tag_MPORT_en = io_pcsrc;
  assign bhtTable_valid_bhtEntry_en = 1'h1;
  assign bhtTable_valid_bhtEntry_addr = io_pc[5:2];
  assign bhtTable_valid_bhtEntry_data = bhtTable_valid[bhtTable_valid_bhtEntry_addr]; // @[driver.scala 28:21]
  assign bhtTable_valid_MPORT_data = 1'h1;
  assign bhtTable_valid_MPORT_addr = io_mem_pc[5:2];
  assign bhtTable_valid_MPORT_mask = 1'h1;
  assign bhtTable_valid_MPORT_en = io_pcsrc;
  assign bhtTable_target_pc_bhtEntry_en = 1'h1;
  assign bhtTable_target_pc_bhtEntry_addr = io_pc[5:2];
  assign bhtTable_target_pc_bhtEntry_data = bhtTable_target_pc[bhtTable_target_pc_bhtEntry_addr]; // @[driver.scala 28:21]
  assign bhtTable_target_pc_MPORT_data = io_target_pc;
  assign bhtTable_target_pc_MPORT_addr = io_mem_pc[5:2];
  assign bhtTable_target_pc_MPORT_mask = 1'h1;
  assign bhtTable_target_pc_MPORT_en = io_pcsrc;
  assign io_matched = bhtTable_tag_bhtEntry_data == io_pc[31:6]; // @[driver.scala 35:30]
  assign io_valid = bhtTable_valid_bhtEntry_data; // @[driver.scala 36:12]
  assign io_bht_pred_pc = bhtTable_target_pc_bhtEntry_data; // @[driver.scala 37:18]
  always @(posedge clock) begin
    if (bhtTable_tag_MPORT_en & bhtTable_tag_MPORT_mask) begin
      bhtTable_tag[bhtTable_tag_MPORT_addr] <= bhtTable_tag_MPORT_data; // @[driver.scala 28:21]
    end
    if (bhtTable_valid_MPORT_en & bhtTable_valid_MPORT_mask) begin
      bhtTable_valid[bhtTable_valid_MPORT_addr] <= bhtTable_valid_MPORT_data; // @[driver.scala 28:21]
    end
    if (bhtTable_target_pc_MPORT_en & bhtTable_target_pc_MPORT_mask) begin
      bhtTable_target_pc[bhtTable_target_pc_MPORT_addr] <= bhtTable_target_pc_MPORT_data; // @[driver.scala 28:21]
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
module BTB(
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
  reg [1:0] btbTable [0:15]; // @[driver.scala 58:21]
  wire  btbTable_btbEntry_en; // @[driver.scala 58:21]
  wire [3:0] btbTable_btbEntry_addr; // @[driver.scala 58:21]
  wire [1:0] btbTable_btbEntry_data; // @[driver.scala 58:21]
  wire  btbTable_MPORT_16_en; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_16_addr; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_16_data; // @[driver.scala 58:21]
  wire  btbTable_MPORT_17_en; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_17_addr; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_17_data; // @[driver.scala 58:21]
  wire  btbTable_MPORT_19_en; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_19_addr; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_19_data; // @[driver.scala 58:21]
  wire  btbTable_MPORT_20_en; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_20_addr; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_20_data; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_data; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_addr; // @[driver.scala 58:21]
  wire  btbTable_MPORT_mask; // @[driver.scala 58:21]
  wire  btbTable_MPORT_en; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_1_data; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_1_addr; // @[driver.scala 58:21]
  wire  btbTable_MPORT_1_mask; // @[driver.scala 58:21]
  wire  btbTable_MPORT_1_en; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_2_data; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_2_addr; // @[driver.scala 58:21]
  wire  btbTable_MPORT_2_mask; // @[driver.scala 58:21]
  wire  btbTable_MPORT_2_en; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_3_data; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_3_addr; // @[driver.scala 58:21]
  wire  btbTable_MPORT_3_mask; // @[driver.scala 58:21]
  wire  btbTable_MPORT_3_en; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_4_data; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_4_addr; // @[driver.scala 58:21]
  wire  btbTable_MPORT_4_mask; // @[driver.scala 58:21]
  wire  btbTable_MPORT_4_en; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_5_data; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_5_addr; // @[driver.scala 58:21]
  wire  btbTable_MPORT_5_mask; // @[driver.scala 58:21]
  wire  btbTable_MPORT_5_en; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_6_data; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_6_addr; // @[driver.scala 58:21]
  wire  btbTable_MPORT_6_mask; // @[driver.scala 58:21]
  wire  btbTable_MPORT_6_en; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_7_data; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_7_addr; // @[driver.scala 58:21]
  wire  btbTable_MPORT_7_mask; // @[driver.scala 58:21]
  wire  btbTable_MPORT_7_en; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_8_data; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_8_addr; // @[driver.scala 58:21]
  wire  btbTable_MPORT_8_mask; // @[driver.scala 58:21]
  wire  btbTable_MPORT_8_en; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_9_data; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_9_addr; // @[driver.scala 58:21]
  wire  btbTable_MPORT_9_mask; // @[driver.scala 58:21]
  wire  btbTable_MPORT_9_en; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_10_data; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_10_addr; // @[driver.scala 58:21]
  wire  btbTable_MPORT_10_mask; // @[driver.scala 58:21]
  wire  btbTable_MPORT_10_en; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_11_data; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_11_addr; // @[driver.scala 58:21]
  wire  btbTable_MPORT_11_mask; // @[driver.scala 58:21]
  wire  btbTable_MPORT_11_en; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_12_data; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_12_addr; // @[driver.scala 58:21]
  wire  btbTable_MPORT_12_mask; // @[driver.scala 58:21]
  wire  btbTable_MPORT_12_en; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_13_data; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_13_addr; // @[driver.scala 58:21]
  wire  btbTable_MPORT_13_mask; // @[driver.scala 58:21]
  wire  btbTable_MPORT_13_en; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_14_data; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_14_addr; // @[driver.scala 58:21]
  wire  btbTable_MPORT_14_mask; // @[driver.scala 58:21]
  wire  btbTable_MPORT_14_en; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_15_data; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_15_addr; // @[driver.scala 58:21]
  wire  btbTable_MPORT_15_mask; // @[driver.scala 58:21]
  wire  btbTable_MPORT_15_en; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_18_data; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_18_addr; // @[driver.scala 58:21]
  wire  btbTable_MPORT_18_mask; // @[driver.scala 58:21]
  wire  btbTable_MPORT_18_en; // @[driver.scala 58:21]
  wire [1:0] btbTable_MPORT_21_data; // @[driver.scala 58:21]
  wire [3:0] btbTable_MPORT_21_addr; // @[driver.scala 58:21]
  wire  btbTable_MPORT_21_mask; // @[driver.scala 58:21]
  wire  btbTable_MPORT_21_en; // @[driver.scala 58:21]
  wire  _T_4 = btbTable_MPORT_16_data < 2'h3; // @[driver.scala 77:38]
  wire  _T_10 = btbTable_MPORT_19_data > 2'h0; // @[driver.scala 82:38]
  wire  _GEN_35 = io_pcsrc & _T_4; // @[driver.scala 58:21 75:28]
  wire  _GEN_41 = io_pcsrc ? 1'h0 : 1'h1; // @[driver.scala 58:21 75:28 82:20]
  wire  _GEN_44 = io_pcsrc ? 1'h0 : _T_10; // @[driver.scala 58:21 75:28]
  assign btbTable_btbEntry_en = 1'h1;
  assign btbTable_btbEntry_addr = io_pc[5:2];
  assign btbTable_btbEntry_data = btbTable[btbTable_btbEntry_addr]; // @[driver.scala 58:21]
  assign btbTable_MPORT_16_en = io_branch & io_pcsrc;
  assign btbTable_MPORT_16_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_16_data = btbTable[btbTable_MPORT_16_addr]; // @[driver.scala 58:21]
  assign btbTable_MPORT_17_en = io_branch & _GEN_35;
  assign btbTable_MPORT_17_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_17_data = btbTable[btbTable_MPORT_17_addr]; // @[driver.scala 58:21]
  assign btbTable_MPORT_19_en = io_branch & _GEN_41;
  assign btbTable_MPORT_19_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_19_data = btbTable[btbTable_MPORT_19_addr]; // @[driver.scala 58:21]
  assign btbTable_MPORT_20_en = io_branch & _GEN_44;
  assign btbTable_MPORT_20_addr = io_mem_pc[5:2];
  assign btbTable_MPORT_20_data = btbTable[btbTable_MPORT_20_addr]; // @[driver.scala 58:21]
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
  assign io_btb_taken = btbTable_btbEntry_data[1]; // @[driver.scala 71:28]
  always @(posedge clock) begin
    if (btbTable_MPORT_en & btbTable_MPORT_mask) begin
      btbTable[btbTable_MPORT_addr] <= btbTable_MPORT_data; // @[driver.scala 58:21]
    end
    if (btbTable_MPORT_1_en & btbTable_MPORT_1_mask) begin
      btbTable[btbTable_MPORT_1_addr] <= btbTable_MPORT_1_data; // @[driver.scala 58:21]
    end
    if (btbTable_MPORT_2_en & btbTable_MPORT_2_mask) begin
      btbTable[btbTable_MPORT_2_addr] <= btbTable_MPORT_2_data; // @[driver.scala 58:21]
    end
    if (btbTable_MPORT_3_en & btbTable_MPORT_3_mask) begin
      btbTable[btbTable_MPORT_3_addr] <= btbTable_MPORT_3_data; // @[driver.scala 58:21]
    end
    if (btbTable_MPORT_4_en & btbTable_MPORT_4_mask) begin
      btbTable[btbTable_MPORT_4_addr] <= btbTable_MPORT_4_data; // @[driver.scala 58:21]
    end
    if (btbTable_MPORT_5_en & btbTable_MPORT_5_mask) begin
      btbTable[btbTable_MPORT_5_addr] <= btbTable_MPORT_5_data; // @[driver.scala 58:21]
    end
    if (btbTable_MPORT_6_en & btbTable_MPORT_6_mask) begin
      btbTable[btbTable_MPORT_6_addr] <= btbTable_MPORT_6_data; // @[driver.scala 58:21]
    end
    if (btbTable_MPORT_7_en & btbTable_MPORT_7_mask) begin
      btbTable[btbTable_MPORT_7_addr] <= btbTable_MPORT_7_data; // @[driver.scala 58:21]
    end
    if (btbTable_MPORT_8_en & btbTable_MPORT_8_mask) begin
      btbTable[btbTable_MPORT_8_addr] <= btbTable_MPORT_8_data; // @[driver.scala 58:21]
    end
    if (btbTable_MPORT_9_en & btbTable_MPORT_9_mask) begin
      btbTable[btbTable_MPORT_9_addr] <= btbTable_MPORT_9_data; // @[driver.scala 58:21]
    end
    if (btbTable_MPORT_10_en & btbTable_MPORT_10_mask) begin
      btbTable[btbTable_MPORT_10_addr] <= btbTable_MPORT_10_data; // @[driver.scala 58:21]
    end
    if (btbTable_MPORT_11_en & btbTable_MPORT_11_mask) begin
      btbTable[btbTable_MPORT_11_addr] <= btbTable_MPORT_11_data; // @[driver.scala 58:21]
    end
    if (btbTable_MPORT_12_en & btbTable_MPORT_12_mask) begin
      btbTable[btbTable_MPORT_12_addr] <= btbTable_MPORT_12_data; // @[driver.scala 58:21]
    end
    if (btbTable_MPORT_13_en & btbTable_MPORT_13_mask) begin
      btbTable[btbTable_MPORT_13_addr] <= btbTable_MPORT_13_data; // @[driver.scala 58:21]
    end
    if (btbTable_MPORT_14_en & btbTable_MPORT_14_mask) begin
      btbTable[btbTable_MPORT_14_addr] <= btbTable_MPORT_14_data; // @[driver.scala 58:21]
    end
    if (btbTable_MPORT_15_en & btbTable_MPORT_15_mask) begin
      btbTable[btbTable_MPORT_15_addr] <= btbTable_MPORT_15_data; // @[driver.scala 58:21]
    end
    if (btbTable_MPORT_18_en & btbTable_MPORT_18_mask) begin
      btbTable[btbTable_MPORT_18_addr] <= btbTable_MPORT_18_data; // @[driver.scala 58:21]
    end
    if (btbTable_MPORT_21_en & btbTable_MPORT_21_mask) begin
      btbTable[btbTable_MPORT_21_addr] <= btbTable_MPORT_21_data; // @[driver.scala 58:21]
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
module dut(
  input         clock,
  input         reset,
  input  [31:0] io_trap_vector,
  input  [31:0] io_mert_vector,
  input  [31:0] io_target_pc,
  input  [31:0] io_mem_pc,
  input         io_pcsrc,
  input         io_branch,
  input         io_trap,
  input         io_mert,
  input         io_pc_stall,
  input         io_if_id_stall,
  input         io_if_id_flush,
  output [31:0] io_id_pc,
  output [31:0] io_inst,
  input  [31:0] io_fetch_data,
  output [31:0] io_fetch_address,
  input  [31:0] io_bht_pc,
  input  [31:0] io_bht_mem_pc,
  input         io_bht_pcsrc,
  input  [31:0] io_bht_target_pc,
  output        io_bht_matched,
  output        io_bht_valid,
  output [31:0] io_bht_bht_pred_pc,
  input  [31:0] io_btb_pc,
  input  [31:0] io_btb_mem_pc,
  input         io_btb_pcsrc,
  input         io_btb_branch,
  output        io_btb_btb_taken
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  bht_clock; // @[dut.scala 87:19]
  wire [31:0] bht_io_pc; // @[dut.scala 87:19]
  wire [31:0] bht_io_mem_pc; // @[dut.scala 87:19]
  wire  bht_io_pcsrc; // @[dut.scala 87:19]
  wire [31:0] bht_io_target_pc; // @[dut.scala 87:19]
  wire  bht_io_matched; // @[dut.scala 87:19]
  wire  bht_io_valid; // @[dut.scala 87:19]
  wire [31:0] bht_io_bht_pred_pc; // @[dut.scala 87:19]
  wire  btb_clock; // @[dut.scala 101:19]
  wire  btb_reset; // @[dut.scala 101:19]
  wire [31:0] btb_io_pc; // @[dut.scala 101:19]
  wire [31:0] btb_io_mem_pc; // @[dut.scala 101:19]
  wire  btb_io_pcsrc; // @[dut.scala 101:19]
  wire  btb_io_branch; // @[dut.scala 101:19]
  wire  btb_io_btb_taken; // @[dut.scala 101:19]
  reg [31:0] pc_reg; // @[dut.scala 58:23]
  reg [31:0] id_pc_reg; // @[dut.scala 61:26]
  reg [31:0] inst_reg; // @[dut.scala 62:25]
  wire [31:0] _next_pc_T_1 = pc_reg + 32'h4; // @[dut.scala 68:29]
  wire  _next_pc_T_7 = io_bht_matched & io_bht_valid & io_btb_btb_taken; // @[dut.scala 73:53]
  wire [31:0] _next_pc_T_8 = _next_pc_T_7 ? io_bht_bht_pred_pc : _next_pc_T_1; // @[Mux.scala 101:16]
  wire [31:0] _next_pc_T_9 = io_pcsrc ? io_target_pc : _next_pc_T_8; // @[Mux.scala 101:16]
  wire [31:0] _next_pc_T_10 = io_mert ? io_mert_vector : _next_pc_T_9; // @[Mux.scala 101:16]
  wire [31:0] _next_pc_T_11 = io_trap ? io_trap_vector : _next_pc_T_10; // @[Mux.scala 101:16]
  BHT bht ( // @[dut.scala 87:19]
    .clock(bht_clock),
    .io_pc(bht_io_pc),
    .io_mem_pc(bht_io_mem_pc),
    .io_pcsrc(bht_io_pcsrc),
    .io_target_pc(bht_io_target_pc),
    .io_matched(bht_io_matched),
    .io_valid(bht_io_valid),
    .io_bht_pred_pc(bht_io_bht_pred_pc)
  );
  BTB btb ( // @[dut.scala 101:19]
    .clock(btb_clock),
    .reset(btb_reset),
    .io_pc(btb_io_pc),
    .io_mem_pc(btb_io_mem_pc),
    .io_pcsrc(btb_io_pcsrc),
    .io_branch(btb_io_branch),
    .io_btb_taken(btb_io_btb_taken)
  );
  assign io_id_pc = id_pc_reg; // @[dut.scala 130:12]
  assign io_inst = inst_reg; // @[dut.scala 131:11]
  assign io_fetch_address = pc_reg; // @[dut.scala 129:20]
  assign io_bht_matched = bht_io_matched; // @[dut.scala 94:18]
  assign io_bht_valid = bht_io_valid; // @[dut.scala 95:16]
  assign io_bht_bht_pred_pc = bht_io_bht_pred_pc; // @[dut.scala 96:22]
  assign io_btb_btb_taken = btb_io_btb_taken; // @[dut.scala 108:20]
  assign bht_clock = clock;
  assign bht_io_pc = pc_reg; // @[dut.scala 88:13]
  assign bht_io_mem_pc = io_mem_pc; // @[dut.scala 89:17]
  assign bht_io_pcsrc = io_pcsrc; // @[dut.scala 90:16]
  assign bht_io_target_pc = io_target_pc; // @[dut.scala 91:20]
  assign btb_clock = clock;
  assign btb_reset = reset;
  assign btb_io_pc = pc_reg; // @[dut.scala 102:13]
  assign btb_io_mem_pc = io_mem_pc; // @[dut.scala 103:17]
  assign btb_io_pcsrc = io_pcsrc; // @[dut.scala 104:16]
  assign btb_io_branch = io_branch; // @[dut.scala 105:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 58:23]
      pc_reg <= 32'h80000000; // @[dut.scala 58:23]
    end else if (reset) begin // @[dut.scala 78:22]
      pc_reg <= 32'h80000000; // @[dut.scala 79:12]
    end else if (~io_pc_stall) begin // @[dut.scala 80:28]
      if (reset) begin // @[Mux.scala 101:16]
        pc_reg <= 32'h80000000;
      end else begin
        pc_reg <= _next_pc_T_11;
      end
    end
    if (reset) begin // @[dut.scala 61:26]
      id_pc_reg <= 32'h0; // @[dut.scala 61:26]
    end else if (reset) begin // @[dut.scala 113:22]
      id_pc_reg <= 32'h0; // @[dut.scala 114:15]
    end else if (io_if_id_flush) begin // @[dut.scala 116:30]
      id_pc_reg <= pc_reg; // @[dut.scala 118:15]
    end else if (~io_if_id_stall) begin // @[dut.scala 120:31]
      id_pc_reg <= pc_reg; // @[dut.scala 122:15]
    end
    if (reset) begin // @[dut.scala 62:25]
      inst_reg <= 32'h0; // @[dut.scala 62:25]
    end else if (reset) begin // @[dut.scala 113:22]
      inst_reg <= 32'h0; // @[dut.scala 115:14]
    end else if (io_if_id_flush) begin // @[dut.scala 116:30]
      inst_reg <= 32'h0; // @[dut.scala 119:14]
    end else if (~io_if_id_stall) begin // @[dut.scala 120:31]
      inst_reg <= io_fetch_data; // @[dut.scala 123:14]
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
  pc_reg = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  id_pc_reg = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  inst_reg = _RAND_2[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
