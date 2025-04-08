module dut(
  input         clock,
  input         reset,
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
  reg  mul_en_out_reg; // @[dut.scala 15:31]
  reg [7:0] mul_a_reg; // @[dut.scala 16:26]
  reg [7:0] mul_b_reg; // @[dut.scala 17:26]
  reg [15:0] partials_0; // @[dut.scala 20:21]
  reg [15:0] partials_1; // @[dut.scala 20:21]
  reg [15:0] partials_2; // @[dut.scala 20:21]
  reg [15:0] partials_3; // @[dut.scala 20:21]
  reg [15:0] partials_4; // @[dut.scala 20:21]
  reg [15:0] partials_5; // @[dut.scala 20:21]
  reg [15:0] partials_6; // @[dut.scala 20:21]
  reg [15:0] partials_7; // @[dut.scala 20:21]
  reg [15:0] sum; // @[dut.scala 21:16]
  wire [7:0] _GEN_3 = mul_b_reg[0] ? mul_a_reg : 8'h0; // @[dut.scala 34:17 35:24 36:19]
  wire [8:0] _partials_1_T = {mul_a_reg, 1'h0}; // @[dut.scala 36:32]
  wire [8:0] _GEN_4 = mul_b_reg[1] ? _partials_1_T : 9'h0; // @[dut.scala 34:17 35:24 36:19]
  wire [9:0] _partials_2_T = {mul_a_reg, 2'h0}; // @[dut.scala 36:32]
  wire [9:0] _GEN_5 = mul_b_reg[2] ? _partials_2_T : 10'h0; // @[dut.scala 34:17 35:24 36:19]
  wire [10:0] _partials_3_T = {mul_a_reg, 3'h0}; // @[dut.scala 36:32]
  wire [10:0] _GEN_6 = mul_b_reg[3] ? _partials_3_T : 11'h0; // @[dut.scala 34:17 35:24 36:19]
  wire [11:0] _partials_4_T = {mul_a_reg, 4'h0}; // @[dut.scala 36:32]
  wire [11:0] _GEN_7 = mul_b_reg[4] ? _partials_4_T : 12'h0; // @[dut.scala 34:17 35:24 36:19]
  wire [12:0] _partials_5_T = {mul_a_reg, 5'h0}; // @[dut.scala 36:32]
  wire [12:0] _GEN_8 = mul_b_reg[5] ? _partials_5_T : 13'h0; // @[dut.scala 34:17 35:24 36:19]
  wire [13:0] _partials_6_T = {mul_a_reg, 6'h0}; // @[dut.scala 36:32]
  wire [13:0] _GEN_9 = mul_b_reg[6] ? _partials_6_T : 14'h0; // @[dut.scala 34:17 35:24 36:19]
  wire [14:0] _partials_7_T = {mul_a_reg, 7'h0}; // @[dut.scala 36:32]
  wire [14:0] _GEN_10 = mul_b_reg[7] ? _partials_7_T : 15'h0; // @[dut.scala 34:17 35:24 36:19]
  wire [16:0] _sum_T = partials_0 + partials_1; // @[dut.scala 41:28]
  wire [16:0] _GEN_11 = {{1'd0}, partials_2}; // @[dut.scala 41:28]
  wire [17:0] _sum_T_1 = _sum_T + _GEN_11; // @[dut.scala 41:28]
  wire [17:0] _GEN_12 = {{2'd0}, partials_3}; // @[dut.scala 41:28]
  wire [18:0] _sum_T_2 = _sum_T_1 + _GEN_12; // @[dut.scala 41:28]
  wire [18:0] _GEN_13 = {{3'd0}, partials_4}; // @[dut.scala 41:28]
  wire [19:0] _sum_T_3 = _sum_T_2 + _GEN_13; // @[dut.scala 41:28]
  wire [19:0] _GEN_14 = {{4'd0}, partials_5}; // @[dut.scala 41:28]
  wire [20:0] _sum_T_4 = _sum_T_3 + _GEN_14; // @[dut.scala 41:28]
  wire [20:0] _GEN_15 = {{5'd0}, partials_6}; // @[dut.scala 41:28]
  wire [21:0] _sum_T_5 = _sum_T_4 + _GEN_15; // @[dut.scala 41:28]
  wire [21:0] _GEN_16 = {{6'd0}, partials_7}; // @[dut.scala 41:28]
  wire [22:0] _sum_T_6 = _sum_T_5 + _GEN_16; // @[dut.scala 41:28]
  assign io_mul_en_out = mul_en_out_reg; // @[dut.scala 44:17]
  assign io_mul_out = mul_en_out_reg ? sum : 16'h0; // @[dut.scala 45:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 15:31]
      mul_en_out_reg <= 1'h0; // @[dut.scala 15:31]
    end else begin
      mul_en_out_reg <= io_mul_en_in;
    end
    if (reset) begin // @[dut.scala 16:26]
      mul_a_reg <= 8'h0; // @[dut.scala 16:26]
    end else if (io_mul_en_in) begin // @[dut.scala 24:22]
      mul_a_reg <= io_mul_a; // @[dut.scala 26:15]
    end
    if (reset) begin // @[dut.scala 17:26]
      mul_b_reg <= 8'h0; // @[dut.scala 17:26]
    end else if (io_mul_en_in) begin // @[dut.scala 24:22]
      mul_b_reg <= io_mul_b; // @[dut.scala 27:15]
    end
    partials_0 <= {{8'd0}, _GEN_3};
    partials_1 <= {{7'd0}, _GEN_4};
    partials_2 <= {{6'd0}, _GEN_5};
    partials_3 <= {{5'd0}, _GEN_6};
    partials_4 <= {{4'd0}, _GEN_7};
    partials_5 <= {{3'd0}, _GEN_8};
    partials_6 <= {{2'd0}, _GEN_9};
    partials_7 <= {{1'd0}, _GEN_10};
    sum <= _sum_T_6[15:0]; // @[dut.scala 41:7]
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
  partials_0 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  partials_1 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  partials_2 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  partials_3 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  partials_4 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  partials_5 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  partials_6 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  partials_7 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  sum = _RAND_11[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
