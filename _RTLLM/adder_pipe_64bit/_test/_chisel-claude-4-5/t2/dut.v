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
  reg  carry1; // @[dut.scala 30:23]
  reg [15:0] partial_sum1; // @[dut.scala 31:29]
  wire [15:0] _sum1_T_3 = io_adda[15:0] + io_addb[15:0]; // @[dut.scala 33:26]
  wire [16:0] sum1 = {{1'd0}, _sum1_T_3}; // @[dut.scala 29:18 33:8]
  reg  carry2; // @[dut.scala 39:23]
  reg [15:0] partial_sum2; // @[dut.scala 40:29]
  wire [15:0] _sum2_T_3 = adda_reg1[31:16] + addb_reg1[31:16]; // @[dut.scala 42:29]
  wire [15:0] _GEN_0 = {{15'd0}, carry1}; // @[dut.scala 42:49]
  wire [15:0] _sum2_T_5 = _sum2_T_3 + _GEN_0; // @[dut.scala 42:49]
  wire [16:0] sum2 = {{1'd0}, _sum2_T_5}; // @[dut.scala 38:18 42:8]
  reg  carry3; // @[dut.scala 48:23]
  reg [15:0] partial_sum3; // @[dut.scala 49:29]
  wire [15:0] _sum3_T_3 = adda_reg2[47:32] + addb_reg2[47:32]; // @[dut.scala 51:29]
  wire [15:0] _GEN_1 = {{15'd0}, carry2}; // @[dut.scala 51:49]
  wire [15:0] _sum3_T_5 = _sum3_T_3 + _GEN_1; // @[dut.scala 51:49]
  wire [16:0] sum3 = {{1'd0}, _sum3_T_5}; // @[dut.scala 47:18 51:8]
  reg  carry4; // @[dut.scala 57:23]
  reg [15:0] partial_sum4; // @[dut.scala 58:29]
  wire [15:0] _sum4_T_3 = adda_reg3[63:48] + addb_reg3[63:48]; // @[dut.scala 60:29]
  wire [15:0] _GEN_2 = {{15'd0}, carry3}; // @[dut.scala 60:49]
  wire [15:0] _sum4_T_5 = _sum4_T_3 + _GEN_2; // @[dut.scala 60:49]
  wire [16:0] sum4 = {{1'd0}, _sum4_T_5}; // @[dut.scala 56:18 60:8]
  wire [31:0] io_result_lo = {partial_sum2,partial_sum1}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {carry4,partial_sum4,partial_sum3}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = i_en_reg4; // @[dut.scala 68:11]
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
    if (reset) begin // @[dut.scala 30:23]
      carry1 <= 1'h0; // @[dut.scala 30:23]
    end else begin
      carry1 <= sum1[16]; // @[dut.scala 35:10]
    end
    if (reset) begin // @[dut.scala 31:29]
      partial_sum1 <= 16'h0; // @[dut.scala 31:29]
    end else begin
      partial_sum1 <= sum1[15:0]; // @[dut.scala 34:16]
    end
    if (reset) begin // @[dut.scala 39:23]
      carry2 <= 1'h0; // @[dut.scala 39:23]
    end else begin
      carry2 <= sum2[16]; // @[dut.scala 44:10]
    end
    if (reset) begin // @[dut.scala 40:29]
      partial_sum2 <= 16'h0; // @[dut.scala 40:29]
    end else begin
      partial_sum2 <= sum2[15:0]; // @[dut.scala 43:16]
    end
    if (reset) begin // @[dut.scala 48:23]
      carry3 <= 1'h0; // @[dut.scala 48:23]
    end else begin
      carry3 <= sum3[16]; // @[dut.scala 53:10]
    end
    if (reset) begin // @[dut.scala 49:29]
      partial_sum3 <= 16'h0; // @[dut.scala 49:29]
    end else begin
      partial_sum3 <= sum3[15:0]; // @[dut.scala 52:16]
    end
    if (reset) begin // @[dut.scala 57:23]
      carry4 <= 1'h0; // @[dut.scala 57:23]
    end else begin
      carry4 <= sum4[16]; // @[dut.scala 62:10]
    end
    if (reset) begin // @[dut.scala 58:29]
      partial_sum4 <= 16'h0; // @[dut.scala 58:29]
    end else begin
      partial_sum4 <= sum4[15:0]; // @[dut.scala 61:16]
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
  carry1 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  partial_sum1 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  carry2 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  partial_sum2 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  carry3 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  partial_sum3 = _RAND_15[15:0];
  _RAND_16 = {1{`RANDOM}};
  carry4 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  partial_sum4 = _RAND_17[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
