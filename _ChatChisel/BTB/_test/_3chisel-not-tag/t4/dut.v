module dut(
  input         clock,
  input         reset,
  input  [31:0] io_pc,
  input  [31:0] io_mem_pc,
  input         io_pcsrc,
  input         io_branch,
  output        io_btb_taken
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
`endif // RANDOMIZE_REG_INIT
  reg [1:0] btb_table_0; // @[dut.scala 14:26]
  reg [1:0] btb_table_1; // @[dut.scala 14:26]
  reg [1:0] btb_table_2; // @[dut.scala 14:26]
  reg [1:0] btb_table_3; // @[dut.scala 14:26]
  reg [1:0] btb_table_4; // @[dut.scala 14:26]
  reg [1:0] btb_table_5; // @[dut.scala 14:26]
  reg [1:0] btb_table_6; // @[dut.scala 14:26]
  reg [1:0] btb_table_7; // @[dut.scala 14:26]
  reg [1:0] btb_table_8; // @[dut.scala 14:26]
  reg [1:0] btb_table_9; // @[dut.scala 14:26]
  reg [1:0] btb_table_10; // @[dut.scala 14:26]
  reg [1:0] btb_table_11; // @[dut.scala 14:26]
  reg [1:0] btb_table_12; // @[dut.scala 14:26]
  reg [1:0] btb_table_13; // @[dut.scala 14:26]
  reg [1:0] btb_table_14; // @[dut.scala 14:26]
  reg [1:0] btb_table_15; // @[dut.scala 14:26]
  wire [3:0] predict_index = io_pc[5:2]; // @[dut.scala 17:36]
  wire [1:0] _GEN_1 = 4'h1 == predict_index ? btb_table_1 : btb_table_0; // @[dut.scala 24:{39,39}]
  wire [1:0] _GEN_2 = 4'h2 == predict_index ? btb_table_2 : _GEN_1; // @[dut.scala 24:{39,39}]
  wire [1:0] _GEN_3 = 4'h3 == predict_index ? btb_table_3 : _GEN_2; // @[dut.scala 24:{39,39}]
  wire [1:0] _GEN_4 = 4'h4 == predict_index ? btb_table_4 : _GEN_3; // @[dut.scala 24:{39,39}]
  wire [1:0] _GEN_5 = 4'h5 == predict_index ? btb_table_5 : _GEN_4; // @[dut.scala 24:{39,39}]
  wire [1:0] _GEN_6 = 4'h6 == predict_index ? btb_table_6 : _GEN_5; // @[dut.scala 24:{39,39}]
  wire [1:0] _GEN_7 = 4'h7 == predict_index ? btb_table_7 : _GEN_6; // @[dut.scala 24:{39,39}]
  wire [1:0] _GEN_8 = 4'h8 == predict_index ? btb_table_8 : _GEN_7; // @[dut.scala 24:{39,39}]
  wire [1:0] _GEN_9 = 4'h9 == predict_index ? btb_table_9 : _GEN_8; // @[dut.scala 24:{39,39}]
  wire [1:0] _GEN_10 = 4'ha == predict_index ? btb_table_10 : _GEN_9; // @[dut.scala 24:{39,39}]
  wire [1:0] _GEN_11 = 4'hb == predict_index ? btb_table_11 : _GEN_10; // @[dut.scala 24:{39,39}]
  wire [1:0] _GEN_12 = 4'hc == predict_index ? btb_table_12 : _GEN_11; // @[dut.scala 24:{39,39}]
  wire [1:0] _GEN_13 = 4'hd == predict_index ? btb_table_13 : _GEN_12; // @[dut.scala 24:{39,39}]
  wire [1:0] _GEN_14 = 4'he == predict_index ? btb_table_14 : _GEN_13; // @[dut.scala 24:{39,39}]
  wire [1:0] _GEN_15 = 4'hf == predict_index ? btb_table_15 : _GEN_14; // @[dut.scala 24:{39,39}]
  wire [3:0] update_index = io_mem_pc[5:2]; // @[dut.scala 17:36]
  wire [1:0] _GEN_17 = 4'h1 == update_index ? btb_table_1 : btb_table_0; // @[dut.scala 36:{15,15}]
  wire [1:0] _GEN_18 = 4'h2 == update_index ? btb_table_2 : _GEN_17; // @[dut.scala 36:{15,15}]
  wire [1:0] _GEN_19 = 4'h3 == update_index ? btb_table_3 : _GEN_18; // @[dut.scala 36:{15,15}]
  wire [1:0] _GEN_20 = 4'h4 == update_index ? btb_table_4 : _GEN_19; // @[dut.scala 36:{15,15}]
  wire [1:0] _GEN_21 = 4'h5 == update_index ? btb_table_5 : _GEN_20; // @[dut.scala 36:{15,15}]
  wire [1:0] _GEN_22 = 4'h6 == update_index ? btb_table_6 : _GEN_21; // @[dut.scala 36:{15,15}]
  wire [1:0] _GEN_23 = 4'h7 == update_index ? btb_table_7 : _GEN_22; // @[dut.scala 36:{15,15}]
  wire [1:0] _GEN_24 = 4'h8 == update_index ? btb_table_8 : _GEN_23; // @[dut.scala 36:{15,15}]
  wire [1:0] _GEN_25 = 4'h9 == update_index ? btb_table_9 : _GEN_24; // @[dut.scala 36:{15,15}]
  wire [1:0] _GEN_26 = 4'ha == update_index ? btb_table_10 : _GEN_25; // @[dut.scala 36:{15,15}]
  wire [1:0] _GEN_27 = 4'hb == update_index ? btb_table_11 : _GEN_26; // @[dut.scala 36:{15,15}]
  wire [1:0] _GEN_28 = 4'hc == update_index ? btb_table_12 : _GEN_27; // @[dut.scala 36:{15,15}]
  wire [1:0] _GEN_29 = 4'hd == update_index ? btb_table_13 : _GEN_28; // @[dut.scala 36:{15,15}]
  wire [1:0] _GEN_30 = 4'he == update_index ? btb_table_14 : _GEN_29; // @[dut.scala 36:{15,15}]
  wire [1:0] _GEN_31 = 4'hf == update_index ? btb_table_15 : _GEN_30; // @[dut.scala 36:{15,15}]
  wire [1:0] _btb_table_T_3 = _GEN_31 + 2'h1; // @[dut.scala 36:33]
  wire [1:0] _btb_table_T_4 = _GEN_31 == 2'h3 ? 2'h3 : _btb_table_T_3; // @[dut.scala 36:10]
  wire [1:0] _btb_table_T_7 = _GEN_31 - 2'h1; // @[dut.scala 37:33]
  wire [1:0] _btb_table_T_8 = _GEN_31 == 2'h0 ? 2'h0 : _btb_table_T_7; // @[dut.scala 37:10]
  assign io_btb_taken = _GEN_15 >= 2'h2; // @[dut.scala 24:39]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:26]
      btb_table_0 <= 2'h0; // @[dut.scala 14:26]
    end else if (io_branch) begin // @[dut.scala 42:27]
      if (4'h0 == update_index) begin // @[dut.scala 43:29]
        if (io_pcsrc) begin // @[dut.scala 35:8]
          btb_table_0 <= _btb_table_T_4;
        end else begin
          btb_table_0 <= _btb_table_T_8;
        end
      end
    end
    if (reset) begin // @[dut.scala 14:26]
      btb_table_1 <= 2'h0; // @[dut.scala 14:26]
    end else if (io_branch) begin // @[dut.scala 42:27]
      if (4'h1 == update_index) begin // @[dut.scala 43:29]
        if (io_pcsrc) begin // @[dut.scala 35:8]
          btb_table_1 <= _btb_table_T_4;
        end else begin
          btb_table_1 <= _btb_table_T_8;
        end
      end
    end
    if (reset) begin // @[dut.scala 14:26]
      btb_table_2 <= 2'h0; // @[dut.scala 14:26]
    end else if (io_branch) begin // @[dut.scala 42:27]
      if (4'h2 == update_index) begin // @[dut.scala 43:29]
        if (io_pcsrc) begin // @[dut.scala 35:8]
          btb_table_2 <= _btb_table_T_4;
        end else begin
          btb_table_2 <= _btb_table_T_8;
        end
      end
    end
    if (reset) begin // @[dut.scala 14:26]
      btb_table_3 <= 2'h0; // @[dut.scala 14:26]
    end else if (io_branch) begin // @[dut.scala 42:27]
      if (4'h3 == update_index) begin // @[dut.scala 43:29]
        if (io_pcsrc) begin // @[dut.scala 35:8]
          btb_table_3 <= _btb_table_T_4;
        end else begin
          btb_table_3 <= _btb_table_T_8;
        end
      end
    end
    if (reset) begin // @[dut.scala 14:26]
      btb_table_4 <= 2'h0; // @[dut.scala 14:26]
    end else if (io_branch) begin // @[dut.scala 42:27]
      if (4'h4 == update_index) begin // @[dut.scala 43:29]
        if (io_pcsrc) begin // @[dut.scala 35:8]
          btb_table_4 <= _btb_table_T_4;
        end else begin
          btb_table_4 <= _btb_table_T_8;
        end
      end
    end
    if (reset) begin // @[dut.scala 14:26]
      btb_table_5 <= 2'h0; // @[dut.scala 14:26]
    end else if (io_branch) begin // @[dut.scala 42:27]
      if (4'h5 == update_index) begin // @[dut.scala 43:29]
        if (io_pcsrc) begin // @[dut.scala 35:8]
          btb_table_5 <= _btb_table_T_4;
        end else begin
          btb_table_5 <= _btb_table_T_8;
        end
      end
    end
    if (reset) begin // @[dut.scala 14:26]
      btb_table_6 <= 2'h0; // @[dut.scala 14:26]
    end else if (io_branch) begin // @[dut.scala 42:27]
      if (4'h6 == update_index) begin // @[dut.scala 43:29]
        if (io_pcsrc) begin // @[dut.scala 35:8]
          btb_table_6 <= _btb_table_T_4;
        end else begin
          btb_table_6 <= _btb_table_T_8;
        end
      end
    end
    if (reset) begin // @[dut.scala 14:26]
      btb_table_7 <= 2'h0; // @[dut.scala 14:26]
    end else if (io_branch) begin // @[dut.scala 42:27]
      if (4'h7 == update_index) begin // @[dut.scala 43:29]
        if (io_pcsrc) begin // @[dut.scala 35:8]
          btb_table_7 <= _btb_table_T_4;
        end else begin
          btb_table_7 <= _btb_table_T_8;
        end
      end
    end
    if (reset) begin // @[dut.scala 14:26]
      btb_table_8 <= 2'h0; // @[dut.scala 14:26]
    end else if (io_branch) begin // @[dut.scala 42:27]
      if (4'h8 == update_index) begin // @[dut.scala 43:29]
        if (io_pcsrc) begin // @[dut.scala 35:8]
          btb_table_8 <= _btb_table_T_4;
        end else begin
          btb_table_8 <= _btb_table_T_8;
        end
      end
    end
    if (reset) begin // @[dut.scala 14:26]
      btb_table_9 <= 2'h0; // @[dut.scala 14:26]
    end else if (io_branch) begin // @[dut.scala 42:27]
      if (4'h9 == update_index) begin // @[dut.scala 43:29]
        if (io_pcsrc) begin // @[dut.scala 35:8]
          btb_table_9 <= _btb_table_T_4;
        end else begin
          btb_table_9 <= _btb_table_T_8;
        end
      end
    end
    if (reset) begin // @[dut.scala 14:26]
      btb_table_10 <= 2'h0; // @[dut.scala 14:26]
    end else if (io_branch) begin // @[dut.scala 42:27]
      if (4'ha == update_index) begin // @[dut.scala 43:29]
        if (io_pcsrc) begin // @[dut.scala 35:8]
          btb_table_10 <= _btb_table_T_4;
        end else begin
          btb_table_10 <= _btb_table_T_8;
        end
      end
    end
    if (reset) begin // @[dut.scala 14:26]
      btb_table_11 <= 2'h0; // @[dut.scala 14:26]
    end else if (io_branch) begin // @[dut.scala 42:27]
      if (4'hb == update_index) begin // @[dut.scala 43:29]
        if (io_pcsrc) begin // @[dut.scala 35:8]
          btb_table_11 <= _btb_table_T_4;
        end else begin
          btb_table_11 <= _btb_table_T_8;
        end
      end
    end
    if (reset) begin // @[dut.scala 14:26]
      btb_table_12 <= 2'h0; // @[dut.scala 14:26]
    end else if (io_branch) begin // @[dut.scala 42:27]
      if (4'hc == update_index) begin // @[dut.scala 43:29]
        if (io_pcsrc) begin // @[dut.scala 35:8]
          btb_table_12 <= _btb_table_T_4;
        end else begin
          btb_table_12 <= _btb_table_T_8;
        end
      end
    end
    if (reset) begin // @[dut.scala 14:26]
      btb_table_13 <= 2'h0; // @[dut.scala 14:26]
    end else if (io_branch) begin // @[dut.scala 42:27]
      if (4'hd == update_index) begin // @[dut.scala 43:29]
        if (io_pcsrc) begin // @[dut.scala 35:8]
          btb_table_13 <= _btb_table_T_4;
        end else begin
          btb_table_13 <= _btb_table_T_8;
        end
      end
    end
    if (reset) begin // @[dut.scala 14:26]
      btb_table_14 <= 2'h0; // @[dut.scala 14:26]
    end else if (io_branch) begin // @[dut.scala 42:27]
      if (4'he == update_index) begin // @[dut.scala 43:29]
        if (io_pcsrc) begin // @[dut.scala 35:8]
          btb_table_14 <= _btb_table_T_4;
        end else begin
          btb_table_14 <= _btb_table_T_8;
        end
      end
    end
    if (reset) begin // @[dut.scala 14:26]
      btb_table_15 <= 2'h0; // @[dut.scala 14:26]
    end else if (io_branch) begin // @[dut.scala 42:27]
      if (4'hf == update_index) begin // @[dut.scala 43:29]
        if (io_pcsrc) begin // @[dut.scala 35:8]
          btb_table_15 <= _btb_table_T_4;
        end else begin
          btb_table_15 <= _btb_table_T_8;
        end
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
  btb_table_0 = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  btb_table_1 = _RAND_1[1:0];
  _RAND_2 = {1{`RANDOM}};
  btb_table_2 = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  btb_table_3 = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  btb_table_4 = _RAND_4[1:0];
  _RAND_5 = {1{`RANDOM}};
  btb_table_5 = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  btb_table_6 = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  btb_table_7 = _RAND_7[1:0];
  _RAND_8 = {1{`RANDOM}};
  btb_table_8 = _RAND_8[1:0];
  _RAND_9 = {1{`RANDOM}};
  btb_table_9 = _RAND_9[1:0];
  _RAND_10 = {1{`RANDOM}};
  btb_table_10 = _RAND_10[1:0];
  _RAND_11 = {1{`RANDOM}};
  btb_table_11 = _RAND_11[1:0];
  _RAND_12 = {1{`RANDOM}};
  btb_table_12 = _RAND_12[1:0];
  _RAND_13 = {1{`RANDOM}};
  btb_table_13 = _RAND_13[1:0];
  _RAND_14 = {1{`RANDOM}};
  btb_table_14 = _RAND_14[1:0];
  _RAND_15 = {1{`RANDOM}};
  btb_table_15 = _RAND_15[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
