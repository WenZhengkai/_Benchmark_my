module dut(
  input         clock,
  input         reset,
  input  [31:0] io_pc,
  input  [31:0] io_mem_pc,
  input         io_pcsrc,
  input  [31:0] io_target_pc,
  output        io_matched,
  output        io_valid,
  output [31:0] io_bht_pred_pc
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
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
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
`endif // RANDOMIZE_REG_INIT
  reg [25:0] bht_table_0_tag; // @[dut.scala 22:26]
  reg  bht_table_0_valid; // @[dut.scala 22:26]
  reg [31:0] bht_table_0_target_pc; // @[dut.scala 22:26]
  reg [25:0] bht_table_1_tag; // @[dut.scala 22:26]
  reg  bht_table_1_valid; // @[dut.scala 22:26]
  reg [31:0] bht_table_1_target_pc; // @[dut.scala 22:26]
  reg [25:0] bht_table_2_tag; // @[dut.scala 22:26]
  reg  bht_table_2_valid; // @[dut.scala 22:26]
  reg [31:0] bht_table_2_target_pc; // @[dut.scala 22:26]
  reg [25:0] bht_table_3_tag; // @[dut.scala 22:26]
  reg  bht_table_3_valid; // @[dut.scala 22:26]
  reg [31:0] bht_table_3_target_pc; // @[dut.scala 22:26]
  reg [25:0] bht_table_4_tag; // @[dut.scala 22:26]
  reg  bht_table_4_valid; // @[dut.scala 22:26]
  reg [31:0] bht_table_4_target_pc; // @[dut.scala 22:26]
  reg [25:0] bht_table_5_tag; // @[dut.scala 22:26]
  reg  bht_table_5_valid; // @[dut.scala 22:26]
  reg [31:0] bht_table_5_target_pc; // @[dut.scala 22:26]
  reg [25:0] bht_table_6_tag; // @[dut.scala 22:26]
  reg  bht_table_6_valid; // @[dut.scala 22:26]
  reg [31:0] bht_table_6_target_pc; // @[dut.scala 22:26]
  reg [25:0] bht_table_7_tag; // @[dut.scala 22:26]
  reg  bht_table_7_valid; // @[dut.scala 22:26]
  reg [31:0] bht_table_7_target_pc; // @[dut.scala 22:26]
  reg [25:0] bht_table_8_tag; // @[dut.scala 22:26]
  reg  bht_table_8_valid; // @[dut.scala 22:26]
  reg [31:0] bht_table_8_target_pc; // @[dut.scala 22:26]
  reg [25:0] bht_table_9_tag; // @[dut.scala 22:26]
  reg  bht_table_9_valid; // @[dut.scala 22:26]
  reg [31:0] bht_table_9_target_pc; // @[dut.scala 22:26]
  reg [25:0] bht_table_10_tag; // @[dut.scala 22:26]
  reg  bht_table_10_valid; // @[dut.scala 22:26]
  reg [31:0] bht_table_10_target_pc; // @[dut.scala 22:26]
  reg [25:0] bht_table_11_tag; // @[dut.scala 22:26]
  reg  bht_table_11_valid; // @[dut.scala 22:26]
  reg [31:0] bht_table_11_target_pc; // @[dut.scala 22:26]
  reg [25:0] bht_table_12_tag; // @[dut.scala 22:26]
  reg  bht_table_12_valid; // @[dut.scala 22:26]
  reg [31:0] bht_table_12_target_pc; // @[dut.scala 22:26]
  reg [25:0] bht_table_13_tag; // @[dut.scala 22:26]
  reg  bht_table_13_valid; // @[dut.scala 22:26]
  reg [31:0] bht_table_13_target_pc; // @[dut.scala 22:26]
  reg [25:0] bht_table_14_tag; // @[dut.scala 22:26]
  reg  bht_table_14_valid; // @[dut.scala 22:26]
  reg [31:0] bht_table_14_target_pc; // @[dut.scala 22:26]
  reg [25:0] bht_table_15_tag; // @[dut.scala 22:26]
  reg  bht_table_15_valid; // @[dut.scala 22:26]
  reg [31:0] bht_table_15_target_pc; // @[dut.scala 22:26]
  wire [3:0] idx = io_pc[5:2]; // @[dut.scala 25:18]
  wire [25:0] _GEN_1 = 4'h1 == idx ? bht_table_1_tag : bht_table_0_tag; // @[dut.scala 29:{29,29}]
  wire [25:0] _GEN_2 = 4'h2 == idx ? bht_table_2_tag : _GEN_1; // @[dut.scala 29:{29,29}]
  wire [25:0] _GEN_3 = 4'h3 == idx ? bht_table_3_tag : _GEN_2; // @[dut.scala 29:{29,29}]
  wire [25:0] _GEN_4 = 4'h4 == idx ? bht_table_4_tag : _GEN_3; // @[dut.scala 29:{29,29}]
  wire [25:0] _GEN_5 = 4'h5 == idx ? bht_table_5_tag : _GEN_4; // @[dut.scala 29:{29,29}]
  wire [25:0] _GEN_6 = 4'h6 == idx ? bht_table_6_tag : _GEN_5; // @[dut.scala 29:{29,29}]
  wire [25:0] _GEN_7 = 4'h7 == idx ? bht_table_7_tag : _GEN_6; // @[dut.scala 29:{29,29}]
  wire [25:0] _GEN_8 = 4'h8 == idx ? bht_table_8_tag : _GEN_7; // @[dut.scala 29:{29,29}]
  wire [25:0] _GEN_9 = 4'h9 == idx ? bht_table_9_tag : _GEN_8; // @[dut.scala 29:{29,29}]
  wire [25:0] _GEN_10 = 4'ha == idx ? bht_table_10_tag : _GEN_9; // @[dut.scala 29:{29,29}]
  wire [25:0] _GEN_11 = 4'hb == idx ? bht_table_11_tag : _GEN_10; // @[dut.scala 29:{29,29}]
  wire [25:0] _GEN_12 = 4'hc == idx ? bht_table_12_tag : _GEN_11; // @[dut.scala 29:{29,29}]
  wire [25:0] _GEN_13 = 4'hd == idx ? bht_table_13_tag : _GEN_12; // @[dut.scala 29:{29,29}]
  wire [25:0] _GEN_14 = 4'he == idx ? bht_table_14_tag : _GEN_13; // @[dut.scala 29:{29,29}]
  wire [25:0] _GEN_15 = 4'hf == idx ? bht_table_15_tag : _GEN_14; // @[dut.scala 29:{29,29}]
  wire  _GEN_17 = 4'h1 == idx ? bht_table_1_valid : bht_table_0_valid; // @[dut.scala 31:{12,12}]
  wire  _GEN_18 = 4'h2 == idx ? bht_table_2_valid : _GEN_17; // @[dut.scala 31:{12,12}]
  wire  _GEN_19 = 4'h3 == idx ? bht_table_3_valid : _GEN_18; // @[dut.scala 31:{12,12}]
  wire  _GEN_20 = 4'h4 == idx ? bht_table_4_valid : _GEN_19; // @[dut.scala 31:{12,12}]
  wire  _GEN_21 = 4'h5 == idx ? bht_table_5_valid : _GEN_20; // @[dut.scala 31:{12,12}]
  wire  _GEN_22 = 4'h6 == idx ? bht_table_6_valid : _GEN_21; // @[dut.scala 31:{12,12}]
  wire  _GEN_23 = 4'h7 == idx ? bht_table_7_valid : _GEN_22; // @[dut.scala 31:{12,12}]
  wire  _GEN_24 = 4'h8 == idx ? bht_table_8_valid : _GEN_23; // @[dut.scala 31:{12,12}]
  wire  _GEN_25 = 4'h9 == idx ? bht_table_9_valid : _GEN_24; // @[dut.scala 31:{12,12}]
  wire  _GEN_26 = 4'ha == idx ? bht_table_10_valid : _GEN_25; // @[dut.scala 31:{12,12}]
  wire  _GEN_27 = 4'hb == idx ? bht_table_11_valid : _GEN_26; // @[dut.scala 31:{12,12}]
  wire  _GEN_28 = 4'hc == idx ? bht_table_12_valid : _GEN_27; // @[dut.scala 31:{12,12}]
  wire  _GEN_29 = 4'hd == idx ? bht_table_13_valid : _GEN_28; // @[dut.scala 31:{12,12}]
  wire  _GEN_30 = 4'he == idx ? bht_table_14_valid : _GEN_29; // @[dut.scala 31:{12,12}]
  wire [31:0] _GEN_33 = 4'h1 == idx ? bht_table_1_target_pc : bht_table_0_target_pc; // @[dut.scala 32:{18,18}]
  wire [31:0] _GEN_34 = 4'h2 == idx ? bht_table_2_target_pc : _GEN_33; // @[dut.scala 32:{18,18}]
  wire [31:0] _GEN_35 = 4'h3 == idx ? bht_table_3_target_pc : _GEN_34; // @[dut.scala 32:{18,18}]
  wire [31:0] _GEN_36 = 4'h4 == idx ? bht_table_4_target_pc : _GEN_35; // @[dut.scala 32:{18,18}]
  wire [31:0] _GEN_37 = 4'h5 == idx ? bht_table_5_target_pc : _GEN_36; // @[dut.scala 32:{18,18}]
  wire [31:0] _GEN_38 = 4'h6 == idx ? bht_table_6_target_pc : _GEN_37; // @[dut.scala 32:{18,18}]
  wire [31:0] _GEN_39 = 4'h7 == idx ? bht_table_7_target_pc : _GEN_38; // @[dut.scala 32:{18,18}]
  wire [31:0] _GEN_40 = 4'h8 == idx ? bht_table_8_target_pc : _GEN_39; // @[dut.scala 32:{18,18}]
  wire [31:0] _GEN_41 = 4'h9 == idx ? bht_table_9_target_pc : _GEN_40; // @[dut.scala 32:{18,18}]
  wire [31:0] _GEN_42 = 4'ha == idx ? bht_table_10_target_pc : _GEN_41; // @[dut.scala 32:{18,18}]
  wire [31:0] _GEN_43 = 4'hb == idx ? bht_table_11_target_pc : _GEN_42; // @[dut.scala 32:{18,18}]
  wire [31:0] _GEN_44 = 4'hc == idx ? bht_table_12_target_pc : _GEN_43; // @[dut.scala 32:{18,18}]
  wire [31:0] _GEN_45 = 4'hd == idx ? bht_table_13_target_pc : _GEN_44; // @[dut.scala 32:{18,18}]
  wire [31:0] _GEN_46 = 4'he == idx ? bht_table_14_target_pc : _GEN_45; // @[dut.scala 32:{18,18}]
  wire [3:0] update_idx = io_mem_pc[5:2]; // @[dut.scala 35:29]
  wire  _GEN_64 = 4'h0 == update_idx | bht_table_0_valid; // @[dut.scala 22:26 39:{33,33}]
  wire  _GEN_65 = 4'h1 == update_idx | bht_table_1_valid; // @[dut.scala 22:26 39:{33,33}]
  wire  _GEN_66 = 4'h2 == update_idx | bht_table_2_valid; // @[dut.scala 22:26 39:{33,33}]
  wire  _GEN_67 = 4'h3 == update_idx | bht_table_3_valid; // @[dut.scala 22:26 39:{33,33}]
  wire  _GEN_68 = 4'h4 == update_idx | bht_table_4_valid; // @[dut.scala 22:26 39:{33,33}]
  wire  _GEN_69 = 4'h5 == update_idx | bht_table_5_valid; // @[dut.scala 22:26 39:{33,33}]
  wire  _GEN_70 = 4'h6 == update_idx | bht_table_6_valid; // @[dut.scala 22:26 39:{33,33}]
  wire  _GEN_71 = 4'h7 == update_idx | bht_table_7_valid; // @[dut.scala 22:26 39:{33,33}]
  wire  _GEN_72 = 4'h8 == update_idx | bht_table_8_valid; // @[dut.scala 22:26 39:{33,33}]
  wire  _GEN_73 = 4'h9 == update_idx | bht_table_9_valid; // @[dut.scala 22:26 39:{33,33}]
  wire  _GEN_74 = 4'ha == update_idx | bht_table_10_valid; // @[dut.scala 22:26 39:{33,33}]
  wire  _GEN_75 = 4'hb == update_idx | bht_table_11_valid; // @[dut.scala 22:26 39:{33,33}]
  wire  _GEN_76 = 4'hc == update_idx | bht_table_12_valid; // @[dut.scala 22:26 39:{33,33}]
  wire  _GEN_77 = 4'hd == update_idx | bht_table_13_valid; // @[dut.scala 22:26 39:{33,33}]
  wire  _GEN_78 = 4'he == update_idx | bht_table_14_valid; // @[dut.scala 22:26 39:{33,33}]
  wire  _GEN_79 = 4'hf == update_idx | bht_table_15_valid; // @[dut.scala 22:26 39:{33,33}]
  assign io_matched = _GEN_15 == io_pc[31:6]; // @[dut.scala 29:29]
  assign io_valid = 4'hf == idx ? bht_table_15_valid : _GEN_30; // @[dut.scala 31:{12,12}]
  assign io_bht_pred_pc = 4'hf == idx ? bht_table_15_target_pc : _GEN_46; // @[dut.scala 32:{18,18}]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 22:26]
      bht_table_0_tag <= 26'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'h0 == update_idx) begin // @[dut.scala 38:31]
        bht_table_0_tag <= io_mem_pc[31:6]; // @[dut.scala 38:31]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_0_valid <= 1'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      bht_table_0_valid <= _GEN_64;
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_0_target_pc <= 32'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'h0 == update_idx) begin // @[dut.scala 40:37]
        bht_table_0_target_pc <= io_target_pc; // @[dut.scala 40:37]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_1_tag <= 26'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'h1 == update_idx) begin // @[dut.scala 38:31]
        bht_table_1_tag <= io_mem_pc[31:6]; // @[dut.scala 38:31]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_1_valid <= 1'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      bht_table_1_valid <= _GEN_65;
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_1_target_pc <= 32'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'h1 == update_idx) begin // @[dut.scala 40:37]
        bht_table_1_target_pc <= io_target_pc; // @[dut.scala 40:37]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_2_tag <= 26'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'h2 == update_idx) begin // @[dut.scala 38:31]
        bht_table_2_tag <= io_mem_pc[31:6]; // @[dut.scala 38:31]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_2_valid <= 1'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      bht_table_2_valid <= _GEN_66;
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_2_target_pc <= 32'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'h2 == update_idx) begin // @[dut.scala 40:37]
        bht_table_2_target_pc <= io_target_pc; // @[dut.scala 40:37]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_3_tag <= 26'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'h3 == update_idx) begin // @[dut.scala 38:31]
        bht_table_3_tag <= io_mem_pc[31:6]; // @[dut.scala 38:31]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_3_valid <= 1'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      bht_table_3_valid <= _GEN_67;
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_3_target_pc <= 32'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'h3 == update_idx) begin // @[dut.scala 40:37]
        bht_table_3_target_pc <= io_target_pc; // @[dut.scala 40:37]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_4_tag <= 26'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'h4 == update_idx) begin // @[dut.scala 38:31]
        bht_table_4_tag <= io_mem_pc[31:6]; // @[dut.scala 38:31]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_4_valid <= 1'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      bht_table_4_valid <= _GEN_68;
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_4_target_pc <= 32'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'h4 == update_idx) begin // @[dut.scala 40:37]
        bht_table_4_target_pc <= io_target_pc; // @[dut.scala 40:37]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_5_tag <= 26'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'h5 == update_idx) begin // @[dut.scala 38:31]
        bht_table_5_tag <= io_mem_pc[31:6]; // @[dut.scala 38:31]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_5_valid <= 1'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      bht_table_5_valid <= _GEN_69;
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_5_target_pc <= 32'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'h5 == update_idx) begin // @[dut.scala 40:37]
        bht_table_5_target_pc <= io_target_pc; // @[dut.scala 40:37]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_6_tag <= 26'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'h6 == update_idx) begin // @[dut.scala 38:31]
        bht_table_6_tag <= io_mem_pc[31:6]; // @[dut.scala 38:31]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_6_valid <= 1'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      bht_table_6_valid <= _GEN_70;
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_6_target_pc <= 32'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'h6 == update_idx) begin // @[dut.scala 40:37]
        bht_table_6_target_pc <= io_target_pc; // @[dut.scala 40:37]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_7_tag <= 26'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'h7 == update_idx) begin // @[dut.scala 38:31]
        bht_table_7_tag <= io_mem_pc[31:6]; // @[dut.scala 38:31]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_7_valid <= 1'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      bht_table_7_valid <= _GEN_71;
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_7_target_pc <= 32'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'h7 == update_idx) begin // @[dut.scala 40:37]
        bht_table_7_target_pc <= io_target_pc; // @[dut.scala 40:37]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_8_tag <= 26'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'h8 == update_idx) begin // @[dut.scala 38:31]
        bht_table_8_tag <= io_mem_pc[31:6]; // @[dut.scala 38:31]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_8_valid <= 1'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      bht_table_8_valid <= _GEN_72;
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_8_target_pc <= 32'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'h8 == update_idx) begin // @[dut.scala 40:37]
        bht_table_8_target_pc <= io_target_pc; // @[dut.scala 40:37]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_9_tag <= 26'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'h9 == update_idx) begin // @[dut.scala 38:31]
        bht_table_9_tag <= io_mem_pc[31:6]; // @[dut.scala 38:31]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_9_valid <= 1'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      bht_table_9_valid <= _GEN_73;
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_9_target_pc <= 32'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'h9 == update_idx) begin // @[dut.scala 40:37]
        bht_table_9_target_pc <= io_target_pc; // @[dut.scala 40:37]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_10_tag <= 26'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'ha == update_idx) begin // @[dut.scala 38:31]
        bht_table_10_tag <= io_mem_pc[31:6]; // @[dut.scala 38:31]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_10_valid <= 1'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      bht_table_10_valid <= _GEN_74;
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_10_target_pc <= 32'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'ha == update_idx) begin // @[dut.scala 40:37]
        bht_table_10_target_pc <= io_target_pc; // @[dut.scala 40:37]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_11_tag <= 26'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'hb == update_idx) begin // @[dut.scala 38:31]
        bht_table_11_tag <= io_mem_pc[31:6]; // @[dut.scala 38:31]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_11_valid <= 1'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      bht_table_11_valid <= _GEN_75;
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_11_target_pc <= 32'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'hb == update_idx) begin // @[dut.scala 40:37]
        bht_table_11_target_pc <= io_target_pc; // @[dut.scala 40:37]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_12_tag <= 26'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'hc == update_idx) begin // @[dut.scala 38:31]
        bht_table_12_tag <= io_mem_pc[31:6]; // @[dut.scala 38:31]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_12_valid <= 1'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      bht_table_12_valid <= _GEN_76;
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_12_target_pc <= 32'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'hc == update_idx) begin // @[dut.scala 40:37]
        bht_table_12_target_pc <= io_target_pc; // @[dut.scala 40:37]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_13_tag <= 26'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'hd == update_idx) begin // @[dut.scala 38:31]
        bht_table_13_tag <= io_mem_pc[31:6]; // @[dut.scala 38:31]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_13_valid <= 1'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      bht_table_13_valid <= _GEN_77;
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_13_target_pc <= 32'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'hd == update_idx) begin // @[dut.scala 40:37]
        bht_table_13_target_pc <= io_target_pc; // @[dut.scala 40:37]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_14_tag <= 26'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'he == update_idx) begin // @[dut.scala 38:31]
        bht_table_14_tag <= io_mem_pc[31:6]; // @[dut.scala 38:31]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_14_valid <= 1'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      bht_table_14_valid <= _GEN_78;
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_14_target_pc <= 32'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'he == update_idx) begin // @[dut.scala 40:37]
        bht_table_14_target_pc <= io_target_pc; // @[dut.scala 40:37]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_15_tag <= 26'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'hf == update_idx) begin // @[dut.scala 38:31]
        bht_table_15_tag <= io_mem_pc[31:6]; // @[dut.scala 38:31]
      end
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_15_valid <= 1'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      bht_table_15_valid <= _GEN_79;
    end
    if (reset) begin // @[dut.scala 22:26]
      bht_table_15_target_pc <= 32'h0; // @[dut.scala 22:26]
    end else if (io_pcsrc) begin // @[dut.scala 37:26]
      if (4'hf == update_idx) begin // @[dut.scala 40:37]
        bht_table_15_target_pc <= io_target_pc; // @[dut.scala 40:37]
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
  bht_table_0_tag = _RAND_0[25:0];
  _RAND_1 = {1{`RANDOM}};
  bht_table_0_valid = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  bht_table_0_target_pc = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  bht_table_1_tag = _RAND_3[25:0];
  _RAND_4 = {1{`RANDOM}};
  bht_table_1_valid = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  bht_table_1_target_pc = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  bht_table_2_tag = _RAND_6[25:0];
  _RAND_7 = {1{`RANDOM}};
  bht_table_2_valid = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  bht_table_2_target_pc = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  bht_table_3_tag = _RAND_9[25:0];
  _RAND_10 = {1{`RANDOM}};
  bht_table_3_valid = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  bht_table_3_target_pc = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  bht_table_4_tag = _RAND_12[25:0];
  _RAND_13 = {1{`RANDOM}};
  bht_table_4_valid = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  bht_table_4_target_pc = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  bht_table_5_tag = _RAND_15[25:0];
  _RAND_16 = {1{`RANDOM}};
  bht_table_5_valid = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  bht_table_5_target_pc = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  bht_table_6_tag = _RAND_18[25:0];
  _RAND_19 = {1{`RANDOM}};
  bht_table_6_valid = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  bht_table_6_target_pc = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  bht_table_7_tag = _RAND_21[25:0];
  _RAND_22 = {1{`RANDOM}};
  bht_table_7_valid = _RAND_22[0:0];
  _RAND_23 = {1{`RANDOM}};
  bht_table_7_target_pc = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  bht_table_8_tag = _RAND_24[25:0];
  _RAND_25 = {1{`RANDOM}};
  bht_table_8_valid = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  bht_table_8_target_pc = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  bht_table_9_tag = _RAND_27[25:0];
  _RAND_28 = {1{`RANDOM}};
  bht_table_9_valid = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  bht_table_9_target_pc = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  bht_table_10_tag = _RAND_30[25:0];
  _RAND_31 = {1{`RANDOM}};
  bht_table_10_valid = _RAND_31[0:0];
  _RAND_32 = {1{`RANDOM}};
  bht_table_10_target_pc = _RAND_32[31:0];
  _RAND_33 = {1{`RANDOM}};
  bht_table_11_tag = _RAND_33[25:0];
  _RAND_34 = {1{`RANDOM}};
  bht_table_11_valid = _RAND_34[0:0];
  _RAND_35 = {1{`RANDOM}};
  bht_table_11_target_pc = _RAND_35[31:0];
  _RAND_36 = {1{`RANDOM}};
  bht_table_12_tag = _RAND_36[25:0];
  _RAND_37 = {1{`RANDOM}};
  bht_table_12_valid = _RAND_37[0:0];
  _RAND_38 = {1{`RANDOM}};
  bht_table_12_target_pc = _RAND_38[31:0];
  _RAND_39 = {1{`RANDOM}};
  bht_table_13_tag = _RAND_39[25:0];
  _RAND_40 = {1{`RANDOM}};
  bht_table_13_valid = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  bht_table_13_target_pc = _RAND_41[31:0];
  _RAND_42 = {1{`RANDOM}};
  bht_table_14_tag = _RAND_42[25:0];
  _RAND_43 = {1{`RANDOM}};
  bht_table_14_valid = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  bht_table_14_target_pc = _RAND_44[31:0];
  _RAND_45 = {1{`RANDOM}};
  bht_table_15_tag = _RAND_45[25:0];
  _RAND_46 = {1{`RANDOM}};
  bht_table_15_valid = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  bht_table_15_target_pc = _RAND_47[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
