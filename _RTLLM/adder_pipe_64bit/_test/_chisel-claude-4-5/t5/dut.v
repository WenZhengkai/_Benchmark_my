module dut(
  input         clock,
  input         reset,
  input         io_i_en,
  input  [63:0] io_adda,
  input  [63:0] io_addb,
  output [64:0] io_result,
  output        io_o_en
);
`ifdef RANDOMIZE_REG_INIT
  reg [63:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [63:0] _RAND_2;
  reg [63:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
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
`endif // RANDOMIZE_REG_INIT
  reg [63:0] adda_reg0; // @[dut.scala 14:26]
  reg [63:0] addb_reg0; // @[dut.scala 15:26]
  reg [63:0] adda_reg1; // @[dut.scala 17:26]
  reg [63:0] addb_reg1; // @[dut.scala 18:26]
  reg [63:0] adda_reg2; // @[dut.scala 20:26]
  reg [63:0] addb_reg2; // @[dut.scala 21:26]
  reg  i_en_reg0; // @[dut.scala 24:26]
  reg  i_en_reg1; // @[dut.scala 25:26]
  reg  i_en_reg2; // @[dut.scala 26:26]
  reg  i_en_reg3; // @[dut.scala 27:26]
  reg [16:0] sum0; // @[dut.scala 30:21]
  reg  carry0; // @[dut.scala 31:23]
  wire [16:0] temp_sum0 = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 34:36]
  wire  _GEN_1 = io_i_en & temp_sum0[16]; // @[dut.scala 33:17 36:12 39:12]
  reg [16:0] sum1; // @[dut.scala 43:21]
  reg  carry1; // @[dut.scala 44:23]
  reg [16:0] sum0_reg; // @[dut.scala 45:25]
  wire [16:0] _temp_sum1_T_2 = adda_reg0[31:16] + addb_reg0[31:16]; // @[dut.scala 48:39]
  wire [16:0] _GEN_7 = {{16'd0}, carry0}; // @[dut.scala 48:60]
  wire [17:0] temp_sum1 = _temp_sum1_T_2 + _GEN_7; // @[dut.scala 48:60]
  wire [17:0] _GEN_2 = i_en_reg0 ? temp_sum1 : 18'h0; // @[dut.scala 47:19 49:10 52:10]
  wire  _GEN_3 = i_en_reg0 & temp_sum1[16]; // @[dut.scala 47:19 50:12 53:12]
  reg [16:0] sum2; // @[dut.scala 57:21]
  reg  carry2; // @[dut.scala 58:23]
  reg [16:0] sum1_reg; // @[dut.scala 59:25]
  reg [16:0] sum0_reg2; // @[dut.scala 60:26]
  wire [16:0] _temp_sum2_T_2 = adda_reg1[47:32] + addb_reg1[47:32]; // @[dut.scala 63:39]
  wire [16:0] _GEN_8 = {{16'd0}, carry1}; // @[dut.scala 63:60]
  wire [17:0] temp_sum2 = _temp_sum2_T_2 + _GEN_8; // @[dut.scala 63:60]
  wire [17:0] _GEN_4 = i_en_reg1 ? temp_sum2 : 18'h0; // @[dut.scala 62:19 64:10 67:10]
  wire  _GEN_5 = i_en_reg1 & temp_sum2[16]; // @[dut.scala 62:19 65:12 68:12]
  reg [16:0] sum3; // @[dut.scala 72:21]
  reg [16:0] sum2_reg; // @[dut.scala 73:25]
  reg [16:0] sum1_reg2; // @[dut.scala 74:26]
  reg [16:0] sum0_reg3; // @[dut.scala 75:26]
  wire [16:0] _temp_sum3_T_2 = adda_reg2[63:48] + addb_reg2[63:48]; // @[dut.scala 78:39]
  wire [16:0] _GEN_9 = {{16'd0}, carry2}; // @[dut.scala 78:60]
  wire [17:0] temp_sum3 = _temp_sum3_T_2 + _GEN_9; // @[dut.scala 78:60]
  wire [17:0] _GEN_6 = i_en_reg2 ? temp_sum3 : 18'h0; // @[dut.scala 77:19 79:10 81:10]
  wire [31:0] io_result_lo = {sum1_reg2[15:0],sum0_reg3[15:0]}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {sum3,sum2_reg[15:0]}; // @[Cat.scala 33:92]
  wire [17:0] _GEN_10 = reset ? 18'h0 : _GEN_2; // @[dut.scala 43:{21,21}]
  wire [17:0] _GEN_11 = reset ? 18'h0 : _GEN_4; // @[dut.scala 57:{21,21}]
  wire [17:0] _GEN_12 = reset ? 18'h0 : _GEN_6; // @[dut.scala 72:{21,21}]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = i_en_reg3; // @[dut.scala 88:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:26]
      adda_reg0 <= 64'h0; // @[dut.scala 14:26]
    end else begin
      adda_reg0 <= io_adda; // @[dut.scala 14:26]
    end
    if (reset) begin // @[dut.scala 15:26]
      addb_reg0 <= 64'h0; // @[dut.scala 15:26]
    end else begin
      addb_reg0 <= io_addb; // @[dut.scala 15:26]
    end
    if (reset) begin // @[dut.scala 17:26]
      adda_reg1 <= 64'h0; // @[dut.scala 17:26]
    end else begin
      adda_reg1 <= adda_reg0; // @[dut.scala 17:26]
    end
    if (reset) begin // @[dut.scala 18:26]
      addb_reg1 <= 64'h0; // @[dut.scala 18:26]
    end else begin
      addb_reg1 <= addb_reg0; // @[dut.scala 18:26]
    end
    if (reset) begin // @[dut.scala 20:26]
      adda_reg2 <= 64'h0; // @[dut.scala 20:26]
    end else begin
      adda_reg2 <= adda_reg1; // @[dut.scala 20:26]
    end
    if (reset) begin // @[dut.scala 21:26]
      addb_reg2 <= 64'h0; // @[dut.scala 21:26]
    end else begin
      addb_reg2 <= addb_reg1; // @[dut.scala 21:26]
    end
    if (reset) begin // @[dut.scala 24:26]
      i_en_reg0 <= 1'h0; // @[dut.scala 24:26]
    end else begin
      i_en_reg0 <= io_i_en; // @[dut.scala 24:26]
    end
    if (reset) begin // @[dut.scala 25:26]
      i_en_reg1 <= 1'h0; // @[dut.scala 25:26]
    end else begin
      i_en_reg1 <= i_en_reg0; // @[dut.scala 25:26]
    end
    if (reset) begin // @[dut.scala 26:26]
      i_en_reg2 <= 1'h0; // @[dut.scala 26:26]
    end else begin
      i_en_reg2 <= i_en_reg1; // @[dut.scala 26:26]
    end
    if (reset) begin // @[dut.scala 27:26]
      i_en_reg3 <= 1'h0; // @[dut.scala 27:26]
    end else begin
      i_en_reg3 <= i_en_reg2; // @[dut.scala 27:26]
    end
    if (reset) begin // @[dut.scala 30:21]
      sum0 <= 17'h0; // @[dut.scala 30:21]
    end else if (io_i_en) begin // @[dut.scala 33:17]
      sum0 <= temp_sum0; // @[dut.scala 35:10]
    end else begin
      sum0 <= 17'h0; // @[dut.scala 38:10]
    end
    if (reset) begin // @[dut.scala 31:23]
      carry0 <= 1'h0; // @[dut.scala 31:23]
    end else begin
      carry0 <= _GEN_1;
    end
    sum1 <= _GEN_10[16:0]; // @[dut.scala 43:{21,21}]
    if (reset) begin // @[dut.scala 44:23]
      carry1 <= 1'h0; // @[dut.scala 44:23]
    end else begin
      carry1 <= _GEN_3;
    end
    if (reset) begin // @[dut.scala 45:25]
      sum0_reg <= 17'h0; // @[dut.scala 45:25]
    end else begin
      sum0_reg <= sum0; // @[dut.scala 45:25]
    end
    sum2 <= _GEN_11[16:0]; // @[dut.scala 57:{21,21}]
    if (reset) begin // @[dut.scala 58:23]
      carry2 <= 1'h0; // @[dut.scala 58:23]
    end else begin
      carry2 <= _GEN_5;
    end
    if (reset) begin // @[dut.scala 59:25]
      sum1_reg <= 17'h0; // @[dut.scala 59:25]
    end else begin
      sum1_reg <= sum1; // @[dut.scala 59:25]
    end
    if (reset) begin // @[dut.scala 60:26]
      sum0_reg2 <= 17'h0; // @[dut.scala 60:26]
    end else begin
      sum0_reg2 <= sum0_reg; // @[dut.scala 60:26]
    end
    sum3 <= _GEN_12[16:0]; // @[dut.scala 72:{21,21}]
    if (reset) begin // @[dut.scala 73:25]
      sum2_reg <= 17'h0; // @[dut.scala 73:25]
    end else begin
      sum2_reg <= sum2; // @[dut.scala 73:25]
    end
    if (reset) begin // @[dut.scala 74:26]
      sum1_reg2 <= 17'h0; // @[dut.scala 74:26]
    end else begin
      sum1_reg2 <= sum1_reg; // @[dut.scala 74:26]
    end
    if (reset) begin // @[dut.scala 75:26]
      sum0_reg3 <= 17'h0; // @[dut.scala 75:26]
    end else begin
      sum0_reg3 <= sum0_reg2; // @[dut.scala 75:26]
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
  _RAND_0 = {2{`RANDOM}};
  adda_reg0 = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  addb_reg0 = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  adda_reg1 = _RAND_2[63:0];
  _RAND_3 = {2{`RANDOM}};
  addb_reg1 = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  adda_reg2 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  addb_reg2 = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  i_en_reg0 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  i_en_reg1 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  i_en_reg2 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  i_en_reg3 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  sum0 = _RAND_10[16:0];
  _RAND_11 = {1{`RANDOM}};
  carry0 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  sum1 = _RAND_12[16:0];
  _RAND_13 = {1{`RANDOM}};
  carry1 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  sum0_reg = _RAND_14[16:0];
  _RAND_15 = {1{`RANDOM}};
  sum2 = _RAND_15[16:0];
  _RAND_16 = {1{`RANDOM}};
  carry2 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  sum1_reg = _RAND_17[16:0];
  _RAND_18 = {1{`RANDOM}};
  sum0_reg2 = _RAND_18[16:0];
  _RAND_19 = {1{`RANDOM}};
  sum3 = _RAND_19[16:0];
  _RAND_20 = {1{`RANDOM}};
  sum2_reg = _RAND_20[16:0];
  _RAND_21 = {1{`RANDOM}};
  sum1_reg2 = _RAND_21[16:0];
  _RAND_22 = {1{`RANDOM}};
  sum0_reg3 = _RAND_22[16:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
