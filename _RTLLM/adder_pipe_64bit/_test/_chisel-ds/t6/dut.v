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
`endif // RANDOMIZE_REG_INIT
  reg [15:0] stage1_adda; // @[dut.scala 14:28]
  reg [15:0] stage1_addb; // @[dut.scala 15:28]
  reg  stage1_en; // @[dut.scala 17:26]
  reg [15:0] stage2_adda; // @[dut.scala 19:28]
  reg [15:0] stage2_addb; // @[dut.scala 20:28]
  reg  stage2_carry; // @[dut.scala 21:29]
  reg  stage2_en; // @[dut.scala 22:26]
  reg [15:0] stage3_adda; // @[dut.scala 24:28]
  reg [15:0] stage3_addb; // @[dut.scala 25:28]
  reg  stage3_carry; // @[dut.scala 26:29]
  reg  stage3_en; // @[dut.scala 27:26]
  reg [15:0] stage4_adda; // @[dut.scala 29:28]
  reg [15:0] stage4_addb; // @[dut.scala 30:28]
  reg  stage4_carry; // @[dut.scala 31:29]
  reg  stage4_en; // @[dut.scala 32:26]
  wire [16:0] _stage2_carry_T = stage1_adda + stage1_addb; // @[dut.scala 45:34]
  wire [16:0] _stage3_carry_T = stage2_adda + stage2_addb; // @[dut.scala 51:34]
  wire [16:0] _GEN_16 = {{16'd0}, stage2_carry}; // @[dut.scala 51:49]
  wire [17:0] _stage3_carry_T_1 = _stage3_carry_T + _GEN_16; // @[dut.scala 51:49]
  wire [16:0] _stage4_carry_T = stage3_adda + stage3_addb; // @[dut.scala 57:34]
  wire [16:0] _GEN_17 = {{16'd0}, stage3_carry}; // @[dut.scala 57:49]
  wire [17:0] _stage4_carry_T_1 = _stage4_carry_T + _GEN_17; // @[dut.scala 57:49]
  wire  _GEN_7 = io_i_en & stage1_en; // @[dut.scala 35:17 46:15 62:15]
  wire  _GEN_11 = io_i_en & stage2_en; // @[dut.scala 35:17 52:15 63:15]
  wire  _GEN_15 = io_i_en & stage3_en; // @[dut.scala 35:17 58:15 64:15]
  wire [15:0] sum1 = stage1_adda + stage1_addb; // @[dut.scala 68:26]
  wire [15:0] _sum2_T_1 = stage2_adda + stage2_addb; // @[dut.scala 69:26]
  wire [15:0] _GEN_18 = {{15'd0}, stage2_carry}; // @[dut.scala 69:40]
  wire [15:0] sum2 = _sum2_T_1 + _GEN_18; // @[dut.scala 69:40]
  wire [15:0] _sum3_T_1 = stage3_adda + stage3_addb; // @[dut.scala 70:26]
  wire [15:0] _GEN_19 = {{15'd0}, stage3_carry}; // @[dut.scala 70:40]
  wire [15:0] sum3 = _sum3_T_1 + _GEN_19; // @[dut.scala 70:40]
  wire [15:0] _sum4_T_1 = stage4_adda + stage4_addb; // @[dut.scala 71:26]
  wire [15:0] _GEN_20 = {{15'd0}, stage4_carry}; // @[dut.scala 71:40]
  wire [15:0] sum4 = _sum4_T_1 + _GEN_20; // @[dut.scala 71:40]
  wire [63:0] _io_result_T_4 = {sum4,sum3,sum2,sum1}; // @[Cat.scala 33:92]
  assign io_result = {{1'd0}, _io_result_T_4}; // @[dut.scala 74:13]
  assign io_o_en = stage4_en; // @[dut.scala 77:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:28]
      stage1_adda <= 16'h0; // @[dut.scala 14:28]
    end else if (io_i_en) begin // @[dut.scala 35:17]
      stage1_adda <= io_adda[15:0]; // @[dut.scala 37:17]
    end
    if (reset) begin // @[dut.scala 15:28]
      stage1_addb <= 16'h0; // @[dut.scala 15:28]
    end else if (io_i_en) begin // @[dut.scala 35:17]
      stage1_addb <= io_addb[15:0]; // @[dut.scala 38:17]
    end
    if (reset) begin // @[dut.scala 17:26]
      stage1_en <= 1'h0; // @[dut.scala 17:26]
    end else begin
      stage1_en <= io_i_en;
    end
    if (reset) begin // @[dut.scala 19:28]
      stage2_adda <= 16'h0; // @[dut.scala 19:28]
    end else if (io_i_en) begin // @[dut.scala 35:17]
      stage2_adda <= io_adda[31:16]; // @[dut.scala 43:17]
    end
    if (reset) begin // @[dut.scala 20:28]
      stage2_addb <= 16'h0; // @[dut.scala 20:28]
    end else if (io_i_en) begin // @[dut.scala 35:17]
      stage2_addb <= io_addb[31:16]; // @[dut.scala 44:17]
    end
    if (reset) begin // @[dut.scala 21:29]
      stage2_carry <= 1'h0; // @[dut.scala 21:29]
    end else if (io_i_en) begin // @[dut.scala 35:17]
      stage2_carry <= _stage2_carry_T[16]; // @[dut.scala 45:18]
    end
    if (reset) begin // @[dut.scala 22:26]
      stage2_en <= 1'h0; // @[dut.scala 22:26]
    end else begin
      stage2_en <= _GEN_7;
    end
    if (reset) begin // @[dut.scala 24:28]
      stage3_adda <= 16'h0; // @[dut.scala 24:28]
    end else if (io_i_en) begin // @[dut.scala 35:17]
      stage3_adda <= io_adda[47:32]; // @[dut.scala 49:17]
    end
    if (reset) begin // @[dut.scala 25:28]
      stage3_addb <= 16'h0; // @[dut.scala 25:28]
    end else if (io_i_en) begin // @[dut.scala 35:17]
      stage3_addb <= io_addb[47:32]; // @[dut.scala 50:17]
    end
    if (reset) begin // @[dut.scala 26:29]
      stage3_carry <= 1'h0; // @[dut.scala 26:29]
    end else if (io_i_en) begin // @[dut.scala 35:17]
      stage3_carry <= _stage3_carry_T_1[16]; // @[dut.scala 51:18]
    end
    if (reset) begin // @[dut.scala 27:26]
      stage3_en <= 1'h0; // @[dut.scala 27:26]
    end else begin
      stage3_en <= _GEN_11;
    end
    if (reset) begin // @[dut.scala 29:28]
      stage4_adda <= 16'h0; // @[dut.scala 29:28]
    end else if (io_i_en) begin // @[dut.scala 35:17]
      stage4_adda <= io_adda[63:48]; // @[dut.scala 55:17]
    end
    if (reset) begin // @[dut.scala 30:28]
      stage4_addb <= 16'h0; // @[dut.scala 30:28]
    end else if (io_i_en) begin // @[dut.scala 35:17]
      stage4_addb <= io_addb[63:48]; // @[dut.scala 56:17]
    end
    if (reset) begin // @[dut.scala 31:29]
      stage4_carry <= 1'h0; // @[dut.scala 31:29]
    end else if (io_i_en) begin // @[dut.scala 35:17]
      stage4_carry <= _stage4_carry_T_1[16]; // @[dut.scala 57:18]
    end
    if (reset) begin // @[dut.scala 32:26]
      stage4_en <= 1'h0; // @[dut.scala 32:26]
    end else begin
      stage4_en <= _GEN_15;
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
  stage1_adda = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  stage1_addb = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  stage1_en = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  stage2_adda = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  stage2_addb = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  stage2_carry = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  stage2_en = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  stage3_adda = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  stage3_addb = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  stage3_carry = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  stage3_en = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  stage4_adda = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  stage4_addb = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  stage4_carry = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  stage4_en = _RAND_14[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
