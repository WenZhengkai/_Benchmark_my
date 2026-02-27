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
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [63:0] _RAND_4;
  reg [63:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [63:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [95:0] _RAND_18;
  reg [31:0] _RAND_19;
`endif // RANDOMIZE_REG_INIT
  reg  en_reg1; // @[dut.scala 19:24]
  reg  en_reg2; // @[dut.scala 20:24]
  reg  en_reg3; // @[dut.scala 21:24]
  reg  en_reg4; // @[dut.scala 22:24]
  reg [63:0] adda_reg; // @[dut.scala 25:25]
  reg [63:0] addb_reg; // @[dut.scala 26:25]
  wire [16:0] stage1_value = adda_reg[15:0] + addb_reg[15:0]; // @[dut.scala 44:38]
  wire  carry1 = stage1_value[16]; // @[dut.scala 46:25]
  wire [15:0] sum1 = stage1_value[15:0]; // @[dut.scala 45:23]
  wire [16:0] stage1_result = {carry1,sum1}; // @[Cat.scala 33:92]
  reg [16:0] stage1_reg; // @[dut.scala 49:27]
  reg [47:0] adda_high1_reg; // @[dut.scala 50:31]
  reg [47:0] addb_high1_reg; // @[dut.scala 51:31]
  wire [16:0] _stage2_value_T_2 = adda_high1_reg[15:0] + addb_high1_reg[15:0]; // @[dut.scala 66:44]
  wire [16:0] _GEN_20 = {{16'd0}, stage1_reg[16]}; // @[dut.scala 66:69]
  wire [16:0] stage2_value = _stage2_value_T_2 + _GEN_20; // @[dut.scala 66:69]
  wire  carry2 = stage2_value[16]; // @[dut.scala 68:25]
  wire [15:0] sum2 = stage2_value[15:0]; // @[dut.scala 67:23]
  wire [16:0] stage2_result = {carry2,sum2}; // @[Cat.scala 33:92]
  reg [15:0] stage1_2_reg; // @[dut.scala 71:29]
  reg [16:0] stage2_reg; // @[dut.scala 72:27]
  reg [31:0] adda_high2_reg; // @[dut.scala 73:31]
  reg [31:0] addb_high2_reg; // @[dut.scala 74:31]
  wire [16:0] _stage3_value_T_2 = adda_high2_reg[15:0] + addb_high2_reg[15:0]; // @[dut.scala 90:44]
  wire [16:0] _GEN_21 = {{16'd0}, stage2_reg[16]}; // @[dut.scala 90:69]
  wire [16:0] stage3_value = _stage3_value_T_2 + _GEN_21; // @[dut.scala 90:69]
  wire  carry3 = stage3_value[16]; // @[dut.scala 92:25]
  wire [15:0] sum3 = stage3_value[15:0]; // @[dut.scala 91:23]
  wire [16:0] stage3_result = {carry3,sum3}; // @[Cat.scala 33:92]
  reg [15:0] stage1_3_reg; // @[dut.scala 95:29]
  reg [15:0] stage2_3_reg; // @[dut.scala 96:29]
  reg [16:0] stage3_reg; // @[dut.scala 97:27]
  reg [15:0] adda_high3_reg; // @[dut.scala 98:31]
  reg [15:0] addb_high3_reg; // @[dut.scala 99:31]
  wire [16:0] _stage4_value_T = adda_high3_reg + addb_high3_reg; // @[dut.scala 116:37]
  wire [16:0] _GEN_22 = {{16'd0}, stage3_reg[16]}; // @[dut.scala 116:55]
  wire [16:0] stage4_value = _stage4_value_T + _GEN_22; // @[dut.scala 116:55]
  wire  carry4 = stage4_value[16]; // @[dut.scala 118:25]
  wire [15:0] sum4 = stage4_value[15:0]; // @[dut.scala 117:23]
  reg [64:0] final_result; // @[dut.scala 121:29]
  reg  o_en_reg; // @[dut.scala 122:25]
  wire [64:0] _final_result_T_1 = {carry4,sum4,stage3_reg[15:0],stage2_3_reg,stage1_3_reg}; // @[Cat.scala 33:92]
  assign io_result = final_result; // @[dut.scala 132:13]
  assign io_o_en = o_en_reg; // @[dut.scala 133:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 19:24]
      en_reg1 <= 1'h0; // @[dut.scala 19:24]
    end else begin
      en_reg1 <= io_i_en;
    end
    if (reset) begin // @[dut.scala 20:24]
      en_reg2 <= 1'h0; // @[dut.scala 20:24]
    end else begin
      en_reg2 <= en_reg1;
    end
    if (reset) begin // @[dut.scala 21:24]
      en_reg3 <= 1'h0; // @[dut.scala 21:24]
    end else begin
      en_reg3 <= en_reg2;
    end
    if (reset) begin // @[dut.scala 22:24]
      en_reg4 <= 1'h0; // @[dut.scala 22:24]
    end else begin
      en_reg4 <= en_reg3;
    end
    if (reset) begin // @[dut.scala 25:25]
      adda_reg <= 64'h0; // @[dut.scala 25:25]
    end else if (io_i_en) begin // @[dut.scala 29:17]
      adda_reg <= io_adda; // @[dut.scala 30:14]
    end
    if (reset) begin // @[dut.scala 26:25]
      addb_reg <= 64'h0; // @[dut.scala 26:25]
    end else if (io_i_en) begin // @[dut.scala 29:17]
      addb_reg <= io_addb; // @[dut.scala 31:14]
    end
    if (reset) begin // @[dut.scala 49:27]
      stage1_reg <= 17'h0; // @[dut.scala 49:27]
    end else if (en_reg1) begin // @[dut.scala 53:17]
      stage1_reg <= stage1_result; // @[dut.scala 54:16]
    end
    if (reset) begin // @[dut.scala 50:31]
      adda_high1_reg <= 48'h0; // @[dut.scala 50:31]
    end else if (en_reg1) begin // @[dut.scala 53:17]
      adda_high1_reg <= adda_reg[63:16]; // @[dut.scala 55:20]
    end
    if (reset) begin // @[dut.scala 51:31]
      addb_high1_reg <= 48'h0; // @[dut.scala 51:31]
    end else if (en_reg1) begin // @[dut.scala 53:17]
      addb_high1_reg <= addb_reg[63:16]; // @[dut.scala 56:20]
    end
    if (reset) begin // @[dut.scala 71:29]
      stage1_2_reg <= 16'h0; // @[dut.scala 71:29]
    end else if (en_reg2) begin // @[dut.scala 76:17]
      stage1_2_reg <= stage1_reg[15:0]; // @[dut.scala 77:18]
    end
    if (reset) begin // @[dut.scala 72:27]
      stage2_reg <= 17'h0; // @[dut.scala 72:27]
    end else if (en_reg2) begin // @[dut.scala 76:17]
      stage2_reg <= stage2_result; // @[dut.scala 78:16]
    end
    if (reset) begin // @[dut.scala 73:31]
      adda_high2_reg <= 32'h0; // @[dut.scala 73:31]
    end else if (en_reg2) begin // @[dut.scala 76:17]
      adda_high2_reg <= adda_high1_reg[47:16]; // @[dut.scala 79:20]
    end
    if (reset) begin // @[dut.scala 74:31]
      addb_high2_reg <= 32'h0; // @[dut.scala 74:31]
    end else if (en_reg2) begin // @[dut.scala 76:17]
      addb_high2_reg <= addb_high1_reg[47:16]; // @[dut.scala 80:20]
    end
    if (reset) begin // @[dut.scala 95:29]
      stage1_3_reg <= 16'h0; // @[dut.scala 95:29]
    end else if (en_reg3) begin // @[dut.scala 101:17]
      stage1_3_reg <= stage1_2_reg; // @[dut.scala 102:18]
    end
    if (reset) begin // @[dut.scala 96:29]
      stage2_3_reg <= 16'h0; // @[dut.scala 96:29]
    end else if (en_reg3) begin // @[dut.scala 101:17]
      stage2_3_reg <= stage2_reg[15:0]; // @[dut.scala 103:18]
    end
    if (reset) begin // @[dut.scala 97:27]
      stage3_reg <= 17'h0; // @[dut.scala 97:27]
    end else if (en_reg3) begin // @[dut.scala 101:17]
      stage3_reg <= stage3_result; // @[dut.scala 104:16]
    end
    if (reset) begin // @[dut.scala 98:31]
      adda_high3_reg <= 16'h0; // @[dut.scala 98:31]
    end else if (en_reg3) begin // @[dut.scala 101:17]
      adda_high3_reg <= adda_high2_reg[31:16]; // @[dut.scala 105:20]
    end
    if (reset) begin // @[dut.scala 99:31]
      addb_high3_reg <= 16'h0; // @[dut.scala 99:31]
    end else if (en_reg3) begin // @[dut.scala 101:17]
      addb_high3_reg <= addb_high2_reg[31:16]; // @[dut.scala 106:20]
    end
    if (reset) begin // @[dut.scala 121:29]
      final_result <= 65'h0; // @[dut.scala 121:29]
    end else if (en_reg4) begin // @[dut.scala 124:17]
      final_result <= _final_result_T_1; // @[dut.scala 125:18]
    end
    if (reset) begin // @[dut.scala 122:25]
      o_en_reg <= 1'h0; // @[dut.scala 122:25]
    end else begin
      o_en_reg <= en_reg4;
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
  en_reg1 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  en_reg2 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  en_reg3 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  en_reg4 = _RAND_3[0:0];
  _RAND_4 = {2{`RANDOM}};
  adda_reg = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  addb_reg = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  stage1_reg = _RAND_6[16:0];
  _RAND_7 = {2{`RANDOM}};
  adda_high1_reg = _RAND_7[47:0];
  _RAND_8 = {2{`RANDOM}};
  addb_high1_reg = _RAND_8[47:0];
  _RAND_9 = {1{`RANDOM}};
  stage1_2_reg = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  stage2_reg = _RAND_10[16:0];
  _RAND_11 = {1{`RANDOM}};
  adda_high2_reg = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  addb_high2_reg = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  stage1_3_reg = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  stage2_3_reg = _RAND_14[15:0];
  _RAND_15 = {1{`RANDOM}};
  stage3_reg = _RAND_15[16:0];
  _RAND_16 = {1{`RANDOM}};
  adda_high3_reg = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  addb_high3_reg = _RAND_17[15:0];
  _RAND_18 = {3{`RANDOM}};
  final_result = _RAND_18[64:0];
  _RAND_19 = {1{`RANDOM}};
  o_en_reg = _RAND_19[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
