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
`endif // RANDOMIZE_REG_INIT
  reg [25:0] bht_0_tag; // @[dut.scala 23:16]
  reg [31:0] bht_0_target_pc; // @[dut.scala 23:16]
  reg [25:0] bht_1_tag; // @[dut.scala 23:16]
  reg [31:0] bht_1_target_pc; // @[dut.scala 23:16]
  reg [25:0] bht_2_tag; // @[dut.scala 23:16]
  reg [31:0] bht_2_target_pc; // @[dut.scala 23:16]
  reg [25:0] bht_3_tag; // @[dut.scala 23:16]
  reg [31:0] bht_3_target_pc; // @[dut.scala 23:16]
  reg [25:0] bht_4_tag; // @[dut.scala 23:16]
  reg [31:0] bht_4_target_pc; // @[dut.scala 23:16]
  reg [25:0] bht_5_tag; // @[dut.scala 23:16]
  reg [31:0] bht_5_target_pc; // @[dut.scala 23:16]
  reg [25:0] bht_6_tag; // @[dut.scala 23:16]
  reg [31:0] bht_6_target_pc; // @[dut.scala 23:16]
  reg [25:0] bht_7_tag; // @[dut.scala 23:16]
  reg [31:0] bht_7_target_pc; // @[dut.scala 23:16]
  reg [25:0] bht_8_tag; // @[dut.scala 23:16]
  reg [31:0] bht_8_target_pc; // @[dut.scala 23:16]
  reg [25:0] bht_9_tag; // @[dut.scala 23:16]
  reg [31:0] bht_9_target_pc; // @[dut.scala 23:16]
  reg [25:0] bht_10_tag; // @[dut.scala 23:16]
  reg [31:0] bht_10_target_pc; // @[dut.scala 23:16]
  reg [25:0] bht_11_tag; // @[dut.scala 23:16]
  reg [31:0] bht_11_target_pc; // @[dut.scala 23:16]
  reg [25:0] bht_12_tag; // @[dut.scala 23:16]
  reg [31:0] bht_12_target_pc; // @[dut.scala 23:16]
  reg [25:0] bht_13_tag; // @[dut.scala 23:16]
  reg [31:0] bht_13_target_pc; // @[dut.scala 23:16]
  reg [25:0] bht_14_tag; // @[dut.scala 23:16]
  reg [31:0] bht_14_target_pc; // @[dut.scala 23:16]
  reg [25:0] bht_15_tag; // @[dut.scala 23:16]
  reg [31:0] bht_15_target_pc; // @[dut.scala 23:16]
  wire [3:0] idx = io_pc[5:2]; // @[dut.scala 25:18]
  wire [25:0] _GEN_1 = 4'h1 == idx ? bht_1_tag : bht_0_tag; // @[dut.scala 28:{29,29}]
  wire [25:0] _GEN_2 = 4'h2 == idx ? bht_2_tag : _GEN_1; // @[dut.scala 28:{29,29}]
  wire [25:0] _GEN_3 = 4'h3 == idx ? bht_3_tag : _GEN_2; // @[dut.scala 28:{29,29}]
  wire [25:0] _GEN_4 = 4'h4 == idx ? bht_4_tag : _GEN_3; // @[dut.scala 28:{29,29}]
  wire [25:0] _GEN_5 = 4'h5 == idx ? bht_5_tag : _GEN_4; // @[dut.scala 28:{29,29}]
  wire [25:0] _GEN_6 = 4'h6 == idx ? bht_6_tag : _GEN_5; // @[dut.scala 28:{29,29}]
  wire [25:0] _GEN_7 = 4'h7 == idx ? bht_7_tag : _GEN_6; // @[dut.scala 28:{29,29}]
  wire [25:0] _GEN_8 = 4'h8 == idx ? bht_8_tag : _GEN_7; // @[dut.scala 28:{29,29}]
  wire [25:0] _GEN_9 = 4'h9 == idx ? bht_9_tag : _GEN_8; // @[dut.scala 28:{29,29}]
  wire [25:0] _GEN_10 = 4'ha == idx ? bht_10_tag : _GEN_9; // @[dut.scala 28:{29,29}]
  wire [25:0] _GEN_11 = 4'hb == idx ? bht_11_tag : _GEN_10; // @[dut.scala 28:{29,29}]
  wire [25:0] _GEN_12 = 4'hc == idx ? bht_12_tag : _GEN_11; // @[dut.scala 28:{29,29}]
  wire [25:0] _GEN_13 = 4'hd == idx ? bht_13_tag : _GEN_12; // @[dut.scala 28:{29,29}]
  wire [25:0] _GEN_14 = 4'he == idx ? bht_14_tag : _GEN_13; // @[dut.scala 28:{29,29}]
  wire [25:0] _GEN_15 = 4'hf == idx ? bht_15_tag : _GEN_14; // @[dut.scala 28:{29,29}]
  wire [31:0] _GEN_33 = 4'h1 == idx ? bht_1_target_pc : bht_0_target_pc; // @[dut.scala 31:{18,18}]
  wire [31:0] _GEN_34 = 4'h2 == idx ? bht_2_target_pc : _GEN_33; // @[dut.scala 31:{18,18}]
  wire [31:0] _GEN_35 = 4'h3 == idx ? bht_3_target_pc : _GEN_34; // @[dut.scala 31:{18,18}]
  wire [31:0] _GEN_36 = 4'h4 == idx ? bht_4_target_pc : _GEN_35; // @[dut.scala 31:{18,18}]
  wire [31:0] _GEN_37 = 4'h5 == idx ? bht_5_target_pc : _GEN_36; // @[dut.scala 31:{18,18}]
  wire [31:0] _GEN_38 = 4'h6 == idx ? bht_6_target_pc : _GEN_37; // @[dut.scala 31:{18,18}]
  wire [31:0] _GEN_39 = 4'h7 == idx ? bht_7_target_pc : _GEN_38; // @[dut.scala 31:{18,18}]
  wire [31:0] _GEN_40 = 4'h8 == idx ? bht_8_target_pc : _GEN_39; // @[dut.scala 31:{18,18}]
  wire [31:0] _GEN_41 = 4'h9 == idx ? bht_9_target_pc : _GEN_40; // @[dut.scala 31:{18,18}]
  wire [31:0] _GEN_42 = 4'ha == idx ? bht_10_target_pc : _GEN_41; // @[dut.scala 31:{18,18}]
  wire [31:0] _GEN_43 = 4'hb == idx ? bht_11_target_pc : _GEN_42; // @[dut.scala 31:{18,18}]
  wire [31:0] _GEN_44 = 4'hc == idx ? bht_12_target_pc : _GEN_43; // @[dut.scala 31:{18,18}]
  wire [31:0] _GEN_45 = 4'hd == idx ? bht_13_target_pc : _GEN_44; // @[dut.scala 31:{18,18}]
  wire [31:0] _GEN_46 = 4'he == idx ? bht_14_target_pc : _GEN_45; // @[dut.scala 31:{18,18}]
  wire [3:0] update_idx = io_mem_pc[5:2]; // @[dut.scala 34:29]
  assign io_matched = _GEN_15 == io_pc[31:6]; // @[dut.scala 28:29]
  assign io_valid = 1'h1; // @[dut.scala 30:{12,12}]
  assign io_bht_pred_pc = 4'hf == idx ? bht_15_target_pc : _GEN_46; // @[dut.scala 31:{18,18}]
  always @(posedge clock) begin
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'h0 == update_idx) begin // @[dut.scala 38:25]
        bht_0_tag <= io_mem_pc[31:6]; // @[dut.scala 38:25]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'h0 == update_idx) begin // @[dut.scala 40:31]
        bht_0_target_pc <= io_target_pc; // @[dut.scala 40:31]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'h1 == update_idx) begin // @[dut.scala 38:25]
        bht_1_tag <= io_mem_pc[31:6]; // @[dut.scala 38:25]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'h1 == update_idx) begin // @[dut.scala 40:31]
        bht_1_target_pc <= io_target_pc; // @[dut.scala 40:31]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'h2 == update_idx) begin // @[dut.scala 38:25]
        bht_2_tag <= io_mem_pc[31:6]; // @[dut.scala 38:25]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'h2 == update_idx) begin // @[dut.scala 40:31]
        bht_2_target_pc <= io_target_pc; // @[dut.scala 40:31]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'h3 == update_idx) begin // @[dut.scala 38:25]
        bht_3_tag <= io_mem_pc[31:6]; // @[dut.scala 38:25]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'h3 == update_idx) begin // @[dut.scala 40:31]
        bht_3_target_pc <= io_target_pc; // @[dut.scala 40:31]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'h4 == update_idx) begin // @[dut.scala 38:25]
        bht_4_tag <= io_mem_pc[31:6]; // @[dut.scala 38:25]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'h4 == update_idx) begin // @[dut.scala 40:31]
        bht_4_target_pc <= io_target_pc; // @[dut.scala 40:31]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'h5 == update_idx) begin // @[dut.scala 38:25]
        bht_5_tag <= io_mem_pc[31:6]; // @[dut.scala 38:25]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'h5 == update_idx) begin // @[dut.scala 40:31]
        bht_5_target_pc <= io_target_pc; // @[dut.scala 40:31]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'h6 == update_idx) begin // @[dut.scala 38:25]
        bht_6_tag <= io_mem_pc[31:6]; // @[dut.scala 38:25]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'h6 == update_idx) begin // @[dut.scala 40:31]
        bht_6_target_pc <= io_target_pc; // @[dut.scala 40:31]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'h7 == update_idx) begin // @[dut.scala 38:25]
        bht_7_tag <= io_mem_pc[31:6]; // @[dut.scala 38:25]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'h7 == update_idx) begin // @[dut.scala 40:31]
        bht_7_target_pc <= io_target_pc; // @[dut.scala 40:31]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'h8 == update_idx) begin // @[dut.scala 38:25]
        bht_8_tag <= io_mem_pc[31:6]; // @[dut.scala 38:25]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'h8 == update_idx) begin // @[dut.scala 40:31]
        bht_8_target_pc <= io_target_pc; // @[dut.scala 40:31]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'h9 == update_idx) begin // @[dut.scala 38:25]
        bht_9_tag <= io_mem_pc[31:6]; // @[dut.scala 38:25]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'h9 == update_idx) begin // @[dut.scala 40:31]
        bht_9_target_pc <= io_target_pc; // @[dut.scala 40:31]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'ha == update_idx) begin // @[dut.scala 38:25]
        bht_10_tag <= io_mem_pc[31:6]; // @[dut.scala 38:25]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'ha == update_idx) begin // @[dut.scala 40:31]
        bht_10_target_pc <= io_target_pc; // @[dut.scala 40:31]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'hb == update_idx) begin // @[dut.scala 38:25]
        bht_11_tag <= io_mem_pc[31:6]; // @[dut.scala 38:25]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'hb == update_idx) begin // @[dut.scala 40:31]
        bht_11_target_pc <= io_target_pc; // @[dut.scala 40:31]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'hc == update_idx) begin // @[dut.scala 38:25]
        bht_12_tag <= io_mem_pc[31:6]; // @[dut.scala 38:25]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'hc == update_idx) begin // @[dut.scala 40:31]
        bht_12_target_pc <= io_target_pc; // @[dut.scala 40:31]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'hd == update_idx) begin // @[dut.scala 38:25]
        bht_13_tag <= io_mem_pc[31:6]; // @[dut.scala 38:25]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'hd == update_idx) begin // @[dut.scala 40:31]
        bht_13_target_pc <= io_target_pc; // @[dut.scala 40:31]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'he == update_idx) begin // @[dut.scala 38:25]
        bht_14_tag <= io_mem_pc[31:6]; // @[dut.scala 38:25]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'he == update_idx) begin // @[dut.scala 40:31]
        bht_14_target_pc <= io_target_pc; // @[dut.scala 40:31]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'hf == update_idx) begin // @[dut.scala 38:25]
        bht_15_tag <= io_mem_pc[31:6]; // @[dut.scala 38:25]
      end
    end
    if (io_pcsrc) begin // @[dut.scala 37:19]
      if (4'hf == update_idx) begin // @[dut.scala 40:31]
        bht_15_target_pc <= io_target_pc; // @[dut.scala 40:31]
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
  bht_0_tag = _RAND_0[25:0];
  _RAND_1 = {1{`RANDOM}};
  bht_0_target_pc = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  bht_1_tag = _RAND_2[25:0];
  _RAND_3 = {1{`RANDOM}};
  bht_1_target_pc = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  bht_2_tag = _RAND_4[25:0];
  _RAND_5 = {1{`RANDOM}};
  bht_2_target_pc = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  bht_3_tag = _RAND_6[25:0];
  _RAND_7 = {1{`RANDOM}};
  bht_3_target_pc = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  bht_4_tag = _RAND_8[25:0];
  _RAND_9 = {1{`RANDOM}};
  bht_4_target_pc = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  bht_5_tag = _RAND_10[25:0];
  _RAND_11 = {1{`RANDOM}};
  bht_5_target_pc = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  bht_6_tag = _RAND_12[25:0];
  _RAND_13 = {1{`RANDOM}};
  bht_6_target_pc = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  bht_7_tag = _RAND_14[25:0];
  _RAND_15 = {1{`RANDOM}};
  bht_7_target_pc = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  bht_8_tag = _RAND_16[25:0];
  _RAND_17 = {1{`RANDOM}};
  bht_8_target_pc = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  bht_9_tag = _RAND_18[25:0];
  _RAND_19 = {1{`RANDOM}};
  bht_9_target_pc = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  bht_10_tag = _RAND_20[25:0];
  _RAND_21 = {1{`RANDOM}};
  bht_10_target_pc = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  bht_11_tag = _RAND_22[25:0];
  _RAND_23 = {1{`RANDOM}};
  bht_11_target_pc = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  bht_12_tag = _RAND_24[25:0];
  _RAND_25 = {1{`RANDOM}};
  bht_12_target_pc = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  bht_13_tag = _RAND_26[25:0];
  _RAND_27 = {1{`RANDOM}};
  bht_13_target_pc = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  bht_14_tag = _RAND_28[25:0];
  _RAND_29 = {1{`RANDOM}};
  bht_14_target_pc = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  bht_15_tag = _RAND_30[25:0];
  _RAND_31 = {1{`RANDOM}};
  bht_15_target_pc = _RAND_31[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
