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
  reg [95:0] _RAND_18;
`endif // RANDOMIZE_REG_INIT
  reg  en_reg1; // @[dut.scala 17:24]
  reg  en_reg2; // @[dut.scala 18:24]
  reg  en_reg3; // @[dut.scala 19:24]
  reg  en_reg4; // @[dut.scala 20:24]
  reg [63:0] adda_reg; // @[dut.scala 23:25]
  reg [63:0] addb_reg; // @[dut.scala 24:25]
  reg [15:0] sum2; // @[dut.scala 34:21]
  reg  carry2; // @[dut.scala 35:23]
  reg [15:0] adda2; // @[dut.scala 36:22]
  reg [15:0] addb2; // @[dut.scala 37:22]
  reg [15:0] sum3; // @[dut.scala 41:21]
  reg  carry3; // @[dut.scala 42:23]
  reg [15:0] adda3; // @[dut.scala 43:22]
  reg [15:0] addb3; // @[dut.scala 44:22]
  reg [15:0] sum4; // @[dut.scala 48:21]
  reg  carry4; // @[dut.scala 49:23]
  reg [15:0] adda4; // @[dut.scala 50:22]
  reg [15:0] addb4; // @[dut.scala 51:22]
  reg [64:0] final_sum; // @[dut.scala 55:26]
  wire [15:0] adda1 = adda_reg[15:0]; // @[dut.scala 70:20]
  wire [15:0] addb1 = addb_reg[15:0]; // @[dut.scala 71:20]
  wire [16:0] stage1_result = adda1 + addb1; // @[dut.scala 72:26]
  wire [15:0] sum1 = stage1_result[15:0]; // @[dut.scala 73:24]
  wire  carry1 = stage1_result[16]; // @[dut.scala 74:26]
  wire [16:0] _stage2_result_T = adda2 + addb2; // @[dut.scala 83:26]
  wire [16:0] _GEN_15 = {{16'd0}, carry2}; // @[dut.scala 83:35]
  wire [17:0] _stage2_result_T_1 = _stage2_result_T + _GEN_15; // @[dut.scala 83:35]
  wire [16:0] stage2_result = _stage2_result_T_1[16:0]; // @[dut.scala 38:27 83:17]
  wire [16:0] _stage3_result_T = adda3 + addb3; // @[dut.scala 92:26]
  wire [16:0] _GEN_16 = {{16'd0}, carry3}; // @[dut.scala 92:35]
  wire [17:0] _stage3_result_T_1 = _stage3_result_T + _GEN_16; // @[dut.scala 92:35]
  wire [16:0] stage3_result = _stage3_result_T_1[16:0]; // @[dut.scala 45:27 92:17]
  wire [16:0] _stage4_result_T = adda4 + addb4; // @[dut.scala 101:26]
  wire [16:0] _GEN_17 = {{16'd0}, carry4}; // @[dut.scala 101:35]
  wire [17:0] _stage4_result_T_1 = _stage4_result_T + _GEN_17; // @[dut.scala 101:35]
  wire [16:0] stage4_result = _stage4_result_T_1[16:0]; // @[dut.scala 101:17 52:27]
  wire [64:0] _final_sum_T_2 = {stage4_result[16],stage4_result[15:0],sum4,sum3,sum2}; // @[Cat.scala 33:92]
  assign io_result = final_sum; // @[dut.scala 109:13]
  assign io_o_en = en_reg4; // @[dut.scala 110:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:24]
      en_reg1 <= 1'h0; // @[dut.scala 17:24]
    end else begin
      en_reg1 <= io_i_en; // @[dut.scala 58:11]
    end
    if (reset) begin // @[dut.scala 18:24]
      en_reg2 <= 1'h0; // @[dut.scala 18:24]
    end else begin
      en_reg2 <= en_reg1; // @[dut.scala 59:11]
    end
    if (reset) begin // @[dut.scala 19:24]
      en_reg3 <= 1'h0; // @[dut.scala 19:24]
    end else begin
      en_reg3 <= en_reg2; // @[dut.scala 60:11]
    end
    if (reset) begin // @[dut.scala 20:24]
      en_reg4 <= 1'h0; // @[dut.scala 20:24]
    end else begin
      en_reg4 <= en_reg3; // @[dut.scala 61:11]
    end
    if (reset) begin // @[dut.scala 23:25]
      adda_reg <= 64'h0; // @[dut.scala 23:25]
    end else if (io_i_en) begin // @[dut.scala 64:18]
      adda_reg <= io_adda; // @[dut.scala 65:14]
    end
    if (reset) begin // @[dut.scala 24:25]
      addb_reg <= 64'h0; // @[dut.scala 24:25]
    end else if (io_i_en) begin // @[dut.scala 64:18]
      addb_reg <= io_addb; // @[dut.scala 66:14]
    end
    if (reset) begin // @[dut.scala 34:21]
      sum2 <= 16'h0; // @[dut.scala 34:21]
    end else if (en_reg1) begin // @[dut.scala 77:18]
      sum2 <= sum1; // @[dut.scala 78:10]
    end
    if (reset) begin // @[dut.scala 35:23]
      carry2 <= 1'h0; // @[dut.scala 35:23]
    end else if (en_reg1) begin // @[dut.scala 77:18]
      carry2 <= carry1; // @[dut.scala 81:12]
    end
    if (reset) begin // @[dut.scala 36:22]
      adda2 <= 16'h0; // @[dut.scala 36:22]
    end else if (en_reg1) begin // @[dut.scala 77:18]
      adda2 <= adda_reg[31:16]; // @[dut.scala 79:11]
    end
    if (reset) begin // @[dut.scala 37:22]
      addb2 <= 16'h0; // @[dut.scala 37:22]
    end else if (en_reg1) begin // @[dut.scala 77:18]
      addb2 <= addb_reg[31:16]; // @[dut.scala 80:11]
    end
    if (reset) begin // @[dut.scala 41:21]
      sum3 <= 16'h0; // @[dut.scala 41:21]
    end else if (en_reg2) begin // @[dut.scala 86:18]
      sum3 <= stage2_result[15:0]; // @[dut.scala 87:10]
    end
    if (reset) begin // @[dut.scala 42:23]
      carry3 <= 1'h0; // @[dut.scala 42:23]
    end else if (en_reg2) begin // @[dut.scala 86:18]
      carry3 <= stage2_result[16]; // @[dut.scala 90:12]
    end
    if (reset) begin // @[dut.scala 43:22]
      adda3 <= 16'h0; // @[dut.scala 43:22]
    end else if (en_reg2) begin // @[dut.scala 86:18]
      adda3 <= adda_reg[47:32]; // @[dut.scala 88:11]
    end
    if (reset) begin // @[dut.scala 44:22]
      addb3 <= 16'h0; // @[dut.scala 44:22]
    end else if (en_reg2) begin // @[dut.scala 86:18]
      addb3 <= addb_reg[47:32]; // @[dut.scala 89:11]
    end
    if (reset) begin // @[dut.scala 48:21]
      sum4 <= 16'h0; // @[dut.scala 48:21]
    end else if (en_reg3) begin // @[dut.scala 95:18]
      sum4 <= stage3_result[15:0]; // @[dut.scala 96:10]
    end
    if (reset) begin // @[dut.scala 49:23]
      carry4 <= 1'h0; // @[dut.scala 49:23]
    end else if (en_reg3) begin // @[dut.scala 95:18]
      carry4 <= stage3_result[16]; // @[dut.scala 99:12]
    end
    if (reset) begin // @[dut.scala 50:22]
      adda4 <= 16'h0; // @[dut.scala 50:22]
    end else if (en_reg3) begin // @[dut.scala 95:18]
      adda4 <= adda_reg[63:48]; // @[dut.scala 97:11]
    end
    if (reset) begin // @[dut.scala 51:22]
      addb4 <= 16'h0; // @[dut.scala 51:22]
    end else if (en_reg3) begin // @[dut.scala 95:18]
      addb4 <= addb_reg[63:48]; // @[dut.scala 98:11]
    end
    if (reset) begin // @[dut.scala 55:26]
      final_sum <= 65'h0; // @[dut.scala 55:26]
    end else if (en_reg4) begin // @[dut.scala 104:18]
      final_sum <= _final_sum_T_2; // @[dut.scala 105:15]
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
  sum2 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  carry2 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  adda2 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  addb2 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  sum3 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  carry3 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  adda3 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  addb3 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  sum4 = _RAND_14[15:0];
  _RAND_15 = {1{`RANDOM}};
  carry4 = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  adda4 = _RAND_16[15:0];
  _RAND_17 = {1{`RANDOM}};
  addb4 = _RAND_17[15:0];
  _RAND_18 = {3{`RANDOM}};
  final_sum = _RAND_18[64:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
