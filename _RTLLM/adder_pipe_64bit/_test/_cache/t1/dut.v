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
`endif // RANDOMIZE_REG_INIT
  reg  en_reg; // @[dut.scala 17:23]
  reg  en_reg2; // @[dut.scala 18:24]
  reg  en_reg3; // @[dut.scala 19:24]
  reg  en_reg4; // @[dut.scala 20:24]
  reg [63:0] adda_reg; // @[dut.scala 32:25]
  reg [63:0] addb_reg; // @[dut.scala 33:25]
  reg  carry1; // @[dut.scala 42:23]
  reg  carry2; // @[dut.scala 43:23]
  reg  carry3; // @[dut.scala 44:23]
  reg [15:0] sum1; // @[dut.scala 47:21]
  reg [15:0] sum2; // @[dut.scala 48:21]
  reg [15:0] sum3; // @[dut.scala 49:21]
  reg [15:0] sum4; // @[dut.scala 50:21]
  wire [16:0] stage1Sum = adda_reg[15:0] + addb_reg[15:0]; // @[dut.scala 53:35]
  wire [16:0] _stage2Sum_T_2 = adda_reg[31:16] + addb_reg[31:16]; // @[dut.scala 60:36]
  wire [16:0] _GEN_9 = {{16'd0}, carry1}; // @[dut.scala 60:56]
  wire [16:0] stage2Sum = _stage2Sum_T_2 + _GEN_9; // @[dut.scala 60:56]
  wire [16:0] _stage3Sum_T_2 = adda_reg[47:32] + addb_reg[47:32]; // @[dut.scala 67:36]
  wire [16:0] _GEN_10 = {{16'd0}, carry2}; // @[dut.scala 67:56]
  wire [16:0] stage3Sum = _stage3Sum_T_2 + _GEN_10; // @[dut.scala 67:56]
  wire [16:0] _stage4Sum_T_2 = adda_reg[63:48] + addb_reg[63:48]; // @[dut.scala 74:36]
  wire [16:0] _GEN_11 = {{16'd0}, carry3}; // @[dut.scala 74:56]
  wire [16:0] stage4Sum = _stage4Sum_T_2 + _GEN_11; // @[dut.scala 74:56]
  wire [31:0] io_result_lo = {sum2,sum1}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {stage4Sum[16],sum4,sum3}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = en_reg4; // @[dut.scala 29:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 17:23]
      en_reg <= 1'h0; // @[dut.scala 17:23]
    end else begin
      en_reg <= io_i_en; // @[dut.scala 23:10]
    end
    if (reset) begin // @[dut.scala 18:24]
      en_reg2 <= 1'h0; // @[dut.scala 18:24]
    end else begin
      en_reg2 <= en_reg; // @[dut.scala 24:11]
    end
    if (reset) begin // @[dut.scala 19:24]
      en_reg3 <= 1'h0; // @[dut.scala 19:24]
    end else begin
      en_reg3 <= en_reg2; // @[dut.scala 25:11]
    end
    if (reset) begin // @[dut.scala 20:24]
      en_reg4 <= 1'h0; // @[dut.scala 20:24]
    end else begin
      en_reg4 <= en_reg3; // @[dut.scala 26:11]
    end
    if (reset) begin // @[dut.scala 32:25]
      adda_reg <= 64'h0; // @[dut.scala 32:25]
    end else if (io_i_en) begin // @[dut.scala 35:17]
      adda_reg <= io_adda; // @[dut.scala 36:14]
    end
    if (reset) begin // @[dut.scala 33:25]
      addb_reg <= 64'h0; // @[dut.scala 33:25]
    end else if (io_i_en) begin // @[dut.scala 35:17]
      addb_reg <= io_addb; // @[dut.scala 37:14]
    end
    if (reset) begin // @[dut.scala 42:23]
      carry1 <= 1'h0; // @[dut.scala 42:23]
    end else if (en_reg) begin // @[dut.scala 54:16]
      carry1 <= stage1Sum[16]; // @[dut.scala 56:12]
    end
    if (reset) begin // @[dut.scala 43:23]
      carry2 <= 1'h0; // @[dut.scala 43:23]
    end else if (en_reg2) begin // @[dut.scala 61:17]
      carry2 <= stage2Sum[16]; // @[dut.scala 63:12]
    end
    if (reset) begin // @[dut.scala 44:23]
      carry3 <= 1'h0; // @[dut.scala 44:23]
    end else if (en_reg3) begin // @[dut.scala 68:17]
      carry3 <= stage3Sum[16]; // @[dut.scala 70:12]
    end
    if (reset) begin // @[dut.scala 47:21]
      sum1 <= 16'h0; // @[dut.scala 47:21]
    end else if (en_reg) begin // @[dut.scala 54:16]
      sum1 <= stage1Sum[15:0]; // @[dut.scala 55:10]
    end
    if (reset) begin // @[dut.scala 48:21]
      sum2 <= 16'h0; // @[dut.scala 48:21]
    end else if (en_reg2) begin // @[dut.scala 61:17]
      sum2 <= stage2Sum[15:0]; // @[dut.scala 62:10]
    end
    if (reset) begin // @[dut.scala 49:21]
      sum3 <= 16'h0; // @[dut.scala 49:21]
    end else if (en_reg3) begin // @[dut.scala 68:17]
      sum3 <= stage3Sum[15:0]; // @[dut.scala 69:10]
    end
    if (reset) begin // @[dut.scala 50:21]
      sum4 <= 16'h0; // @[dut.scala 50:21]
    end else if (en_reg4) begin // @[dut.scala 75:17]
      sum4 <= stage4Sum[15:0]; // @[dut.scala 76:10]
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
  en_reg = _RAND_0[0:0];
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
  carry1 = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  carry2 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  carry3 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  sum1 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  sum2 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  sum3 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  sum4 = _RAND_12[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
