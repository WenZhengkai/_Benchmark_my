module dut(
  input         clock,
  input         reset,
  input         io_clk,
  input         io_rst_n,
  input         io_mul_en_in,
  input  [7:0]  io_mul_a,
  input  [7:0]  io_mul_b,
  output        io_mul_en_out,
  output [15:0] io_mul_out
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
`endif // RANDOMIZE_REG_INIT
  reg  mul_en_out_reg; // @[dut.scala 16:31]
  reg [7:0] mul_a_reg; // @[dut.scala 17:26]
  reg [7:0] mul_b_reg; // @[dut.scala 18:26]
  reg [15:0] partialProducts_0; // @[dut.scala 19:28]
  reg [15:0] partialProducts_1; // @[dut.scala 19:28]
  reg [15:0] partialProducts_2; // @[dut.scala 19:28]
  reg [15:0] partialProducts_3; // @[dut.scala 19:28]
  reg [15:0] partialProducts_4; // @[dut.scala 19:28]
  reg [15:0] partialProducts_5; // @[dut.scala 19:28]
  reg [15:0] partialProducts_6; // @[dut.scala 19:28]
  reg [15:0] partialProducts_7; // @[dut.scala 19:28]
  reg [15:0] accumulatedSum; // @[dut.scala 20:31]
  wire [7:0] _partialProducts_0_T_2 = mul_b_reg[0] ? mul_a_reg : 8'h0; // @[dut.scala 35:30]
  wire [8:0] _partialProducts_1_T_1 = {mul_a_reg, 1'h0}; // @[dut.scala 35:55]
  wire [8:0] _partialProducts_1_T_2 = mul_b_reg[1] ? _partialProducts_1_T_1 : 9'h0; // @[dut.scala 35:30]
  wire [9:0] _partialProducts_2_T_1 = {mul_a_reg, 2'h0}; // @[dut.scala 35:55]
  wire [9:0] _partialProducts_2_T_2 = mul_b_reg[2] ? _partialProducts_2_T_1 : 10'h0; // @[dut.scala 35:30]
  wire [10:0] _partialProducts_3_T_1 = {mul_a_reg, 3'h0}; // @[dut.scala 35:55]
  wire [10:0] _partialProducts_3_T_2 = mul_b_reg[3] ? _partialProducts_3_T_1 : 11'h0; // @[dut.scala 35:30]
  wire [11:0] _partialProducts_4_T_1 = {mul_a_reg, 4'h0}; // @[dut.scala 35:55]
  wire [11:0] _partialProducts_4_T_2 = mul_b_reg[4] ? _partialProducts_4_T_1 : 12'h0; // @[dut.scala 35:30]
  wire [12:0] _partialProducts_5_T_1 = {mul_a_reg, 5'h0}; // @[dut.scala 35:55]
  wire [12:0] _partialProducts_5_T_2 = mul_b_reg[5] ? _partialProducts_5_T_1 : 13'h0; // @[dut.scala 35:30]
  wire [13:0] _partialProducts_6_T_1 = {mul_a_reg, 6'h0}; // @[dut.scala 35:55]
  wire [13:0] _partialProducts_6_T_2 = mul_b_reg[6] ? _partialProducts_6_T_1 : 14'h0; // @[dut.scala 35:30]
  wire [14:0] _partialProducts_7_T_1 = {mul_a_reg, 7'h0}; // @[dut.scala 35:55]
  wire [14:0] _partialProducts_7_T_2 = mul_b_reg[7] ? _partialProducts_7_T_1 : 15'h0; // @[dut.scala 35:30]
  wire [16:0] _accumulatedSum_T = partialProducts_0 + partialProducts_1; // @[dut.scala 39:46]
  wire [16:0] _GEN_6 = {{1'd0}, partialProducts_2}; // @[dut.scala 39:46]
  wire [17:0] _accumulatedSum_T_1 = _accumulatedSum_T + _GEN_6; // @[dut.scala 39:46]
  wire [17:0] _GEN_7 = {{2'd0}, partialProducts_3}; // @[dut.scala 39:46]
  wire [18:0] _accumulatedSum_T_2 = _accumulatedSum_T_1 + _GEN_7; // @[dut.scala 39:46]
  wire [18:0] _GEN_8 = {{3'd0}, partialProducts_4}; // @[dut.scala 39:46]
  wire [19:0] _accumulatedSum_T_3 = _accumulatedSum_T_2 + _GEN_8; // @[dut.scala 39:46]
  wire [19:0] _GEN_9 = {{4'd0}, partialProducts_5}; // @[dut.scala 39:46]
  wire [20:0] _accumulatedSum_T_4 = _accumulatedSum_T_3 + _GEN_9; // @[dut.scala 39:46]
  wire [20:0] _GEN_10 = {{5'd0}, partialProducts_6}; // @[dut.scala 39:46]
  wire [21:0] _accumulatedSum_T_5 = _accumulatedSum_T_4 + _GEN_10; // @[dut.scala 39:46]
  wire [21:0] _GEN_11 = {{6'd0}, partialProducts_7}; // @[dut.scala 39:46]
  wire [22:0] _accumulatedSum_T_6 = _accumulatedSum_T_5 + _GEN_11; // @[dut.scala 39:46]
  wire [22:0] _GEN_12 = reset ? 23'h0 : _accumulatedSum_T_6; // @[dut.scala 20:{31,31} 39:18]
  assign io_mul_en_out = mul_en_out_reg; // @[dut.scala 42:17]
  assign io_mul_out = mul_en_out_reg ? accumulatedSum : 16'h0; // @[dut.scala 43:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 16:31]
      mul_en_out_reg <= 1'h0; // @[dut.scala 16:31]
    end else if (~io_rst_n) begin // @[dut.scala 23:30]
      mul_en_out_reg <= 1'h0; // @[dut.scala 24:20]
    end else if (io_mul_en_in) begin // @[dut.scala 27:29]
      mul_en_out_reg <= io_mul_en_in; // @[dut.scala 28:20]
    end
    if (reset) begin // @[dut.scala 17:26]
      mul_a_reg <= 8'h0; // @[dut.scala 17:26]
    end else if (~io_rst_n) begin // @[dut.scala 23:30]
      mul_a_reg <= 8'h0; // @[dut.scala 25:15]
    end else if (io_mul_en_in) begin // @[dut.scala 27:29]
      mul_a_reg <= io_mul_a; // @[dut.scala 29:15]
    end
    if (reset) begin // @[dut.scala 18:26]
      mul_b_reg <= 8'h0; // @[dut.scala 18:26]
    end else if (~io_rst_n) begin // @[dut.scala 23:30]
      mul_b_reg <= 8'h0; // @[dut.scala 26:15]
    end else if (io_mul_en_in) begin // @[dut.scala 27:29]
      mul_b_reg <= io_mul_b; // @[dut.scala 30:15]
    end
    partialProducts_0 <= {{8'd0}, _partialProducts_0_T_2}; // @[dut.scala 35:24]
    partialProducts_1 <= {{7'd0}, _partialProducts_1_T_2}; // @[dut.scala 35:24]
    partialProducts_2 <= {{6'd0}, _partialProducts_2_T_2}; // @[dut.scala 35:24]
    partialProducts_3 <= {{5'd0}, _partialProducts_3_T_2}; // @[dut.scala 35:24]
    partialProducts_4 <= {{4'd0}, _partialProducts_4_T_2}; // @[dut.scala 35:24]
    partialProducts_5 <= {{3'd0}, _partialProducts_5_T_2}; // @[dut.scala 35:24]
    partialProducts_6 <= {{2'd0}, _partialProducts_6_T_2}; // @[dut.scala 35:24]
    partialProducts_7 <= {{1'd0}, _partialProducts_7_T_2}; // @[dut.scala 35:24]
    accumulatedSum <= _GEN_12[15:0]; // @[dut.scala 20:{31,31} 39:18]
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
  mul_en_out_reg = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  mul_a_reg = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  mul_b_reg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  partialProducts_0 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  partialProducts_1 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  partialProducts_2 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  partialProducts_3 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  partialProducts_4 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  partialProducts_5 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  partialProducts_6 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  partialProducts_7 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  accumulatedSum = _RAND_11[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
