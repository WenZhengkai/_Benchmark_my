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
  reg [15:0] regA0; // @[dut.scala 15:22]
  reg [15:0] regA1; // @[dut.scala 16:22]
  reg [15:0] regA2; // @[dut.scala 17:22]
  reg [15:0] regA3; // @[dut.scala 18:22]
  reg [15:0] regB0; // @[dut.scala 20:22]
  reg [15:0] regB1; // @[dut.scala 21:22]
  reg [15:0] regB2; // @[dut.scala 22:22]
  reg [15:0] regB3; // @[dut.scala 23:22]
  reg  regC0; // @[dut.scala 25:22]
  reg  regC1; // @[dut.scala 26:22]
  reg  regC2; // @[dut.scala 27:22]
  reg [15:0] regSum0; // @[dut.scala 29:24]
  reg [15:0] regSum1; // @[dut.scala 30:24]
  reg [15:0] regSum2; // @[dut.scala 31:24]
  reg [15:0] regSum3; // @[dut.scala 32:24]
  reg  regSumCarry; // @[dut.scala 33:28]
  reg  regEnable; // @[dut.scala 35:26]
  reg  regEnableDelayed; // @[dut.scala 36:33]
  wire [15:0] chunkA_0 = io_adda[15:0]; // @[dut.scala 39:31]
  wire [15:0] chunkA_1 = io_adda[31:16]; // @[dut.scala 39:47]
  wire [15:0] chunkA_2 = io_adda[47:32]; // @[dut.scala 39:64]
  wire [15:0] chunkA_3 = io_adda[63:48]; // @[dut.scala 39:81]
  wire [15:0] chunkB_0 = io_addb[15:0]; // @[dut.scala 40:31]
  wire [15:0] chunkB_1 = io_addb[31:16]; // @[dut.scala 40:47]
  wire [15:0] chunkB_2 = io_addb[47:32]; // @[dut.scala 40:64]
  wire [15:0] chunkB_3 = io_addb[63:48]; // @[dut.scala 40:81]
  wire [16:0] sum0 = regA0 + regB0; // @[dut.scala 49:22]
  wire [16:0] _sum1_T = regA1 + regB1; // @[dut.scala 61:22]
  wire [16:0] _GEN_18 = {{16'd0}, regC0}; // @[dut.scala 61:31]
  wire [16:0] sum1 = _sum1_T + _GEN_18; // @[dut.scala 61:31]
  wire [16:0] _sum2_T = regA2 + regB2; // @[dut.scala 72:22]
  wire [16:0] _GEN_19 = {{16'd0}, regC1}; // @[dut.scala 72:31]
  wire [16:0] sum2 = _sum2_T + _GEN_19; // @[dut.scala 72:31]
  wire [16:0] _sum3_T = regA3 + regB3; // @[dut.scala 83:22]
  wire [16:0] _GEN_20 = {{16'd0}, regC2}; // @[dut.scala 83:31]
  wire [16:0] sum3 = _sum3_T + _GEN_20; // @[dut.scala 83:31]
  wire [31:0] io_result_lo = {regSum1,regSum0}; // @[Cat.scala 33:92]
  wire [32:0] io_result_hi = {regSumCarry,regSum3,regSum2}; // @[Cat.scala 33:92]
  assign io_result = {io_result_hi,io_result_lo}; // @[Cat.scala 33:92]
  assign io_o_en = regEnableDelayed; // @[dut.scala 90:11]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:22]
      regA0 <= 16'h0; // @[dut.scala 15:22]
    end else if (io_i_en) begin // @[dut.scala 43:17]
      regA0 <= chunkA_0; // @[dut.scala 44:11]
    end
    if (reset) begin // @[dut.scala 16:22]
      regA1 <= 16'h0; // @[dut.scala 16:22]
    end else if (regEnable) begin // @[dut.scala 55:19]
      regA1 <= chunkA_1; // @[dut.scala 56:11]
    end
    if (reset) begin // @[dut.scala 17:22]
      regA2 <= 16'h0; // @[dut.scala 17:22]
    end else if (regEnableDelayed) begin // @[dut.scala 67:26]
      regA2 <= chunkA_2; // @[dut.scala 68:11]
    end
    if (reset) begin // @[dut.scala 18:22]
      regA3 <= 16'h0; // @[dut.scala 18:22]
    end else if (regEnableDelayed) begin // @[dut.scala 78:26]
      regA3 <= chunkA_3; // @[dut.scala 79:11]
    end
    if (reset) begin // @[dut.scala 20:22]
      regB0 <= 16'h0; // @[dut.scala 20:22]
    end else if (io_i_en) begin // @[dut.scala 43:17]
      regB0 <= chunkB_0; // @[dut.scala 45:11]
    end
    if (reset) begin // @[dut.scala 21:22]
      regB1 <= 16'h0; // @[dut.scala 21:22]
    end else if (regEnable) begin // @[dut.scala 55:19]
      regB1 <= chunkB_1; // @[dut.scala 57:11]
    end
    if (reset) begin // @[dut.scala 22:22]
      regB2 <= 16'h0; // @[dut.scala 22:22]
    end else if (regEnableDelayed) begin // @[dut.scala 67:26]
      regB2 <= chunkB_2; // @[dut.scala 69:11]
    end
    if (reset) begin // @[dut.scala 23:22]
      regB3 <= 16'h0; // @[dut.scala 23:22]
    end else if (regEnableDelayed) begin // @[dut.scala 78:26]
      regB3 <= chunkB_3; // @[dut.scala 80:11]
    end
    if (reset) begin // @[dut.scala 25:22]
      regC0 <= 1'h0; // @[dut.scala 25:22]
    end else if (regEnable) begin // @[dut.scala 48:19]
      regC0 <= sum0[16]; // @[dut.scala 51:11]
    end
    if (reset) begin // @[dut.scala 26:22]
      regC1 <= 1'h0; // @[dut.scala 26:22]
    end else if (regEnableDelayed) begin // @[dut.scala 60:26]
      regC1 <= sum1[16]; // @[dut.scala 63:11]
    end
    if (reset) begin // @[dut.scala 27:22]
      regC2 <= 1'h0; // @[dut.scala 27:22]
    end else if (regEnableDelayed) begin // @[dut.scala 71:26]
      regC2 <= sum2[16]; // @[dut.scala 74:11]
    end
    if (reset) begin // @[dut.scala 29:24]
      regSum0 <= 16'h0; // @[dut.scala 29:24]
    end else if (regEnable) begin // @[dut.scala 48:19]
      regSum0 <= sum0[15:0]; // @[dut.scala 50:13]
    end
    if (reset) begin // @[dut.scala 30:24]
      regSum1 <= 16'h0; // @[dut.scala 30:24]
    end else if (regEnableDelayed) begin // @[dut.scala 60:26]
      regSum1 <= sum1[15:0]; // @[dut.scala 62:13]
    end
    if (reset) begin // @[dut.scala 31:24]
      regSum2 <= 16'h0; // @[dut.scala 31:24]
    end else if (regEnableDelayed) begin // @[dut.scala 71:26]
      regSum2 <= sum2[15:0]; // @[dut.scala 73:13]
    end
    if (reset) begin // @[dut.scala 32:24]
      regSum3 <= 16'h0; // @[dut.scala 32:24]
    end else if (regEnableDelayed) begin // @[dut.scala 82:26]
      regSum3 <= sum3[15:0]; // @[dut.scala 84:13]
    end
    if (reset) begin // @[dut.scala 33:28]
      regSumCarry <= 1'h0; // @[dut.scala 33:28]
    end else if (regEnableDelayed) begin // @[dut.scala 82:26]
      regSumCarry <= sum3[16]; // @[dut.scala 85:17]
    end
    if (reset) begin // @[dut.scala 35:26]
      regEnable <= 1'h0; // @[dut.scala 35:26]
    end else if (io_i_en) begin // @[dut.scala 43:17]
      regEnable <= io_i_en; // @[dut.scala 46:15]
    end
    if (reset) begin // @[dut.scala 36:33]
      regEnableDelayed <= 1'h0; // @[dut.scala 36:33]
    end else if (regEnable) begin // @[dut.scala 55:19]
      regEnableDelayed <= regEnable; // @[dut.scala 58:22]
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
  regA0 = _RAND_0[15:0];
  _RAND_1 = {1{`RANDOM}};
  regA1 = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  regA2 = _RAND_2[15:0];
  _RAND_3 = {1{`RANDOM}};
  regA3 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  regB0 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  regB1 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  regB2 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  regB3 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  regC0 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  regC1 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  regC2 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  regSum0 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  regSum1 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  regSum2 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  regSum3 = _RAND_14[15:0];
  _RAND_15 = {1{`RANDOM}};
  regSumCarry = _RAND_15[0:0];
  _RAND_16 = {1{`RANDOM}};
  regEnable = _RAND_16[0:0];
  _RAND_17 = {1{`RANDOM}};
  regEnableDelayed = _RAND_17[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
