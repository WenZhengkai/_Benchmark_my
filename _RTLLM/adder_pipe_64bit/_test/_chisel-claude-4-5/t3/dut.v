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
  reg [63:0] adda_reg1; // @[dut.scala 14:26]
  reg [63:0] adda_reg2; // @[dut.scala 15:26]
  reg [63:0] adda_reg3; // @[dut.scala 16:26]
  reg [63:0] addb_reg1; // @[dut.scala 18:26]
  reg [63:0] addb_reg2; // @[dut.scala 19:26]
  reg [63:0] addb_reg3; // @[dut.scala 20:26]
  reg  i_en_reg1; // @[dut.scala 23:26]
  reg  i_en_reg2; // @[dut.scala 24:26]
  reg  i_en_reg3; // @[dut.scala 25:26]
  reg  i_en_reg4; // @[dut.scala 26:26]
  wire [16:0] sum1 = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 31:26]
  wire  carry1 = sum1[16]; // @[dut.scala 32:17]
  reg [15:0] sum1_reg; // @[dut.scala 34:25]
  reg  carry1_reg; // @[dut.scala 35:27]
  wire [16:0] _sum2_T_2 = adda_reg1[31:16] + addb_reg1[31:16]; // @[dut.scala 40:29]
  wire [16:0] _GEN_0 = {{16'd0}, carry1_reg}; // @[dut.scala 40:50]
  wire [17:0] _sum2_T_3 = _sum2_T_2 + _GEN_0; // @[dut.scala 40:50]
  wire [16:0] sum2 = _sum2_T_3[16:0]; // @[dut.scala 38:18 40:8]
  wire  carry2 = sum2[16]; // @[dut.scala 41:17]
  reg [15:0] sum2_reg; // @[dut.scala 43:25]
  reg  carry2_reg; // @[dut.scala 44:27]
  reg [15:0] sum1_reg2; // @[dut.scala 45:26]
  wire [16:0] _sum3_T_2 = adda_reg2[47:32] + addb_reg2[47:32]; // @[dut.scala 50:29]
  wire [16:0] _GEN_1 = {{16'd0}, carry2_reg}; // @[dut.scala 50:50]
  wire [17:0] _sum3_T_3 = _sum3_T_2 + _GEN_1; // @[dut.scala 50:50]
  wire [16:0] sum3 = _sum3_T_3[16:0]; // @[dut.scala 48:18 50:8]
  wire  carry3 = sum3[16]; // @[dut.scala 51:17]
  reg [15:0] sum3_reg; // @[dut.scala 53:25]
  reg  carry3_reg; // @[dut.scala 54:27]
  reg [15:0] sum2_reg2; // @[dut.scala 55:26]
  reg [15:0] sum1_reg3; // @[dut.scala 56:26]
  wire [16:0] _sum4_T_2 = adda_reg3[63:48] + addb_reg3[63:48]; // @[dut.scala 60:29]
  wire [16:0] _GEN_2 = {{16'd0}, carry3_reg}; // @[dut.scala 60:50]
  wire [17:0] _sum4_T_3 = _sum4_T_2 + _GEN_2; // @[dut.scala 60:50]
  reg [16:0] sum4_reg; // @[dut.scala 62:25]
  reg [15:0] sum3_reg2; // @[dut.scala 63:26]
  reg [15:0] sum2_reg3; // @[dut.scala 64:26]
  reg [15:0] sum1_reg4; // @[dut.scala 65:26]
  wire [31:0] io_result_lo = {sum2_reg3,sum1_reg4}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {sum4_reg,sum3_reg2}; // @[Cat.scala 33:92]
  wire [16:0] sum4 = _sum4_T_3[16:0]; // @[dut.scala 59:18 60:8]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = i_en_reg4; // @[dut.scala 71:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:26]
      adda_reg1 <= 64'h0; // @[dut.scala 14:26]
    end else begin
      adda_reg1 <= io_adda; // @[dut.scala 14:26]
    end
    if (reset) begin // @[dut.scala 15:26]
      adda_reg2 <= 64'h0; // @[dut.scala 15:26]
    end else begin
      adda_reg2 <= adda_reg1; // @[dut.scala 15:26]
    end
    if (reset) begin // @[dut.scala 16:26]
      adda_reg3 <= 64'h0; // @[dut.scala 16:26]
    end else begin
      adda_reg3 <= adda_reg2; // @[dut.scala 16:26]
    end
    if (reset) begin // @[dut.scala 18:26]
      addb_reg1 <= 64'h0; // @[dut.scala 18:26]
    end else begin
      addb_reg1 <= io_addb; // @[dut.scala 18:26]
    end
    if (reset) begin // @[dut.scala 19:26]
      addb_reg2 <= 64'h0; // @[dut.scala 19:26]
    end else begin
      addb_reg2 <= addb_reg1; // @[dut.scala 19:26]
    end
    if (reset) begin // @[dut.scala 20:26]
      addb_reg3 <= 64'h0; // @[dut.scala 20:26]
    end else begin
      addb_reg3 <= addb_reg2; // @[dut.scala 20:26]
    end
    if (reset) begin // @[dut.scala 23:26]
      i_en_reg1 <= 1'h0; // @[dut.scala 23:26]
    end else begin
      i_en_reg1 <= io_i_en; // @[dut.scala 23:26]
    end
    if (reset) begin // @[dut.scala 24:26]
      i_en_reg2 <= 1'h0; // @[dut.scala 24:26]
    end else begin
      i_en_reg2 <= i_en_reg1; // @[dut.scala 24:26]
    end
    if (reset) begin // @[dut.scala 25:26]
      i_en_reg3 <= 1'h0; // @[dut.scala 25:26]
    end else begin
      i_en_reg3 <= i_en_reg2; // @[dut.scala 25:26]
    end
    if (reset) begin // @[dut.scala 26:26]
      i_en_reg4 <= 1'h0; // @[dut.scala 26:26]
    end else begin
      i_en_reg4 <= i_en_reg3; // @[dut.scala 26:26]
    end
    if (reset) begin // @[dut.scala 34:25]
      sum1_reg <= 16'h0; // @[dut.scala 34:25]
    end else begin
      sum1_reg <= sum1[15:0]; // @[dut.scala 34:25]
    end
    if (reset) begin // @[dut.scala 35:27]
      carry1_reg <= 1'h0; // @[dut.scala 35:27]
    end else begin
      carry1_reg <= carry1; // @[dut.scala 35:27]
    end
    if (reset) begin // @[dut.scala 43:25]
      sum2_reg <= 16'h0; // @[dut.scala 43:25]
    end else begin
      sum2_reg <= sum2[15:0]; // @[dut.scala 43:25]
    end
    if (reset) begin // @[dut.scala 44:27]
      carry2_reg <= 1'h0; // @[dut.scala 44:27]
    end else begin
      carry2_reg <= carry2; // @[dut.scala 44:27]
    end
    if (reset) begin // @[dut.scala 45:26]
      sum1_reg2 <= 16'h0; // @[dut.scala 45:26]
    end else begin
      sum1_reg2 <= sum1_reg; // @[dut.scala 45:26]
    end
    if (reset) begin // @[dut.scala 53:25]
      sum3_reg <= 16'h0; // @[dut.scala 53:25]
    end else begin
      sum3_reg <= sum3[15:0]; // @[dut.scala 53:25]
    end
    if (reset) begin // @[dut.scala 54:27]
      carry3_reg <= 1'h0; // @[dut.scala 54:27]
    end else begin
      carry3_reg <= carry3; // @[dut.scala 54:27]
    end
    if (reset) begin // @[dut.scala 55:26]
      sum2_reg2 <= 16'h0; // @[dut.scala 55:26]
    end else begin
      sum2_reg2 <= sum2_reg; // @[dut.scala 55:26]
    end
    if (reset) begin // @[dut.scala 56:26]
      sum1_reg3 <= 16'h0; // @[dut.scala 56:26]
    end else begin
      sum1_reg3 <= sum1_reg2; // @[dut.scala 56:26]
    end
    if (reset) begin // @[dut.scala 62:25]
      sum4_reg <= 17'h0; // @[dut.scala 62:25]
    end else begin
      sum4_reg <= sum4; // @[dut.scala 62:25]
    end
    if (reset) begin // @[dut.scala 63:26]
      sum3_reg2 <= 16'h0; // @[dut.scala 63:26]
    end else begin
      sum3_reg2 <= sum3_reg; // @[dut.scala 63:26]
    end
    if (reset) begin // @[dut.scala 64:26]
      sum2_reg3 <= 16'h0; // @[dut.scala 64:26]
    end else begin
      sum2_reg3 <= sum2_reg2; // @[dut.scala 64:26]
    end
    if (reset) begin // @[dut.scala 65:26]
      sum1_reg4 <= 16'h0; // @[dut.scala 65:26]
    end else begin
      sum1_reg4 <= sum1_reg3; // @[dut.scala 65:26]
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
  adda_reg1 = _RAND_0[63:0];
  _RAND_1 = {2{`RANDOM}};
  adda_reg2 = _RAND_1[63:0];
  _RAND_2 = {2{`RANDOM}};
  adda_reg3 = _RAND_2[63:0];
  _RAND_3 = {2{`RANDOM}};
  addb_reg1 = _RAND_3[63:0];
  _RAND_4 = {2{`RANDOM}};
  addb_reg2 = _RAND_4[63:0];
  _RAND_5 = {2{`RANDOM}};
  addb_reg3 = _RAND_5[63:0];
  _RAND_6 = {1{`RANDOM}};
  i_en_reg1 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  i_en_reg2 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  i_en_reg3 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  i_en_reg4 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  sum1_reg = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  carry1_reg = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  sum2_reg = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  carry2_reg = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  sum1_reg2 = _RAND_14[15:0];
  _RAND_15 = {1{`RANDOM}};
  sum3_reg = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  carry3_reg = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  sum2_reg2 = _RAND_17[15:0];
  _RAND_18 = {1{`RANDOM}};
  sum1_reg3 = _RAND_18[15:0];
  _RAND_19 = {1{`RANDOM}};
  sum4_reg = _RAND_19[16:0];
  _RAND_20 = {1{`RANDOM}};
  sum3_reg2 = _RAND_20[15:0];
  _RAND_21 = {1{`RANDOM}};
  sum2_reg3 = _RAND_21[15:0];
  _RAND_22 = {1{`RANDOM}};
  sum1_reg4 = _RAND_22[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
