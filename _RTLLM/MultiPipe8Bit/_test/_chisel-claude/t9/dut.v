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
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
`endif // RANDOMIZE_REG_INIT
  reg  mul_en_out_reg_0; // @[dut.scala 14:31]
  reg  mul_en_out_reg_1; // @[dut.scala 14:31]
  reg  mul_en_out_reg_2; // @[dut.scala 14:31]
  reg  mul_en_out_reg_3; // @[dut.scala 14:31]
  reg  mul_en_out_reg_4; // @[dut.scala 14:31]
  reg [7:0] mul_a_reg; // @[Reg.scala 35:20]
  reg [7:0] mul_b_reg; // @[Reg.scala 35:20]
  wire [7:0] temp_0 = mul_b_reg[0] ? mul_a_reg : 8'h0; // @[dut.scala 32:19]
  wire [8:0] _temp_1_T_1 = {mul_a_reg, 1'h0}; // @[dut.scala 32:44]
  wire [8:0] _temp_1_T_2 = mul_b_reg[1] ? _temp_1_T_1 : 9'h0; // @[dut.scala 32:19]
  wire [9:0] _temp_2_T_1 = {mul_a_reg, 2'h0}; // @[dut.scala 32:44]
  wire [9:0] _temp_2_T_2 = mul_b_reg[2] ? _temp_2_T_1 : 10'h0; // @[dut.scala 32:19]
  wire [10:0] _temp_3_T_1 = {mul_a_reg, 3'h0}; // @[dut.scala 32:44]
  wire [10:0] _temp_3_T_2 = mul_b_reg[3] ? _temp_3_T_1 : 11'h0; // @[dut.scala 32:19]
  wire [11:0] _temp_4_T_1 = {mul_a_reg, 4'h0}; // @[dut.scala 32:44]
  wire [11:0] _temp_4_T_2 = mul_b_reg[4] ? _temp_4_T_1 : 12'h0; // @[dut.scala 32:19]
  wire [12:0] _temp_5_T_1 = {mul_a_reg, 5'h0}; // @[dut.scala 32:44]
  wire [12:0] _temp_5_T_2 = mul_b_reg[5] ? _temp_5_T_1 : 13'h0; // @[dut.scala 32:19]
  wire [13:0] _temp_6_T_1 = {mul_a_reg, 6'h0}; // @[dut.scala 32:44]
  wire [13:0] _temp_6_T_2 = mul_b_reg[6] ? _temp_6_T_1 : 14'h0; // @[dut.scala 32:19]
  wire [14:0] _temp_7_T_1 = {mul_a_reg, 7'h0}; // @[dut.scala 32:44]
  wire [14:0] _temp_7_T_2 = mul_b_reg[7] ? _temp_7_T_1 : 15'h0; // @[dut.scala 32:19]
  reg [15:0] sum1; // @[dut.scala 36:21]
  reg [15:0] sum2; // @[dut.scala 37:21]
  reg [15:0] sum3; // @[dut.scala 38:21]
  reg [15:0] sum4; // @[dut.scala 39:21]
  wire [7:0] temp_1 = _temp_1_T_2[7:0]; // @[dut.scala 30:18 32:13]
  wire [8:0] _sum1_T = temp_0 + temp_1; // @[dut.scala 42:28]
  wire [7:0] temp_2 = _temp_2_T_2[7:0]; // @[dut.scala 30:18 32:13]
  wire [7:0] temp_3 = _temp_3_T_2[7:0]; // @[dut.scala 30:18 32:13]
  wire [8:0] _sum2_T = temp_2 + temp_3; // @[dut.scala 43:28]
  wire [7:0] temp_4 = _temp_4_T_2[7:0]; // @[dut.scala 30:18 32:13]
  wire [7:0] temp_5 = _temp_5_T_2[7:0]; // @[dut.scala 30:18 32:13]
  wire [8:0] _sum3_T = temp_4 + temp_5; // @[dut.scala 44:28]
  wire [7:0] temp_6 = _temp_6_T_2[7:0]; // @[dut.scala 30:18 32:13]
  wire [7:0] temp_7 = _temp_7_T_2[7:0]; // @[dut.scala 30:18 32:13]
  wire [8:0] _sum4_T = temp_6 + temp_7; // @[dut.scala 45:28]
  reg [15:0] sum5; // @[dut.scala 49:21]
  reg [15:0] sum6; // @[dut.scala 50:21]
  wire [16:0] _sum5_T = sum1 + sum2; // @[dut.scala 53:18]
  wire [16:0] _sum6_T = sum3 + sum4; // @[dut.scala 54:18]
  wire [16:0] _GEN_6 = mul_en_out_reg_1 ? _sum5_T : {{1'd0}, sum5}; // @[dut.scala 52:28 53:10 49:21]
  wire [16:0] _GEN_7 = mul_en_out_reg_1 ? _sum6_T : {{1'd0}, sum6}; // @[dut.scala 52:28 54:10 50:21]
  reg [15:0] sum7; // @[dut.scala 58:21]
  wire [16:0] _sum7_T = sum5 + sum6; // @[dut.scala 61:18]
  wire [16:0] _GEN_8 = mul_en_out_reg_2 ? _sum7_T : {{1'd0}, sum7}; // @[dut.scala 60:28 61:10 58:21]
  reg [15:0] mul_out_reg; // @[dut.scala 65:28]
  wire [16:0] _GEN_10 = reset ? 17'h0 : _GEN_6; // @[dut.scala 49:{21,21}]
  wire [16:0] _GEN_11 = reset ? 17'h0 : _GEN_7; // @[dut.scala 50:{21,21}]
  wire [16:0] _GEN_12 = reset ? 17'h0 : _GEN_8; // @[dut.scala 58:{21,21}]
  assign io_mul_en_out = mul_en_out_reg_4; // @[dut.scala 23:17]
  assign io_mul_out = io_mul_en_out ? mul_out_reg : 16'h0; // @[dut.scala 72:20]
  always @(posedge clock) begin
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg_0 <= 1'h0; // @[dut.scala 14:31]
    end else begin
      mul_en_out_reg_0 <= io_mul_en_in; // @[dut.scala 17:21]
    end
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg_1 <= 1'h0; // @[dut.scala 14:31]
    end else begin
      mul_en_out_reg_1 <= mul_en_out_reg_0; // @[dut.scala 19:23]
    end
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg_2 <= 1'h0; // @[dut.scala 14:31]
    end else begin
      mul_en_out_reg_2 <= mul_en_out_reg_1; // @[dut.scala 19:23]
    end
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg_3 <= 1'h0; // @[dut.scala 14:31]
    end else begin
      mul_en_out_reg_3 <= mul_en_out_reg_2; // @[dut.scala 19:23]
    end
    if (reset) begin // @[dut.scala 14:31]
      mul_en_out_reg_4 <= 1'h0; // @[dut.scala 14:31]
    end else begin
      mul_en_out_reg_4 <= mul_en_out_reg_3; // @[dut.scala 19:23]
    end
    if (reset) begin // @[Reg.scala 35:20]
      mul_a_reg <= 8'h0; // @[Reg.scala 35:20]
    end else if (io_mul_en_in) begin // @[Reg.scala 36:18]
      mul_a_reg <= io_mul_a; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      mul_b_reg <= 8'h0; // @[Reg.scala 35:20]
    end else if (io_mul_en_in) begin // @[Reg.scala 36:18]
      mul_b_reg <= io_mul_b; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[dut.scala 36:21]
      sum1 <= 16'h0; // @[dut.scala 36:21]
    end else if (mul_en_out_reg_0) begin // @[dut.scala 41:28]
      sum1 <= {{7'd0}, _sum1_T}; // @[dut.scala 42:10]
    end
    if (reset) begin // @[dut.scala 37:21]
      sum2 <= 16'h0; // @[dut.scala 37:21]
    end else if (mul_en_out_reg_0) begin // @[dut.scala 41:28]
      sum2 <= {{7'd0}, _sum2_T}; // @[dut.scala 43:10]
    end
    if (reset) begin // @[dut.scala 38:21]
      sum3 <= 16'h0; // @[dut.scala 38:21]
    end else if (mul_en_out_reg_0) begin // @[dut.scala 41:28]
      sum3 <= {{7'd0}, _sum3_T}; // @[dut.scala 44:10]
    end
    if (reset) begin // @[dut.scala 39:21]
      sum4 <= 16'h0; // @[dut.scala 39:21]
    end else if (mul_en_out_reg_0) begin // @[dut.scala 41:28]
      sum4 <= {{7'd0}, _sum4_T}; // @[dut.scala 45:10]
    end
    sum5 <= _GEN_10[15:0]; // @[dut.scala 49:{21,21}]
    sum6 <= _GEN_11[15:0]; // @[dut.scala 50:{21,21}]
    sum7 <= _GEN_12[15:0]; // @[dut.scala 58:{21,21}]
    if (reset) begin // @[dut.scala 65:28]
      mul_out_reg <= 16'h0; // @[dut.scala 65:28]
    end else if (mul_en_out_reg_3) begin // @[dut.scala 67:28]
      mul_out_reg <= sum7; // @[dut.scala 68:17]
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
  mul_en_out_reg_0 = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  mul_en_out_reg_1 = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  mul_en_out_reg_2 = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  mul_en_out_reg_3 = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  mul_en_out_reg_4 = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  mul_a_reg = _RAND_5[7:0];
  _RAND_6 = {1{`RANDOM}};
  mul_b_reg = _RAND_6[7:0];
  _RAND_7 = {1{`RANDOM}};
  sum1 = _RAND_7[15:0];
  _RAND_8 = {1{`RANDOM}};
  sum2 = _RAND_8[15:0];
  _RAND_9 = {1{`RANDOM}};
  sum3 = _RAND_9[15:0];
  _RAND_10 = {1{`RANDOM}};
  sum4 = _RAND_10[15:0];
  _RAND_11 = {1{`RANDOM}};
  sum5 = _RAND_11[15:0];
  _RAND_12 = {1{`RANDOM}};
  sum6 = _RAND_12[15:0];
  _RAND_13 = {1{`RANDOM}};
  sum7 = _RAND_13[15:0];
  _RAND_14 = {1{`RANDOM}};
  mul_out_reg = _RAND_14[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
