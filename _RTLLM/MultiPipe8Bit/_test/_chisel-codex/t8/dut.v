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
`endif // RANDOMIZE_REG_INIT
  reg [4:0] mul_en_out_reg; // @[dut.scala 14:31]
  wire [4:0] _mul_en_out_reg_T_1 = {mul_en_out_reg[3:0],io_mul_en_in}; // @[Cat.scala 33:92]
  reg [7:0] mul_a_reg; // @[dut.scala 18:26]
  reg [7:0] mul_b_reg; // @[dut.scala 19:26]
  wire [15:0] temp_0 = mul_b_reg[0] ? {{8'd0}, mul_a_reg} : 16'h0; // @[dut.scala 28:19]
  wire [8:0] _temp_1_T_1 = {mul_a_reg, 1'h0}; // @[dut.scala 28:52]
  wire [15:0] temp_1 = mul_b_reg[1] ? {{7'd0}, _temp_1_T_1} : 16'h0; // @[dut.scala 28:19]
  wire [9:0] _temp_2_T_1 = {mul_a_reg, 2'h0}; // @[dut.scala 28:52]
  wire [15:0] temp_2 = mul_b_reg[2] ? {{6'd0}, _temp_2_T_1} : 16'h0; // @[dut.scala 28:19]
  wire [10:0] _temp_3_T_1 = {mul_a_reg, 3'h0}; // @[dut.scala 28:52]
  wire [15:0] temp_3 = mul_b_reg[3] ? {{5'd0}, _temp_3_T_1} : 16'h0; // @[dut.scala 28:19]
  wire [11:0] _temp_4_T_1 = {mul_a_reg, 4'h0}; // @[dut.scala 28:52]
  wire [15:0] temp_4 = mul_b_reg[4] ? {{4'd0}, _temp_4_T_1} : 16'h0; // @[dut.scala 28:19]
  wire [12:0] _temp_5_T_1 = {mul_a_reg, 5'h0}; // @[dut.scala 28:52]
  wire [15:0] temp_5 = mul_b_reg[5] ? {{3'd0}, _temp_5_T_1} : 16'h0; // @[dut.scala 28:19]
  wire [13:0] _temp_6_T_1 = {mul_a_reg, 6'h0}; // @[dut.scala 28:52]
  wire [15:0] temp_6 = mul_b_reg[6] ? {{2'd0}, _temp_6_T_1} : 16'h0; // @[dut.scala 28:19]
  wire [14:0] _temp_7_T_1 = {mul_a_reg, 7'h0}; // @[dut.scala 28:52]
  wire [15:0] temp_7 = mul_b_reg[7] ? {{1'd0}, _temp_7_T_1} : 16'h0; // @[dut.scala 28:19]
  wire  stg1_en = mul_en_out_reg[0]; // @[dut.scala 32:31]
  wire  stg2_en = mul_en_out_reg[1]; // @[dut.scala 33:31]
  wire  stg3_en = mul_en_out_reg[2]; // @[dut.scala 34:31]
  wire  stg4_en = mul_en_out_reg[3]; // @[dut.scala 35:31]
  reg [15:0] sum1_0; // @[dut.scala 38:21]
  reg [15:0] sum1_1; // @[dut.scala 38:21]
  reg [15:0] sum1_2; // @[dut.scala 38:21]
  reg [15:0] sum1_3; // @[dut.scala 38:21]
  reg [15:0] sum2_0; // @[dut.scala 39:21]
  reg [15:0] sum2_1; // @[dut.scala 39:21]
  reg [15:0] sum3; // @[dut.scala 40:21]
  wire [16:0] _sum1_0_T = temp_0 + temp_1; // @[dut.scala 43:24]
  wire [16:0] _sum1_1_T = temp_2 + temp_3; // @[dut.scala 44:24]
  wire [16:0] _sum1_2_T = temp_4 + temp_5; // @[dut.scala 45:24]
  wire [16:0] _sum1_3_T = temp_6 + temp_7; // @[dut.scala 46:24]
  wire [16:0] _GEN_2 = stg1_en ? _sum1_0_T : {{1'd0}, sum1_0}; // @[dut.scala 42:17 43:13 38:21]
  wire [16:0] _GEN_3 = stg1_en ? _sum1_1_T : {{1'd0}, sum1_1}; // @[dut.scala 42:17 44:13 38:21]
  wire [16:0] _GEN_4 = stg1_en ? _sum1_2_T : {{1'd0}, sum1_2}; // @[dut.scala 42:17 45:13 38:21]
  wire [16:0] _GEN_5 = stg1_en ? _sum1_3_T : {{1'd0}, sum1_3}; // @[dut.scala 42:17 46:13 38:21]
  wire [16:0] _sum2_0_T = sum1_0 + sum1_1; // @[dut.scala 50:24]
  wire [16:0] _sum2_1_T = sum1_2 + sum1_3; // @[dut.scala 51:24]
  wire [16:0] _GEN_6 = stg2_en ? _sum2_0_T : {{1'd0}, sum2_0}; // @[dut.scala 49:17 50:13 39:21]
  wire [16:0] _GEN_7 = stg2_en ? _sum2_1_T : {{1'd0}, sum2_1}; // @[dut.scala 49:17 51:13 39:21]
  wire [16:0] _sum3_T = sum2_0 + sum2_1; // @[dut.scala 55:21]
  wire [16:0] _GEN_8 = stg3_en ? _sum3_T : {{1'd0}, sum3}; // @[dut.scala 54:17 55:10 40:21]
  reg [15:0] mul_out_reg; // @[dut.scala 59:28]
  wire [16:0] _GEN_10 = reset ? 17'h0 : _GEN_2; // @[dut.scala 38:{21,21}]
  wire [16:0] _GEN_11 = reset ? 17'h0 : _GEN_3; // @[dut.scala 38:{21,21}]
  wire [16:0] _GEN_12 = reset ? 17'h0 : _GEN_4; // @[dut.scala 38:{21,21}]
  wire [16:0] _GEN_13 = reset ? 17'h0 : _GEN_5; // @[dut.scala 38:{21,21}]
  wire [16:0] _GEN_14 = reset ? 17'h0 : _GEN_6; // @[dut.scala 39:{21,21}]
  wire [16:0] _GEN_15 = reset ? 17'h0 : _GEN_7; // @[dut.scala 39:{21,21}]
  wire [16:0] _GEN_16 = reset ? 17'h0 : _GEN_8; // @[dut.scala 40:{21,21}]
  assign io_mul_en_out = mul_en_out_reg[4]; // @[dut.scala 65:34]
  assign io_mul_out = io_mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 66:23]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg <= 5'h0; // @[dut.scala 14:31]
    end else begin
      mul_en_out_reg <= _mul_en_out_reg_T_1; // @[dut.scala 15:18]
    end
    if (reset) begin // @[dut.scala 18:26]
      mul_a_reg <= 8'h0; // @[dut.scala 18:26]
    end else if (io_mul_en_in) begin // @[dut.scala 20:22]
      mul_a_reg <= io_mul_a; // @[dut.scala 21:15]
    end
    if (reset) begin // @[dut.scala 19:26]
      mul_b_reg <= 8'h0; // @[dut.scala 19:26]
    end else if (io_mul_en_in) begin // @[dut.scala 20:22]
      mul_b_reg <= io_mul_b; // @[dut.scala 22:15]
    end
    sum1_0 <= _GEN_10[15:0]; // @[dut.scala 38:{21,21}]
    sum1_1 <= _GEN_11[15:0]; // @[dut.scala 38:{21,21}]
    sum1_2 <= _GEN_12[15:0]; // @[dut.scala 38:{21,21}]
    sum1_3 <= _GEN_13[15:0]; // @[dut.scala 38:{21,21}]
    sum2_0 <= _GEN_14[15:0]; // @[dut.scala 39:{21,21}]
    sum2_1 <= _GEN_15[15:0]; // @[dut.scala 39:{21,21}]
    sum3 <= _GEN_16[15:0]; // @[dut.scala 40:{21,21}]
    if (reset) begin // @[dut.scala 59:28]
      mul_out_reg <= 16'h0; // @[dut.scala 59:28]
    end else if (stg4_en) begin // @[dut.scala 60:17]
      mul_out_reg <= sum3; // @[dut.scala 61:17]
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
  mul_en_out_reg = _RAND_0[4:0];
  _RAND_1 = {1{`RANDOM}};
  mul_a_reg = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  mul_b_reg = _RAND_2[7:0];
  _RAND_3 = {1{`RANDOM}};
  sum1_0 = _RAND_3[15:0];
  _RAND_4 = {1{`RANDOM}};
  sum1_1 = _RAND_4[15:0];
  _RAND_5 = {1{`RANDOM}};
  sum1_2 = _RAND_5[15:0];
  _RAND_6 = {1{`RANDOM}};
  sum1_3 = _RAND_6[15:0];
  _RAND_7 = {1{`RANDOM}};
  sum2_0 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  sum2_1 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  sum3 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  mul_out_reg = _RAND_10[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
