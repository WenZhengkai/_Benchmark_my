module RippleCarryAdder16(
  input  [15:0] io_a,
  input  [15:0] io_b,
  input         io_cin,
  output [15:0] io_sum,
  output        io_cout
);
  wire [16:0] _result_T = io_a + io_b; // @[dut.scala 16:21]
  wire [16:0] _GEN_0 = {{16'd0}, io_cin}; // @[dut.scala 16:29]
  wire [16:0] result = _result_T + _GEN_0; // @[dut.scala 16:29]
  assign io_sum = result[15:0]; // @[dut.scala 17:19]
  assign io_cout = result[16]; // @[dut.scala 18:20]
endmodule
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
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
`endif // RANDOMIZE_REG_INIT
  wire [15:0] adder1_io_a; // @[dut.scala 43:22]
  wire [15:0] adder1_io_b; // @[dut.scala 43:22]
  wire  adder1_io_cin; // @[dut.scala 43:22]
  wire [15:0] adder1_io_sum; // @[dut.scala 43:22]
  wire  adder1_io_cout; // @[dut.scala 43:22]
  wire [15:0] adder2_io_a; // @[dut.scala 53:22]
  wire [15:0] adder2_io_b; // @[dut.scala 53:22]
  wire  adder2_io_cin; // @[dut.scala 53:22]
  wire [15:0] adder2_io_sum; // @[dut.scala 53:22]
  wire  adder2_io_cout; // @[dut.scala 53:22]
  wire [15:0] adder3_io_a; // @[dut.scala 63:22]
  wire [15:0] adder3_io_b; // @[dut.scala 63:22]
  wire  adder3_io_cin; // @[dut.scala 63:22]
  wire [15:0] adder3_io_sum; // @[dut.scala 63:22]
  wire  adder3_io_cout; // @[dut.scala 63:22]
  wire [15:0] adder4_io_a; // @[dut.scala 73:22]
  wire [15:0] adder4_io_b; // @[dut.scala 73:22]
  wire  adder4_io_cin; // @[dut.scala 73:22]
  wire [15:0] adder4_io_sum; // @[dut.scala 73:22]
  wire  adder4_io_cout; // @[dut.scala 73:22]
  reg  enReg; // @[dut.scala 32:22]
  reg [15:0] stage1Sum; // @[dut.scala 33:22]
  reg  stage1Cout; // @[dut.scala 34:23]
  reg [15:0] stage2Sum; // @[dut.scala 35:22]
  reg  stage2Cout; // @[dut.scala 36:23]
  reg [15:0] stage3Sum; // @[dut.scala 37:22]
  reg  stage3Cout; // @[dut.scala 38:23]
  reg [15:0] stage4Sum; // @[dut.scala 39:22]
  reg  stage4Cout; // @[dut.scala 40:23]
  reg  REG; // @[dut.scala 57:15]
  reg  REG_1; // @[dut.scala 67:23]
  reg  REG_2; // @[dut.scala 67:15]
  reg  REG_3; // @[dut.scala 77:31]
  reg  REG_4; // @[dut.scala 77:23]
  reg  REG_5; // @[dut.scala 77:15]
  wire [31:0] io_result_lo = {stage2Sum,stage1Sum}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {stage4Cout,stage4Sum,stage3Sum}; // @[Cat.scala 33:92]
  reg  io_o_en_REG; // @[dut.scala 84:37]
  reg  io_o_en_REG_1; // @[dut.scala 84:29]
  reg  io_o_en_REG_2; // @[dut.scala 84:21]
  RippleCarryAdder16 adder1 ( // @[dut.scala 43:22]
    .io_a(adder1_io_a),
    .io_b(adder1_io_b),
    .io_cin(adder1_io_cin),
    .io_sum(adder1_io_sum),
    .io_cout(adder1_io_cout)
  );
  RippleCarryAdder16 adder2 ( // @[dut.scala 53:22]
    .io_a(adder2_io_a),
    .io_b(adder2_io_b),
    .io_cin(adder2_io_cin),
    .io_sum(adder2_io_sum),
    .io_cout(adder2_io_cout)
  );
  RippleCarryAdder16 adder3 ( // @[dut.scala 63:22]
    .io_a(adder3_io_a),
    .io_b(adder3_io_b),
    .io_cin(adder3_io_cin),
    .io_sum(adder3_io_sum),
    .io_cout(adder3_io_cout)
  );
  RippleCarryAdder16 adder4 ( // @[dut.scala 73:22]
    .io_a(adder4_io_a),
    .io_b(adder4_io_b),
    .io_cin(adder4_io_cin),
    .io_sum(adder4_io_sum),
    .io_cout(adder4_io_cout)
  );
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = io_o_en_REG_2; // @[dut.scala 84:11]
  assign adder1_io_a = io_adda[15:0]; // @[dut.scala 44:25]
  assign adder1_io_b = io_addb[15:0]; // @[dut.scala 45:25]
  assign adder1_io_cin = 1'h0; // @[dut.scala 46:17]
  assign adder2_io_a = io_adda[31:16]; // @[dut.scala 54:25]
  assign adder2_io_b = io_addb[31:16]; // @[dut.scala 55:25]
  assign adder2_io_cin = stage1Cout; // @[dut.scala 56:17]
  assign adder3_io_a = io_adda[47:32]; // @[dut.scala 64:25]
  assign adder3_io_b = io_addb[47:32]; // @[dut.scala 65:25]
  assign adder3_io_cin = stage2Cout; // @[dut.scala 66:17]
  assign adder4_io_a = io_adda[63:48]; // @[dut.scala 74:25]
  assign adder4_io_b = io_addb[63:48]; // @[dut.scala 75:25]
  assign adder4_io_cin = stage3Cout; // @[dut.scala 76:17]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 32:22]
      enReg <= 1'h0; // @[dut.scala 32:22]
    end else begin
      enReg <= io_i_en; // @[dut.scala 32:22]
    end
    if (io_i_en) begin // @[dut.scala 47:17]
      stage1Sum <= adder1_io_sum; // @[dut.scala 48:15]
    end
    if (io_i_en) begin // @[dut.scala 47:17]
      stage1Cout <= adder1_io_cout; // @[dut.scala 49:16]
    end
    if (REG) begin // @[dut.scala 57:42]
      stage2Sum <= adder2_io_sum; // @[dut.scala 58:15]
    end
    if (REG) begin // @[dut.scala 57:42]
      stage2Cout <= adder2_io_cout; // @[dut.scala 59:16]
    end
    if (REG_2) begin // @[dut.scala 67:67]
      stage3Sum <= adder3_io_sum; // @[dut.scala 68:15]
    end
    if (REG_2) begin // @[dut.scala 67:67]
      stage3Cout <= adder3_io_cout; // @[dut.scala 69:16]
    end
    if (REG_5) begin // @[dut.scala 77:92]
      stage4Sum <= adder4_io_sum; // @[dut.scala 78:15]
    end
    if (REG_5) begin // @[dut.scala 77:92]
      stage4Cout <= adder4_io_cout; // @[dut.scala 79:16]
    end
    if (reset) begin // @[dut.scala 57:15]
      REG <= 1'h0; // @[dut.scala 57:15]
    end else begin
      REG <= io_i_en; // @[dut.scala 57:15]
    end
    if (reset) begin // @[dut.scala 67:23]
      REG_1 <= 1'h0; // @[dut.scala 67:23]
    end else begin
      REG_1 <= io_i_en; // @[dut.scala 67:23]
    end
    if (reset) begin // @[dut.scala 67:15]
      REG_2 <= 1'h0; // @[dut.scala 67:15]
    end else begin
      REG_2 <= REG_1; // @[dut.scala 67:15]
    end
    if (reset) begin // @[dut.scala 77:31]
      REG_3 <= 1'h0; // @[dut.scala 77:31]
    end else begin
      REG_3 <= io_i_en; // @[dut.scala 77:31]
    end
    if (reset) begin // @[dut.scala 77:23]
      REG_4 <= 1'h0; // @[dut.scala 77:23]
    end else begin
      REG_4 <= REG_3; // @[dut.scala 77:23]
    end
    if (reset) begin // @[dut.scala 77:15]
      REG_5 <= 1'h0; // @[dut.scala 77:15]
    end else begin
      REG_5 <= REG_4; // @[dut.scala 77:15]
    end
    if (reset) begin // @[dut.scala 84:37]
      io_o_en_REG <= 1'h0; // @[dut.scala 84:37]
    end else begin
      io_o_en_REG <= enReg; // @[dut.scala 84:37]
    end
    if (reset) begin // @[dut.scala 84:29]
      io_o_en_REG_1 <= 1'h0; // @[dut.scala 84:29]
    end else begin
      io_o_en_REG_1 <= io_o_en_REG; // @[dut.scala 84:29]
    end
    if (reset) begin // @[dut.scala 84:21]
      io_o_en_REG_2 <= 1'h0; // @[dut.scala 84:21]
    end else begin
      io_o_en_REG_2 <= io_o_en_REG_1; // @[dut.scala 84:21]
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
  enReg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  stage1Sum = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  stage1Cout = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  stage2Sum = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  stage2Cout = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  stage3Sum = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  stage3Cout = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  stage4Sum = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  stage4Cout = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  REG = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  REG_1 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  REG_2 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  REG_3 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  REG_4 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  REG_5 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  io_o_en_REG = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  io_o_en_REG_1 = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  io_o_en_REG_2 = _RAND_17[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
